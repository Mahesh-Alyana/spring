class SignUpRequestModel {
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? rePassword;

  SignUpRequestModel({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.rePassword,
  });

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) =>
      SignUpRequestModel(
        email: json['email'] as String?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        password: json['password'] as String?,
        rePassword: json['re_password'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
        're_password': rePassword,
      };
}
