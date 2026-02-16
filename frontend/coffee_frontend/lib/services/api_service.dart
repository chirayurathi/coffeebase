import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8000/api/',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3),
  ));

  ApiService() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  // Auth
  Future<Response> login(String email, String password) {
    return dio.post('auth/login/', data: {'email': email, 'password': password});
  }

  // Recipes
  Future<Response> getRecipes() => dio.get('recipes/');
  Future<Response> createRecipe(Map<String, dynamic> data) => dio.post('recipes/', data: data);

  // Beans
  Future<Response> getBeans() => dio.get('beans/');
  Future<Response> createBean(Map<String, dynamic> data) => dio.post('beans/', data: data);

  // Posts
  Future<Response> getPosts() => dio.get('posts/');
  Future<Response> createPost(FormData data) => dio.post('posts/', data: data);
}
