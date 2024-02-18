class TransferModel {
  int? id;
  int? series;
  String? journalMemo;
  String? fromWarehouse;
  String? toWarehouse;
  List<StockTransferLines>? stockTransferLines;

  TransferModel(
      {required this.id,
      this.series,
      this.journalMemo,
      this.fromWarehouse,
      this.toWarehouse,
      this.stockTransferLines});

  TransferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    series = json['Series'];
    journalMemo = json['JournalMemo'];
    fromWarehouse = json['FromWarehouse'];
    toWarehouse = json['ToWarehouse'];
    if (json['StockTransferLines'] != null) {
      stockTransferLines = <StockTransferLines>[];
      json['StockTransferLines'].forEach((v) {
        stockTransferLines!.add(new StockTransferLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['series'] = this.series;
    data['journalMemo'] = this.journalMemo;
    data['fromWarehouse'] = this.fromWarehouse;
    data['toWarehouse'] = this.toWarehouse;
    if (this.stockTransferLines != null) {
      data['stockTransferLines'] =
          this.stockTransferLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockTransferLines {
  String? itemCode;
  int? quantity;
  String? warehouseCode;
  double? unitPrice;
  double? price;
  String? currency;
  String? fromWarehouseCode;
  // List<Null>? batchNumbers;

  StockTransferLines({
    this.itemCode,
    this.quantity,
    this.warehouseCode,
    this.unitPrice,
    this.price,
    this.currency,
    this.fromWarehouseCode,
    // this.batchNumbers
  });

  StockTransferLines.fromJson(Map<String, dynamic> json) {
    itemCode = json['ItemCode'];
    quantity = int.parse(json['Quantity']);
    warehouseCode = json['WarehouseCode'];
    unitPrice = double.parse(json['UnitPrice']);
    price = double.parse(json['Price']);
    currency = json['Currency'];
    fromWarehouseCode = json['FromWarehouseCode'];
    // if (json['batchNumbers'] != null) {
    //   batchNumbers = <Null>[];
    //   json['batchNumbers'].forEach((v) {
    //     batchNumbers!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemCode'] = this.itemCode;
    data['quantity'] = this.quantity;
    data['warehouseCode'] = this.warehouseCode;
    data['unitPrice'] = this.unitPrice;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['fromWarehouseCode'] = this.fromWarehouseCode;
    // if (this.batchNumbers != null) {
    //   data['batchNumbers'] = this.batchNumbers!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
