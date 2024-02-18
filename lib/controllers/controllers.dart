import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants/api_constants.dart';
import 'package:shop_app/constants/routing_constants.dart';
import 'package:shop_app/models/stock_transfer.dart';
import 'package:shop_app/screens/login_page/controllers/auth_controller.dart';
import 'package:shop_app/services/api_pipeline_service.dart';
import 'package:shop_app/shared/models/response.dart';

class BaseController {
  Future<List<TransferModel>> getPendingTransfers() async {
    List<TransferModel> products = [];
    var response =
        await ApiPipelineService().pipelineGet(ApiConstants.transfer);
    var data = ResponseModel.fromJson((jsonDecode(response.body)));
    var productList = (jsonDecode(response.body))['success'];
    if (products.isEmpty) {
      for (var element in productList) {
        products.add(TransferModel.fromJson(element));
      }
    }
    return products;
  }

  Future<dynamic> transfers() async {
    var response =
        await ApiPipelineService().pipelineGet(ApiConstants.transfer);
    var data = jsonDecode(response.body)['success'];

    return data;
  }

  Future<Map<String, dynamic>> getBranchProducts() async {
    var response =
        await ApiPipelineService().pipelineGet(ApiConstants.productList);
    Map<String, dynamic> data = jsonDecode(response.body);

    return data;
  }

  Future<List> getBranchProductsFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = prefs.getString('products');

    List<dynamic> data = jsonDecode(response);

    return data;
  }

  Future<bool> confirmTransfer(Map<String, dynamic> data) async {
    var response = await ApiPipelineService()
        .pipelinePost(ApiConstants.confirmPendingTransfer, data);

    if (response.statusCode != 200) return false;

    return true;
  }

  Future<bool> rejectTransfer(Map<String, dynamic> data) async {
    var response = await ApiPipelineService()
        .pipelinePost(ApiConstants.rejectPendingTransfer, data);

    if (response.statusCode != 200) return false;

    return true;
  }

  Future<bool> initiateTransfer(Map<String, dynamic> data) async {
    // if (email.isEmpty || password.isEmpty) return false;

    var response = await ApiPipelineService()
        .pipelinePost(ApiConstants.initiateTransfer, data);

    var body = response.body;

    if (response.statusCode != 200) return false;
    // var user = UserModel.fromJson(jsonDecode(response.body));
    var token = jsonDecode(response.body)['success'];
    // saveAuthToken(token);
    // saveUserData(user);

    return true;
  }

  Future<bool> placeOrder(Map<String, dynamic> data) async {
    var response =
        await ApiPipelineService().pipelinePost(ApiConstants.order, data);

    if (response.statusCode != 200) return false;

    return true;
  }
}
