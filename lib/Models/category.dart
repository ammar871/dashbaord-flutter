class Category {
  int id;
  String nameArbice;
  String nameEnglish;
  String nameFrance;
  String image;

  Category(
      {this.id,
        this.nameArbice,
        this.nameEnglish,
        this.nameFrance,
        this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameArbice = json['nameArbice'];
    nameEnglish = json['nameEnglish'];
    nameFrance = json['nameFrance'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameArbice'] = this.nameArbice;
    data['nameEnglish'] = this.nameEnglish;
    data['nameFrance'] = this.nameFrance;
    data['image'] = this.image;
    return data;
  }
}
