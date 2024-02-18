class ResponseModel {
  late dynamic success;
  late dynamic error;

  ResponseModel({required this.success, required this.error});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['success'] = success;
    data['error'] = error;
    return data;
  }
}