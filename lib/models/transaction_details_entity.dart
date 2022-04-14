class TransactionDetailsEntity {
  String? merchantName;
  int? merchant;
  int? amount;
  String? transectionId;
  String? modified;

  TransactionDetailsEntity(
      {this.merchantName,
      this.merchant,
      this.amount,
      this.transectionId,
      this.modified});

  TransactionDetailsEntity.fromJson(Map<String, dynamic> json) {
    merchantName = json['merchant_name'];
    merchant = json['merchant'];
    amount = json['amount'];
    transectionId = json['transection_id'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchant_name'] = this.merchantName;
    data['merchant'] = this.merchant;
    data['amount'] = this.amount;
    data['transection_id'] = this.transectionId;
    data['modified'] = this.modified;
    return data;
  }
}
