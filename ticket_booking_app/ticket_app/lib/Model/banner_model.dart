


class BannerModel{

  String? id;
  String? imageasset;

  BannerModel({this.id, this.imageasset});

  factory BannerModel.fromJson(Map<String, dynamic> json){
    return BannerModel(
      id: json['id'],
      imageasset: json['imageasset'],
    );
  }

  static List<BannerModel> fromJsonToList(List<dynamic> json){
    return json.map((item) => BannerModel.fromJson(item)).toList();
  }
}