class ApiUserModel {
  User? user;
  String? accessToken;

  ApiUserModel({this.user, this.accessToken});

  ApiUserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    return data;
  }
}

class User {
  int? id;
  int? branchId;
  String? name;
  String? email;
  String? sapToken;
  String? createdAt;
  String? updatedAt;
  Branch? branch;

  User(
      {this.id,
      this.branchId,
      this.name,
      this.email,
      this.sapToken,
      this.createdAt,
      this.updatedAt,
      this.branch});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    name = json['name'];
    email = json['email'];
    sapToken = json['sap_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    branch =
        json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['sap_token'] = this.sapToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    return data;
  }
}

class Branch {
  int? id;
  String? warehouseCode;
  String? warehouseDescription;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;

  Branch(
      {this.id,
      this.warehouseCode,
      this.warehouseDescription,
      this.createdAt,
      this.updatedAt,
      this.items});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouseCode = json['WarehouseCode'];
    warehouseDescription = json['WarehouseDescription'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['WarehouseCode'] = this.warehouseCode;
    data['WarehouseDescription'] = this.warehouseDescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  String? itemCode;
  String? itemDescription;
  String? imageUrl;
  double? price;
  String? createdAt;
  String? updatedAt;

  Items(
      {this.id,
      this.itemCode,
      this.itemDescription,
      this.imageUrl,
      this.price,
      this.createdAt,
      this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemCode = json['item_code'];
    itemDescription = json['item_description'];
    imageUrl = json['image_url'];
    price = double.parse(json['price'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_code'] = this.itemCode;
    data['item_description'] = this.itemDescription;
    data['image_url'] = this.imageUrl;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
