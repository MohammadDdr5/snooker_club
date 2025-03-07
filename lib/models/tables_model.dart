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

  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'price': price,
      'status': status,
    };
  }

  TablesModel.fromjson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        status = json['status'];
}
