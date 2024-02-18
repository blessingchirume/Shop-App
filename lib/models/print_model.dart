class PrintModel {
  int? number;
  String? date;
  String? dueDate;
  String? userName;
  String? userLocation;
  String? userEmail;
  Client? client;
  List<Items>? items;

  PrintModel(
      {this.number,
      this.date,
      this.dueDate,
      this.userName,
      this.userLocation,
      this.userEmail,
      this.client,
      this.items});

  PrintModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    date = json['date'];
    dueDate = json['dueDate'];
    userName = json['userName'];
    userLocation = json['userLocation'];
    userEmail = json['userEmail'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['date'] = this.date;
    data['dueDate'] = this.dueDate;
    data['userName'] = this.userName;
    data['userLocation'] = this.userLocation;
    data['userEmail'] = this.userEmail;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Client {
  String? name;
  String? address;
  String? email;

  Client({this.name, this.address, this.email});

  Client.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['email'] = this.email;
    return data;
  }
}

class Items {
  String? name;
  double? rate;
  int? hours;

  Items({this.name, this.rate, this.hours});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rate = json['rate'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['hours'] = this.hours;
    return data;
  }
}
