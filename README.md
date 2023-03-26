 Photo? photo;
  City? city;
  Country? country;

  Items({this.photo, this.city, this.country});

  Items.fromJson(Map<String, dynamic> json) {
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.photo != null) {
      data['photo'] = this.photo!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    return data;
  }
