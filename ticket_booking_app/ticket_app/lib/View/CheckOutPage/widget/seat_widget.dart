import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ticket_app/Model/date_model.dart';
import 'package:ticket_app/Model/movie_model.dart';
import 'package:ticket_app/Model/seat_model.dart';
import 'package:ticket_app/Model/seat_order_model.dart';
import 'package:ticket_app/Model/time_model.dart';
import 'package:ticket_app/ViewModel/BloC/CheckOutBloc/checkout_bloc.dart';
import 'package:ticket_app/ViewModel/BloC/CheckOutBloc/checkout_state.dart';

import '../../../ViewModel/repository.dart';

class MySeat extends StatefulWidget {
  final MovieModel movieModel;
  final Function(SeatModel, int) onPressed;

  const MySeat({Key? key, required this.onPressed, required this.movieModel}) : super(key: key);

  @override
  State<MySeat> createState() => _MySeatState();
}

class _MySeatState extends State<MySeat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: BlocBuilder<CheckOutBloc, CheckOutState>(
        builder: (context, state) {
          if (state is CheckOutInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is CheckOutLoadingSate) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is CheckOutFail) {
            return Center(child: Container(width: 100, height: 100,child: Text(state.content.toString())));
          }
          else if (state is CheckOutLoaded) {
            if (state.selectedTime == null || state.selectedSeats == null || state.selectedDate == null) {
              print("Selected time, seats, or date is null");
              return Center(child: Text('No dates available'));
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
                childAspectRatio: 1,
              ),
              itemCount: state.listSeats!.length,
              itemBuilder: (context, index) {
                return MainSeat(state.selectedDate, state.selectedTime, state.listSeatOrders!, state.listSeats![index], index, state.selectSeat);
              },
            );
          }
          else {
            return const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget MainSeat(DateModel date, TimeModel time, List<SeatOrderModel> order, SeatModel mySeat, int index, int select) {
    bool isBooked = order.any((order) =>
        order.idSeat == mySeat.id &&
        order.idMovie == widget.movieModel.id &&
        order.idDate == date.id &&
        order.idTime == time.id
    );
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: isBooked ? null : () => widget.onPressed(mySeat, index),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.white),
          color: isBooked ? Colors.lightGreen : (select == index ? Colors.grey : null),
        ),
        child: Center(
          child: Text(
            mySeat.name.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
