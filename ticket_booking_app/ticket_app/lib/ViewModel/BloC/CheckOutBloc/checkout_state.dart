
import 'package:ticket_app/Model/seat_order_model.dart';

import '../../../Model/date_model.dart';
import '../../../Model/seat_model.dart';
import '../../../Model/time_model.dart';

abstract class CheckOutState{
}
class CheckOutBuyLoading extends CheckOutState{
  final String content;
  CheckOutBuyLoading(this.content);
}
class CheckOutBuyLoaded extends CheckOutState{
}
class CheckOutBuySuccesss extends CheckOutState{
}
class CheckOutBuyFail extends CheckOutState{
  final String content;
  CheckOutBuyFail(this.content);
}

class CheckOutInitial extends CheckOutState {}
class CheckOutLoadingSate extends CheckOutState {}
class CheckOutLoaded extends CheckOutState {

  DateModel selectedDate;
  TimeModel selectedTime;
  SeatModel selectedSeats;
    double totalPrice = 0.0;
    int selectDate = 0;
    int selectTime = 0;
    int selectSeat = 0;

    List<DateModel>? listDates = [];
    List<SeatModel>? listSeats= [];
  List<TimeModel>? listTimes= [];
  List<SeatOrderModel>? listSeatOrders= [];


    CheckOutLoaded({
     required this.selectedDate,
      required this.selectedTime,
      required this.selectedSeats,
      required this.totalPrice,
      required this.selectSeat,
      required this.selectTime,
      required this.selectDate,
      this.listDates,
      this.listSeats,
      this.listTimes,
      this.listSeatOrders,

  });

}

class CheckOutFail extends CheckOutState {
  String? content;
  CheckOutFail(this.content);
}
