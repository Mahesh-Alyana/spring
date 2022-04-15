class PaymentModel {
  String? mesage;
  String? payment;

  PaymentModel({this.mesage, this.payment});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    mesage = json['mesage'];
    payment = json['payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mesage'] = this.mesage;
    data['payment'] = this.payment;
    return data;
  }
}
