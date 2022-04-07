class SubCategory {
  int id;
  int categoryId;
  String nameArbice;
  String nameEnglish;
  String nameFrance;
  String image;
  String date;

  SubCategory(
      {this.id,
        this.categoryId,
        this.nameArbice,
        this.nameEnglish,
        this.nameFrance,
        this.image,
        this.date});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    nameArbice = json['nameArbice'];
    nameEnglish = json['nameEnglish'];
    nameFrance = json['nameFrance'];
    image = json['image'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['nameArbice'] = this.nameArbice;
    data['nameEnglish'] = this.nameEnglish;
    data['nameFrance'] = this.nameFrance;
    data['image'] = this.image;
    data['date'] = this.date;
    return data;
  }
}
