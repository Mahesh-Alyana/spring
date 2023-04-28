class ProfileModel {
  String? name;
  String? id;
  String? email;
  double? amount;
  bool? merchant;
  bool? active;

  ProfileModel(
      {this.name,
      this.id,
      this.email,
      this.amount,
      this.merchant,
      this.active});
  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
    amount = json['amount'];
    merchant = json['merchant'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['email'] = this.email;
    data['amount'] = this.amount;
    data['merchant'] = this.merchant;
    data['active'] = this.active;
    return data;
  }
}
