

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_app/Model/date_model.dart';
import 'package:ticket_app/Model/seat_model.dart';
import 'package:ticket_app/Model/seat_order_model.dart';
import 'package:ticket_app/Model/time_model.dart';
import 'package:ticket_app/ViewModel/service_request.dart';

import '../../../Model/response_model.dart';
import '../../repository.dart';
import '../../utill.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';
import 'package:bloc/bloc.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  CheckOutBloc({required this.servicerepository}) : super(CheckOutInitial()) {

    on<CheckOutBuyNow>((event, emit) async{
      emit(CheckOutBuyLoading('Đang mua'));
      ResponseModel result = await servicerepository.orderSeat(event.data);
      if(result != null){
        await Future.delayed(Duration(seconds: 2));
        event.context.read<CheckOutBloc>().add(CheckOutLoading());
      }else{
        emit(CheckOutBuyFail(result.message));
      }
    });
    on<UpdateDataEvent>((event, emit) {

      emit(CheckOutLoadingSate());

      if (event.dateModel == null || event.timeModel == null || event.seatModel == null) {
        emit(CheckOutFail('Dữ liệu không hợp lệ.'));
        return;
      }
      print('UpdateDataEvent');

      emit(CheckOutLoaded(
          selectedDate: event.dateModel,
          selectedTime: event.timeModel,
          selectedSeats: event.seatModel,
          totalPrice: event.seatModel.price!.toDouble(),
          selectSeat: event.indexSeat,
          selectTime: event.indexTime,
          selectDate: event.indexDate,
          listTimes:  RepositoryModel.listTimes,
          listDates:  RepositoryModel.listDates,
        listSeats:  RepositoryModel.listSeats,
        listSeatOrders:  RepositoryModel.listSeatOrders,

      ));
    });
    on<CheckOutLoading>((event, emit) async{

      emit(CheckOutLoadingSate());
      List<DateModel>? listDates = await servicerepository.fetchDate();
      List<SeatModel>? listSeats = await servicerepository.fetchSeat();
      List<TimeModel>? listTimes = await servicerepository.fetchTime();
      List<SeatOrderModel>? listSeatOrders = await servicerepository.fetchSeatOrder();
      if (listDates == null || listDates.isEmpty) {
        emit(CheckOutFail("Không tìm thấy Dates"));
      } else if (listSeats == null || listSeats.isEmpty) {
        emit(CheckOutFail("Không tìm thấy Seats"));
      } else if (listTimes == null || listTimes.isEmpty) {
        emit(CheckOutFail("Không tìm thấy Times"));
      } else {
        RepositoryModel.listDates = listDates;
        RepositoryModel.listSeats = listSeats;
        RepositoryModel.listTimes = listTimes;
        RepositoryModel.listSeatOrders = listSeatOrders;
        emit(CheckOutLoaded(
            selectedDate: listDates[0],
            selectedTime: listTimes[0],
            selectedSeats: listSeats[0],
            totalPrice: 0.0,
            selectSeat: 0,
            selectTime: 0,
            selectDate: 0,
            listTimes:  RepositoryModel.listTimes,
            listDates:  RepositoryModel.listDates,
            listSeats:  RepositoryModel.listSeats,
          listSeatOrders:  RepositoryModel.listSeatOrders,
        ));
      }
    });
  }
  final ServiceRequest servicerepository;


}