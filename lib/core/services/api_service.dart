import 'package:dio/dio.dart';
import 'package:ecommerce_getx_folderstructure/core/services/connectivity_service.dart';
import 'package:ecommerce_getx_folderstructure/widgets/no_internet_widget.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../storage/storage_service.dart';

class ApiService {
  final Dio _dio = Dio();
  final StorageService storageService = Get.find();
  final ConnectivityService connectivityService = Get.find();
ApiService() {
    _dio.options.baseUrl = AppConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = storageService.getUserToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        // Check connectivity before request
        if (!await connectivityService.checkConnection()) {
          Get.dialog(
            const NoInternetWidget(),
            barrierDismissible: false,
          );
          return handler.reject(
            DioException(
              requestOptions: options,
              error: 'No internet connection',
            ),
          );
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          Get.snackbar( 'Session expired. Please login again.');
          storageService.removeUserToken();
          Get.offAllNamed('/login');
        } else if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          // Show no internet widget for slow connection
          Get.dialog(
            NoInternetWidget(
              onRetry: () async {
                if (await connectivityService.checkConnection()) {
                  Get.back();
                  // Retry the request
                  try {
                    final response = await _dio.request(
                      e.requestOptions.path,
                      data: e.requestOptions.data,
                      queryParameters: e.requestOptions.queryParameters,
                      options: Options(
                        method: e.requestOptions.method,
                        headers: e.requestOptions.headers,
                      ),
                    );
                    // Resolve the retry response
                    handler.resolve(response);
                  } catch (retryError) {
                    handler.reject(DioException(
                      requestOptions: e.requestOptions,
                      error: retryError,
                    ));
                  }
                }
              },
            ),
            barrierDismissible: false,
          );
        }
        return handler.next(e);
      },
    ));
  }

  // Login
  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      return response.data['token'];
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Fetch products
  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      return (response.data as List)
          .map((e) => Product.fromMap(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch products: ${e.toString()}');
    }
  }

  // Fetch single product
  Future<Product> getProduct(String id) async {
    try {
      final response = await _dio.get('/products/$id');
      return Product.fromMap(response.data);
    } catch (e) {
      throw Exception('Failed to fetch product: ${e.toString()}');
    }
  }

  // Fetch orders
  Future<List<Order>> getOrders() async {
    try {
      final response = await _dio.get('/orders');
      return (response.data as List)
          .map((e) => Order.fromMap(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch orders: ${e.toString()}');
    }
  }

  // Add to cart (server-side, if needed)
  Future<void> addToCart(String productId, int quantity) async {
    try {
      await _dio.post(
        '/cart',
        data: {'productId': productId, 'quantity': quantity},
      );
    } catch (e) {
      throw Exception('Failed to add to cart: ${e.toString()}');
    }
  }
}