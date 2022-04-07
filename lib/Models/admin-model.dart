class Admin {
  String fullName;
  String role;
  String createdAt;
  String id;
  String userName;
  String normalizedUserName;
  String email;

  int accessFailedCount;

  Admin(
      {this.fullName,
      this.role,
      this.createdAt,
      this.id,
      this.userName,
      this.email,
      this.accessFailedCount});

  Admin.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    role = json['role'];
    createdAt = json['createdAt'];
    id = json['id'];
    userName = json['userName'];
    normalizedUserName = json['normalizedUserName'];
    email = json['email'];
    accessFailedCount = json['accessFailedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['normalizedUserName'] = this.normalizedUserName;
    data['email'] = this.email;
    data['accessFailedCount'] = this.accessFailedCount;
    return data;
  }
}
