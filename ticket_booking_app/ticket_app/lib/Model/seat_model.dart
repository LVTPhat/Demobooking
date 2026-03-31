

class SeatModel{
  String? id;
  String? name;
  String? idTime;
  String? idDate;
  int? status;
  double? price;

  SeatModel({this.id, this.name, this.idTime, this.idDate, this.status, this.price});

  factory SeatModel.fromJson(Map<String, dynamic> json){
    return SeatModel(
      id: json['id'],
      name: json['name'],
      price: json['price']
    );
  }
  static List<SeatModel> jsonToList(List<dynamic> jsonList){
    return jsonList.map((json) => SeatModel.fromJson(json)).toList();
  }
}