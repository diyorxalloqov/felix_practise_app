class Registermodel {
  String? message;
  String? accessToken;

  Registermodel({this.message, this.accessToken});

  Registermodel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['accessToken'] = accessToken;
    return data;
  }
}
