class PaymentsModel {
  String? losername;
  String? loserplayedtime;
  String? loserpayprice;
  String? tablename;
  bool? ispaid = false;
  String? paymentdatetime;

  PaymentsModel({
    required this.losername,
    required this.loserpayprice,
    required this.loserplayedtime,
    required this.tablename,
    required this.ispaid,
    required this.paymentdatetime,
  });

  Map<String, dynamic> toJson() {
    return {
      'losername': losername,
      'loserprice': loserpayprice,
      'loserplayedtime': loserplayedtime,
      'tablename': tablename,
      'ispaid': ispaid,
      'paymentdatetime': paymentdatetime,
    };
  }

  PaymentsModel.fromjson(Map<String, dynamic> json)
      : losername = json['losername'],
        loserpayprice = json['loserprice'],
        loserplayedtime = json['loserplayedtime'],
        tablename = json['tablename'],
        ispaid = json['ispaid'],
        paymentdatetime = json['paymentdatetime'];
}
