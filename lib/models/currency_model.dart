class CurrencyModel {
  int? id;
  String? code;
  String? description;
  double? rate;

  CurrencyModel({this.id, this.code, this.description, this.rate});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    rate = double.parse(json['rate'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['description'] = this.description;
    data['rate'] = this.rate;
    return data;
  }
}
