class ApiConstants {
  
  static const String acceptType = "application/json";

  static const String contentType = "application/json";

  static const String baseUrl = "http://192.168.1.103:8000/api";

  static String auth = baseUrl + '/login';

  static String register = baseUrl + '/register';

  static String fireBaseToken = baseUrl + "/user/firebase";

  static String shopList = baseUrl + "/shops/list";

  static String userDetails = baseUrl + "/user";

  static String updateUserDetails = baseUrl + "/user/update";

  static String productList = baseUrl + "/products";

  static String order = baseUrl + "/place-order";

  static String transfer = baseUrl + "/pending-transfers";

  static String initiateTransfer = baseUrl + "/initiate-transfer";

  static String confirmPendingTransfer = baseUrl + "/confirm-transfer";

  static String rejectPendingTransfer = baseUrl + "/reject-transfer";

  static String orderItems = baseUrl + "/order/items";

  static String addToCart = baseUrl + "/orders/add";

  static String makePayment = baseUrl + "/make-payment";

  static String sendCancellationRequest = baseUrl + "/send-cancellation-request";
}
