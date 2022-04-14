class LoginResponseModel {
  String? refresh;
  String? access;

  LoginResponseModel({this.refresh, this.access});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        refresh: json['refresh'],
        access: json['access'],
      );

  Map<String, dynamic> toJson() => {
        'refresh': refresh,
        'access': access,
      };
}
