class placeReviews {
  bool? success;
  String? error;
  Body? body;

  placeReviews({this.success, this.error, this.body});

  placeReviews.fromJson(Map<String, dynamic> json) {
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
  List<PlaceReviews>? placeReviews;

  Body({this.placeReviews});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['placeReviews'] != null) {
      placeReviews = <PlaceReviews>[];
      json['placeReviews'].forEach((v) {
        placeReviews!.add(new PlaceReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.placeReviews != null) {
      data['placeReviews'] = this.placeReviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlaceReviews {
  int? id;
  String? userID;
  String? placeID;
  String? review;
  String? rating;
  String? createdAt;
  String? updatedAt;
  User? user;

  PlaceReviews(
      {this.id,
        this.userID,
        this.placeID,
        this.review,
        this.rating,
        this.createdAt,
        this.updatedAt,
        this.user});

  PlaceReviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    placeID = json['placeID'];
    review = json['review'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['placeID'] = this.placeID;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;

  User({this.id, this.username});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}
