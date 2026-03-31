

import 'package:ticket_app/Model/seat_order_model.dart';
import 'package:ticket_app/Model/users_model.dart';

import '../Model/date_model.dart';
import '../Model/seat_model.dart';
import '../Model/time_model.dart';

class RepositoryModel{
  RepositoryModel();
  static late UsersModel usersModel;

  static List<DateModel> listDates = [];
  static List<SeatModel> listSeats= [];
  static List<TimeModel> listTimes= [];
  static List<SeatOrderModel> listSeatOrders= [];

}