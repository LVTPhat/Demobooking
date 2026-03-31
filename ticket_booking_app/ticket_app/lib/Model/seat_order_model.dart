
import 'dart:convert';

class SeatOrderModel{
  String? id;
  String? idSeat;
  String? idDate;
  String? idMovie;
  String? idTime;
  String? username;
  double? price;
  String? dateOrder;
  SeatOrderModel({this.id, this.idSeat, this.idDate,
    this.idMovie, this.idTime, this.username, this.price, this.dateOrder});

  factory SeatOrderModel.fromJson(Map<String, dynamic> json){
    return SeatOrderModel(
        id: json['id'],
        idSeat: json['idSeat'],
        idDate: json['idDate'],
        idMovie: json['idMovie'],
        idTime: json['idTime'],
        username: json['username'],
        price: json['price'],
        dateOrder: json['createdAt']
    );
  }

  static List<SeatOrderModel> jsonToList(List<dynamic> jsonList){
    return jsonList.map((json) => SeatOrderModel.fromJson(json)).toList();
  }

}