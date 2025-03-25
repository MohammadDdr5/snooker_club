class TablesModel {
  String? name;
  String? price;
  bool? status;
  String? time;

  TablesModel({
    required this.name,
    required this.price,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'status': status, 'time': time};
  }

  TablesModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        status = json['status'],
        time = json['time'];
}
