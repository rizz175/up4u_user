class userResponseModel {
  bool? success;
  String? error;
  Body? body;

  userResponseModel({this.success, this.error, this.body});

  userResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Body {
  String? accessToken;
  UserInfo? userInfo;

  Body({this.accessToken, this.userInfo});

  Body.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  int? id;
  String? username;
  String? email;
  String? roleId;
  String? createdAt;
  String? updatedAt;

  UserInfo(
      {this.id,
        this.username,
        this.email,
        this.roleId,
        this.createdAt,
        this.updatedAt});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
