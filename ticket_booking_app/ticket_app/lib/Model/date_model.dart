

class DateModel{
  String? id;
  String? name;
  String? idMovie;
  DateModel({this.id, this.name, this.idMovie});

  factory DateModel.fromJson(Map<String, dynamic> json){
    return DateModel(
      id: json['id'],
      name: json['name'],
      idMovie: json['idMovie'],
    );
  }
  static List<DateModel> jsonToList(List<dynamic> jsonList){
    return jsonList.map((json) => DateModel.fromJson(json)).toList();
  }
}