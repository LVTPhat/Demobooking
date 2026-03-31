
import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:ticket_app/Model/banner_model.dart';
import 'package:ticket_app/Model/date_model.dart';
import 'package:ticket_app/Model/movie_model.dart';
import 'package:ticket_app/Model/response_model.dart';
import 'package:ticket_app/Model/seat_model.dart';
import 'package:ticket_app/Model/seat_order_model.dart';
import 'package:ticket_app/Model/time_model.dart';

import 'package:ticket_app/ViewModel/utill.dart';
class ServiceRequest{
  ServiceRequest();
  static String baseURL = "http://192.168.1.4:3000/";
  Uri urlMovies = Uri.parse('${baseURL}movies');
  Uri urlBanners = Uri.parse('${baseURL}banners');
  Uri urlDates = Uri.parse('${baseURL}dates');
  Uri urlTimes = Uri.parse('${baseURL}times');
  Uri urlSeats = Uri.parse('${baseURL}seats');
  Uri urlUsers = Uri.parse('${baseURL}users');

  static Uri urlSeatOrders = Uri.parse('${baseURL}seatorders');



  Future<List<MovieModel>> fetchMovies () async{
    var c = Completer<List<MovieModel>>();
    late List<MovieModel> list;
    final response = await http.get(urlMovies);
    if(response.statusCode == 201){
      list = MovieModel.fromJsonList(jsonDecode(response.body));
    }
    c.complete(list);
    return c.future;
  }


  Future<List<BannerModel>> fetchBanner() async {
    var c = Completer<List<BannerModel>>();
    List<BannerModel>? list = [];

    var response = await http.get(urlBanners);
    if(response.statusCode == 201){
     // print(response.body);
      list = BannerModel.fromJsonToList(jsonDecode(response.body));
    }
    c.complete(list);
    return c.future;
  }

  Future<List<DateModel>> fetchDate() async{
    var c = Completer<List<DateModel>>();
    List<DateModel> list = [];
    var response = await http.get(urlDates);
    if(response.statusCode == 201){
     // print(response.body);
      list = DateModel.jsonToList(jsonDecode(response.body));
    }
    c.complete(list);
    return c.future;
  }
  Future<List<TimeModel>> fetchTime() async{
    var c = Completer<List<TimeModel>>();
    List<TimeModel> list = [];
    var response = await http.get(urlTimes);
    if(response.statusCode == 201){
     // print(response.body);
      list = TimeModel.jsonToList(jsonDecode(response.body));
    }
    c.complete(list);
    return c.future;
  }
  Future<List<SeatModel>> fetchSeat() async{
    var c = Completer<List<SeatModel>>();
    List<SeatModel> list = [];
    var response = await http.get(urlSeats);
    if(response.statusCode == 201){
      //print(response.body);
      list = SeatModel.jsonToList(jsonDecode(response.body));
    }
    c.complete(list);
    return c.future;
  }

  Future<List<SeatOrderModel>> fetchSeatOrder() async{
    var c = Completer<List<SeatOrderModel>>();
    List<SeatOrderModel> list = [];
    var response = await http.get(urlSeatOrders);
    if(response.statusCode == 201){
    //  print(response.body);
      list = SeatOrderModel.jsonToList(jsonDecode(response.body));
    }
    c.complete(list);
    return c.future;
  }

  Future<ResponseModel> orderSeat(Object data) async{
    var c = Completer<ResponseModel>();
    late ResponseModel responseModel;
    var response = await http.post(
      urlSeatOrders,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data)
    );
    if(response.statusCode == 201){
      responseModel = ResponseModel.fromJson(jsonDecode(response.body));
    }
    c.complete(responseModel);
    return c.future;
  }
  Future<ResponseModel> addMovie(Object data, File imageFileAsset, File imageFileBanner) async {
    var c = Completer<ResponseModel>();
    late ResponseModel responseModel;
    var request = http.MultipartRequest('POST', urlMovies);
    request.fields['data'] = jsonEncode(data);
    var file = await http.MultipartFile.fromPath('file', imageFileAsset.path);
    request.files.add(file);
    var file2 = await http.MultipartFile.fromPath('file2', imageFileBanner.path);
    request.files.add(file2);
    var response = await request.send();
    if (response.statusCode == 201) {
      var responseBody = await response.stream.bytesToString();
      responseModel = ResponseModel.fromJson(jsonDecode(responseBody));
    }
    c.complete(responseModel);
    return c.future;
  }

  Future<ResponseModel> editMovie(Object data, String pathAsset, String pathBanner) async {
    print('pathAsset $pathAsset');
    print('pathBanner $pathBanner');
    var c= Completer<ResponseModel>();
    late ResponseModel responseModel;
    var request = http.MultipartRequest('PUT', urlMovies);
    request.fields['data'] = jsonEncode(data);
    if(!pathAsset.contains('null') &&  pathAsset.isNotEmpty){
      var file = await http.MultipartFile.fromPath('file', pathAsset);
      request.files.add(file);
    }
    if(!pathBanner.contains('null') && pathBanner.isNotEmpty) {
      var file2 = await http.MultipartFile.fromPath('file2', pathBanner);
      request.files.add(file2);
    }
    var response = await request.send();
    if(response.statusCode == 201){
      var responseBody = await response.stream.bytesToString();
      responseModel = ResponseModel.fromJson(jsonDecode(responseBody));
    }
    c.complete(responseModel);
    return c.future;
  }
  Future<ResponseModel> deleteMovie(String idMovie) async{
    var c = Completer<ResponseModel>();
    late ResponseModel responseModel;
    var response = await http.delete(urlMovies,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "id" : idMovie
      })
    );
    if(response.statusCode == 201){
      responseModel = ResponseModel.fromJson(jsonDecode(response.body));
    }
    c.complete(responseModel);
    return c.future;
  }

  Future<ResponseModel> registerUser(String username, String password, String repassword) async{
    var c = Completer<ResponseModel>();
    late ResponseModel responseModel;
    var data = {
      "id" : "user_${Utill.generateRandomString(10)}",
      "username": username,
      "password": password,
      "repassword": repassword,
      "status" : 1,
    };
    var response = await http.post(
        urlUsers,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data)
    );
    if(response.statusCode == 201){
      responseModel = ResponseModel.fromJson(jsonDecode(response.body));
    }
    c.complete(responseModel);
    return c.future;
  }
  Future<ResponseModel> loginUser(String username, String password) async{
    var c = Completer<ResponseModel>();
    late ResponseModel responseModel;
    var data = {
      "username": username,
      "password": password,
      "status" : 0,
    };
    var response = await http.post(urlUsers,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data)
    );
    if(response.statusCode ==201){
      responseModel = ResponseModel.fromJson(jsonDecode(response.body));
    }
    c.complete(responseModel);
    return c.future;
  }
}