import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/controllers/controllers.dart';
import 'package:shop_app/screens/login_page/models/api_user_model.dart';
import 'package:shop_app/screens/login_page/models/user_model.dart';
import 'package:shop_app/services/api_pipeline_service.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationController {
  // final _storage = const FlutterSecureStorage();

  Future<bool> auth(String email, String password) async {
    if (email.isEmpty || password.isEmpty) return false;

    var response = await ApiPipelineService().auth({
      "email": email,
      "password": password,
    });

    if (response.statusCode != 200) return false;
    var user = ApiUserModel.fromJson(jsonDecode(response.body)['success']);

    saveAuthToken(user.accessToken!);
    saveUserData(user);
    saveProductsToSharedPreferences();

    return true;
  }

  Future<bool> register(String name, String email, String password) async {
    if (email.isEmpty || password.isEmpty) return false;

    var response = await ApiPipelineService().register({
      "name": email,
      "email": email,
      "phone": '0783123520',
      "password": password,
    });

    if (response.statusCode != 200) return false;
    var user = ApiUserModel.fromJson(jsonDecode(response.body)['success']);

    saveAuthToken(user.accessToken!);
    saveUserData(user);
    saveProductsToSharedPreferences();

    return true;
  }

  Future<bool> logout(Map<String, String> data) async {
    return true;
  }

  Future<bool> passwordReset(Map<String, String> data) async {
    return true;
  }

  void saveAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<String> retrieveAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<ApiUserModel> retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = ApiUserModel.fromJson(jsonDecode(prefs.getString('userData')));
    return data;
  }

  void saveUserData(ApiUserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', jsonEncode(user));
  }

  void saveProductsToSharedPreferences() async {
    var products = await BaseController().getBranchProducts();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('products', jsonEncode(products['success']));
  }
}
