class General {
  String counterAdds;
  String counterCategories;
  String counterSub;

  General({this.counterAdds, this.counterCategories, this.counterSub});

  General.fromJson(Map<String, dynamic> json) {
    counterAdds = json['counterAdds'];
    counterCategories = json['counterCategories'];
    counterSub = json['counterSub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counterAdds'] = this.counterAdds;
    data['counterCategories'] = this.counterCategories;
    data['counterSub'] = this.counterSub;
    return data;
  }
}
