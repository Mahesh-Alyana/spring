class ProfileEntity {
  int? id;
  String? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? typeOfAccount;
  bool? card;
  int? amount;

  ProfileEntity(
      {this.id,
      this.userId,
      this.email,
      this.firstName,
      this.lastName,
      this.typeOfAccount,
      this.card,
      this.amount});

  ProfileEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    typeOfAccount = json['type_of_account'];
    card = json['card'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['type_of_account'] = this.typeOfAccount;
    data['card'] = this.card;
    data['amount'] = this.amount;
    return data;
  }
}
