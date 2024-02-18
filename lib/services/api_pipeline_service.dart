import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants/api_constants.dart';
import 'package:shop_app/screens/login_page/controllers/auth_controller.dart';

class ApiPipelineService {
  Future<Map<String, String>?> setHeader() async {
    final headers = {
      "accept": ApiConstants.acceptType,
      "content-type": ApiConstants.contentType,
      "Authorization": await AuthenticationController().retrieveAuthToken(),
      // "Authorization":
      //     "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzEyNmFiZjBiZDVhNTg3NWEzZmRkMTBkNzA3MmFiNjBhMzlkZTgxOTYwODJlMTJlN2YxNjgxYzFkOWVmYThkNzliNzhjMTNkMWJlNTVhYmYiLCJpYXQiOjE3MDY4NDQ3MDcuNzg4NjksIm5iZiI6MTcwNjg0NDcwNy43ODg2OTYsImV4cCI6MTczODQ2NzEwNy43ODAyMTEsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.mDMoun6IadjyCI7V2Jhz3teEQ3UBfbdzgvgqO1ftjGN-rFCXncdrZEX3pcLjkRoqKC04nO5w89d6_RJF1wliAYt3mHjkfJIO8OlAZi-EKO-lCIzdO1Ap0rtrz8aD-Qo5SFbtS7G4QxLa4PEouARt1iE_3OO4KUAORzvUyXC0LhwfkAWdk10i_TC1i7tUDbM0t3SgYWj3H-dgwUyeOL4TsSq174GlUT-FO0kEZ2dhGn6jyB6GjDiPo92nTeUYFTBJv--4N49FexMfQyZkq9WXO5wJfvKP0q2u2h_w4cTNZOKqfEISFVlv8twgyFp7B2xXiPyXYnOdkTI2EJ5cWo8Bh7MKpgSbxA_vmFpT4el_65Xwlpo-HJjs-i14eRFwvaLztF9tK295J8FcXhyaSb2MSjyEAA7tjKJEQv0K5CgnlNaRvFzfsPxQzwwQCEUOFCuwocPu6EuIhhU3ivnLO8xNWik4NDz6fe56QMeBVunbqzso1hZ7D0VHuQYjkJ0XyWdriQ1UI6HnBqAf5PDWsE8t0SHwPRLkt-JIgsxU8iaf5DO-UGTK-J6bOK75pb4wzE8vaC8NlufeOKyGqjx0TXqaZYaQAyslwvivM2xItOL0aMejhPVtsVlY6hDH_BtI4SPb74C4CWl3sVkM-kYNda57o_uGCesa3_zZEmr8RMSrP64",
    };

    return headers;
  }

  Future<http.Response> auth(Map<String, String> data) async {
    return await http.post(
      Uri.parse(ApiConstants.auth),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
  }

    Future<http.Response> register(Map<String, String> data) async {
    return await http.post(
      Uri.parse(ApiConstants.register),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
  }

  Future<http.Response> get(Map<String, String> data) async {
    return await http.get(
      Uri.parse(ApiConstants.productList),
      headers: await setHeader(),
    );
  }

  Future<http.Response> getAll() async {
    return await http.get(
      Uri.parse(ApiConstants.productList),
      headers: await setHeader(),
    );
  }

  Future<http.Response> pipelineGet(String url) async {
    return await http.get(
      Uri.parse(url),
      headers: await setHeader(),
    );
  }

  Future<http.Response> pipelinePost(
      String url, Map<String, dynamic> data) async {
    return await http.post(Uri.parse(url),
        headers: await setHeader(), body: jsonEncode(data));
  }
}
