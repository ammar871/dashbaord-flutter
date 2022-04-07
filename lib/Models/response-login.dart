class ResponseLogin {
  String token;
  UserModel user;
  List<String> userRoles;
  String expiration;

  ResponseLogin({this.token, this.user, this.userRoles, this.expiration});

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    userRoles = json['userRoles'].cast<String>();
    expiration = json['expiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['userRoles'] = this.userRoles;
    data['expiration'] = this.expiration;
    return data;
  }
}

class UserModel {
  String id;
  String userName;
  String fullName;
  var imageUrl;
  var status;
  String role;
  var accessFailedCount;

  UserModel(
      {this.id,
        this.userName,
        this.fullName,
        this.imageUrl,
        this.status,
        this.role,
        this.accessFailedCount});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    fullName = json['fullName'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    role = json['role'];
    accessFailedCount = json['accessFailedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['imageUrl'] = this.imageUrl;
    data['status'] = this.status;
    data['role'] = this.role;
    data['accessFailedCount'] = this.accessFailedCount;
    return data;
  }
}
