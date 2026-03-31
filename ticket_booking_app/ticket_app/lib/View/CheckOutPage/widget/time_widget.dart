import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_app/Model/time_model.dart';
import 'package:ticket_app/ViewModel/BloC/CheckOutBloc/checkout_bloc.dart';
import 'package:ticket_app/ViewModel/BloC/CheckOutBloc/checkout_state.dart';

class MyTime extends StatefulWidget {
  final Function(int, TimeModel) onPressed;

  const MyTime({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<MyTime> createState() => _MyTimeState();
}

class _MyTimeState extends State<MyTime> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckOutBloc, CheckOutState>(
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
          final myTime = state.listTimes!.where((item) {
            return item.idDate == state.selectedDate.id;
          }).toList();

          return ListView.builder(
            itemCount: myTime.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return mainDate(myTime[index], index, state.selectTime ?? -1);
            },
          );
        }else {
          return const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget mainDate(TimeModel myDate, int index, int select) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => widget.onPressed(index, myDate),
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 7, right: 3),
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.white, width: 1),
          color: select == index ? Colors.deepPurpleAccent : null,
        ),
        child: Center(
          child: Text(
            myDate.name.toString(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
