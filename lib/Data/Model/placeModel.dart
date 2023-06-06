class responsePlacesModel {
  bool? success;
  Null? error;
  Body? body;

  responsePlacesModel({this.success, this.error, this.body});

  responsePlacesModel.fromJson(Map<String, dynamic> json) {
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
  List<Places>? places;

  Body({this.places});

  Body.fromJson(Map<String, dynamic> json) {
    if (json['places'] != null) {
      places = <Places>[];
      json['places'].forEach((v) {
        places!.add(new Places.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.places != null) {
      data['places'] = this.places!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Places {
  int? id;
  String? title;
  String? description;
  String? latitude;
  String? longitude;
  String? city;
  String? timing;
  String? address;
  String? imageUrl;
  Null? thumbnail;
  String? ratingAvg;
  String? createdAt;
  String? updatedAt;
  List<PlaceImages>? placeImages;
  List<PlaceReview>? placeReview;

  Places(
      {this.id,
        this.title,
        this.description,
        this.latitude,
        this.longitude,
        this.city,
        this.timing,
        this.address,
        this.imageUrl,
        this.thumbnail,
        this.ratingAvg,
        this.createdAt,
        this.updatedAt,
        this.placeImages,
        this.placeReview});

  Places.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    timing = json['timing'];
    address = json['address'];
    imageUrl = json['image_url'];
    thumbnail = json['thumbnail'];
    ratingAvg = json['rating_avg'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['place_images'] != null) {
      placeImages = <PlaceImages>[];
      json['place_images'].forEach((v) {
        placeImages!.add(new PlaceImages.fromJson(v));
      });
    }
    if (json['place_review'] != null) {
      placeReview = <PlaceReview>[];
      json['place_review'].forEach((v) {
        placeReview!.add(new PlaceReview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['city'] = this.city;
    data['timing'] = this.timing;
    data['address'] = this.address;
    data['image_url'] = this.imageUrl;
    data['thumbnail'] = this.thumbnail;
    data['rating_avg'] = this.ratingAvg;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.placeImages != null) {
      data['place_images'] = this.placeImages!.map((v) => v.toJson()).toList();
    }
    if (this.placeReview != null) {
      data['place_review'] = this.placeReview!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlaceImages {
  int? id;
  String? placeID;
  String? placeImageUrl;
  String? thumbnail;
  String? createdAt;
  String? updatedAt;

  PlaceImages(
      {this.id,
        this.placeID,
        this.placeImageUrl,
        this.thumbnail,
        this.createdAt,
        this.updatedAt});

  PlaceImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeID = json['placeID'];
    placeImageUrl = json['place_image_url'];
    thumbnail = json['thumbnail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['placeID'] = this.placeID;
    data['place_image_url'] = this.placeImageUrl;
    data['thumbnail'] = this.thumbnail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PlaceReview {
  int? id;
  String? userID;
  String? placeID;
  String? review;
  String? rating;
  String? createdAt;
  String? updatedAt;
  User? user;

  PlaceReview(
      {this.id,
        this.userID,
        this.placeID,
        this.review,
        this.rating,
        this.createdAt,
        this.updatedAt,
        this.user});

  PlaceReview.fromJson(Map<String, dynamic> json) {
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
