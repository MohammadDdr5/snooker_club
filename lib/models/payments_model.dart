class PaymentsModel {
  String? losername;
  String? loserplayedtime;
  String? loserpayprice;
  String? tablename;
  PaymentsModel({
    required this.losername,
    required this.loserpayprice,
    required this.loserplayedtime,
    required this.tablename,
  });

  Map<String, dynamic> toJson() {
    return {
      'losername': losername,
      'loserprice': loserpayprice,
      'loserplayedtime': loserplayedtime,
      'tablename': tablename
    };
  }

  PaymentsModel.fromjson(Map<String, dynamic> json)
      : losername = json['losername'],
        loserpayprice = json['loserprice'],
        loserplayedtime = json['loserplayedtime'],
        tablename = json['tablename'];
}
