

class TimeModel{
  String? idDate;
  String? id;
  String? name;

  TimeModel({this.idDate, this.id, this.name});

  factory TimeModel.fromJson(Map<String, dynamic> json){
    return TimeModel(
      id: json['id'],
      idDate: json['idDate'],
      name: json['name']
    );
  }
  static List<TimeModel> jsonToList(List<dynamic> jsonList){
    return jsonList.map((json) => TimeModel.fromJson(json)).toList();
  }
}