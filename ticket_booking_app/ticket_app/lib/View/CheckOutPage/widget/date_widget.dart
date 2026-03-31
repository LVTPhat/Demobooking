
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_app/Model/date_model.dart';
import 'package:ticket_app/Model/movie_model.dart';
import 'package:ticket_app/ViewModel/BloC/CheckOutBloc/checkout_event.dart';
import 'package:ticket_app/ViewModel/BloC/CheckOutBloc/checkout_state.dart';
import '../../../ViewModel/BloC/CheckOutBloc/checkout_bloc.dart';


class MyDate extends StatefulWidget {

  final Function(int, DateModel) onPressed;


  const MyDate({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<MyDate> createState() => _MyDateState();
}

class _MyDateState extends State<MyDate> {

  Widget build(BuildContext context) {
    return BlocBuilder<CheckOutBloc, CheckOutState>(
      builder: (context, state) {

        if (state is CheckOutInitial) {
          print('CheckOutInitial');
          return const Center(child: CircularProgressIndicator());
        }
        else if (state is CheckOutLoadingSate) {
          print('CheckOutLoadingSate');
          return const Center(child: CircularProgressIndicator());
        }
        else if (state is CheckOutFail) {
          return Center(child: Container(width: 100, height: 100,child: Text(state.content.toString())));
        }
        else if (state is CheckOutLoaded) {
          final checkout = state;
          if (state.selectedTime == null || state.selectedSeats == null || state.selectedDate == null) {
            print("Selected time, seats, or date is null");
            return Center(child: Text('No dates available'));
          }
          if (state.listDates != null && state.listDates!.isNotEmpty) {
            return ListView.builder(
              itemCount: state.listDates!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return mainDate(
                  state.listDates![index],
                  index,
                  checkout.selectDate ?? 0,
                );
              },
            );
          } else {
            return Center(child: Text('No dates available'));
          }
        }
        else {
          return Center(
            child: Container(
              width: 30,
              height: 30,
              child: const CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget mainDate(DateModel myDate, int index, int select){

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: ()=> widget.onPressed(index, myDate),
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 7, right: 3),
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.white, width: 1),
          color: select == index ? Colors.deepPurpleAccent : null
        ),
        child: Center(
          child: Text(
            myDate.name.toString(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              overflow: TextOverflow.ellipsis
            ),
          ),
        ),

      ),
    );
  }
}
