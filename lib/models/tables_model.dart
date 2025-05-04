class TablesModel {
  String? name;
  String? price;
  bool? status;
  String? time;
  String? playerone;
  String? playertwo;

  TablesModel({
    required this.name,
    required this.price,
    required this.status,
    required this.time,
    required this.playerone,
    required this.playertwo,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'status': status,
      'time': time,
      'playerone': playerone,
      'playertwo': playertwo,
    };
  }

  TablesModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        status = json['status'],
        time = json['time'],
        playerone = json['playerone'],
        playertwo = json['playertwo'];
}
