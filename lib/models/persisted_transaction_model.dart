class PersistedTransactionModel {
  String? cardCode;
  String? currency;
  double? total;
  List<Item>? items;

  PersistedTransactionModel(
      {this.cardCode, this.currency, this.total, this.items});

  PersistedTransactionModel.fromJson(Map<String, dynamic> json) {
    cardCode = json['cardCode'];
    currency = json['currency'];
    total = json['total'];
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardCode'] = this.cardCode;
    data['currency'] = this.currency;
    data['total'] = this.total;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  String? itemCode;
  double? price;
  double? quantity;

  Item({this.itemCode, this.price, this.quantity});

  Item.fromJson(Map<String, dynamic> json) {
    itemCode = json['ItemCode'];
    price = json['Price'];
    quantity = json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemCode'] = this.itemCode;
    data['Price'] = this.price;
    data['Quantity'] = this.quantity;
    return data;
  }
}
