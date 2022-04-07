class Add {
  int id;
  var categoryId;
  String title;
  String desc;
  String advertiserName;
  String phone;
  String phoneWhats;
  bool isImage;
  int status;
  String userId;
  String country;
  String lat;
  String lang;
  String images;
  String date;

  Add(
      {this.id,
        this.categoryId,
        this.title,
        this.desc,
        this.advertiserName,
        this.phone,
        this.phoneWhats,
        this.isImage,
        this.status,
        this.userId,
        this.country,
        this.lat,
        this.lang,
        this.images,
        this.date});

  Add.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    title = json['title'];
    desc = json['desc'];
    advertiserName = json['advertiserName'];
    phone = json['phone'];
    phoneWhats = json['phoneWhats'];
    isImage = json['isImage'];
    status = json['status'];
    userId = json['userId'];
    country = json['country'];
    lat = json['lat'];
    lang = json['lang'];
    images = json['images'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['advertiserName'] = this.advertiserName;
    data['phone'] = this.phone;
    data['phoneWhats'] = this.phoneWhats;
    data['isImage'] = this.isImage;
    data['status'] = this.status;
    data['userId'] = this.userId;
    data['country'] = this.country;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['images'] = this.images;
    data['date'] = this.date;
    return data;
  }
}


class ResponseAdds {
  List<Add> currentAdds;
  List<Add> unacceptableAdds;
  List<Add> spoonAdds;

  ResponseAdds({this.currentAdds, this.unacceptableAdds, this.spoonAdds});

  ResponseAdds.fromJson(Map<String, dynamic> json) {
    if (json['currentAdds'] != null) {
      currentAdds = [];
      json['currentAdds'].forEach((v) {
        currentAdds.add( Add.fromJson(v));
      });
    }
    if (json['unacceptableAdds'] != null) {
      unacceptableAdds = [];
      json['unacceptableAdds'].forEach((v) {
        unacceptableAdds.add(Add.fromJson(v));
      });
    }
    if (json['spoonAdds'] != null) {
      spoonAdds = [];
      json['spoonAdds'].forEach((v) {
        spoonAdds.add(Add.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currentAdds != null) {
      data['currentAdds'] = this.currentAdds.map((v) => v.toJson()).toList();
    }
    if (this.unacceptableAdds != null) {
      data['unacceptableAdds'] =
          this.unacceptableAdds.map((v) => v.toJson()).toList();
    }
    if (this.spoonAdds != null) {
      data['spoonAdds'] = this.spoonAdds.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



