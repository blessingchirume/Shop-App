class UserModel {
  late User user;
  late List<Shops> shops;
  late String accessToken;
  late String tokenType;
  late int expiresIn;

  UserModel(
      {required this.user,
      required this.shops,
      required this.accessToken,
      required this.tokenType,
      required this.expiresIn});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = (json['user'] != null ? User.fromJson(json['user']) : null)!;
    if (json['shops'] != null) {
      shops = [];
      json['shops'].forEach((v) {
        shops.add(Shops.fromJson(v));
      });
    }
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user.toJson();
    data['shops'] = shops.map((v) => v.toJson()).toList();
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    return data;
  }
}

class User {
  late int id;
  late String name;
  late String surname;
  late String role;

  User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['role'] = role;
    return data;
  }
}

class Shops {
  late int id;
  late String name;
  late String address;
  late String email;
  late String phone;

  Shops(
      {required this.id,
      required this.name,
      required this.address,
      required this.email,
      required this.phone});

  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
