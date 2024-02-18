import 'package:flutter/cupertino.dart';
import 'package:shop_app/screens/login_page/controllers/auth_controller.dart';
import 'package:shop_app/screens/login_page/models/api_user_model.dart';

class UserProvider with ChangeNotifier {
  ApiUserModel _user = ApiUserModel();

  ApiUserModel get user => _user;

  Future<void> getUserData() async {
    _user = await AuthenticationController().retrieveUserData();
    // return data;
  }
}
