

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/Model/date_model.dart';
import 'package:ticket_app/Model/seat_model.dart';
import 'package:ticket_app/Model/time_model.dart';
import 'package:ticket_app/View/CheckOutPage/widget/date_widget.dart';
import 'package:ticket_app/View/CheckOutPage/widget/seat_widget.dart';
import 'package:ticket_app/View/CheckOutPage/widget/time_widget.dart';
import 'package:ticket_app/ViewModel/BloC/CheckOutBloc/checkout_bloc.dart';
import 'package:ticket_app/ViewModel/BloC/CheckOutBloc/checkout_event.dart';
import 'package:ticket_app/ViewModel/BloC/CheckOutBloc/checkout_state.dart';

import 'package:ticket_app/ViewModel/repository.dart';
import 'package:ticket_app/ViewModel/service_request.dart';
import 'package:ticket_app/ViewModel/utill.dart';


import '../../Model/movie_model.dart';


class CheckoutPage extends StatefulWidget {
  final MovieModel movieModel;
  const CheckoutPage({super.key, required this.movieModel});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final checkOutBloc = context.read<CheckOutBloc>();
    if (checkOutBloc.state is! CheckOutLoadingSate) {
      checkOutBloc.add(CheckOutLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkOutBloc = BlocProvider.of<CheckOutBloc>(context);

    if (checkOutBloc == null) {
      print("CheckOutBloc không được tìm thấy!");
      return const Center(child: Text("Bloc không có sẵn"));
    }
    return Scaffold(
      backgroundColor: const Color(0xFF1E192B),
      body: BlocBuilder<CheckOutBloc, CheckOutState>(
        builder: (context, state) {
          if (state is CheckOutInitial) {
            return const Center(child: CircularProgressIndicator());
          }if(state is CheckOutBuyLoading){
            return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.content,

                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    )
                      ,),
                    SizedBox(height: 10,),
                    const CircularProgressIndicator(),
                  ],
                )
            );
          }
          if (state is CheckOutLoadingSate) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CheckOutFail) {
            return Center(child: Text(state.content.toString()));
          }
          if (state is CheckOutLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 35, left: 10),
                  width: 30,
                  height: 30,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Select Date',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: MyDate(
                    onPressed: (index, myDate) {
                      if (state.selectedTime == null || state.selectedSeats == null) {
                        print("Ko hợp lệ");
                        return;
                      }
                      context.read<CheckOutBloc>().add(
                          UpdateDataEvent(
                            dateModel: myDate,
                            timeModel: state.selectedTime,
                            seatModel: state.selectedSeats,
                            indexDate: index,
                            indexTime: state.selectDate,
                            indexSeat: state.selectSeat,
                          )
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Select Time',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: MyTime(
                    onPressed: (index, myTime) {
                      context.read<CheckOutBloc>().add(
                          UpdateDataEvent(
                            dateModel: state.selectedDate,
                            timeModel: myTime,
                            seatModel: state.selectedSeats,
                            indexDate: state.selectDate,
                            indexTime: index,
                            indexSeat: state.selectSeat,
                          )
                      );
                    },),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Select Seat',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: MySeat(
                    onPressed: (mySeat, index) {
                      context.read<CheckOutBloc>().add(
                          UpdateDataEvent(
                            dateModel: state.selectedDate,
                            timeModel: state.selectedTime,
                            seatModel: mySeat,
                            indexDate: state.selectDate,
                            indexTime: state.selectTime,
                            indexSeat: index,
                          )
                      );
                    }, movieModel: widget.movieModel,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Seat: ${state.selectedSeats!.name.toString()}",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Price: ${state.totalPrice}",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          var data = {
                            "id" : "Order_ ${Utill.generateRandomString(10)}",
                            "username" : RepositoryModel.usersModel.username,
                            "price" : state.selectedSeats.price,
                            "idSeat" : state.selectedSeats.id,
                            "idDate" : state.selectedDate.id,
                            "idTime": state.selectedTime.id,
                            "idMovie": widget.movieModel.id
                          };
                          context.read<CheckOutBloc>().add(
                            CheckOutBuyNow(data, context)
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          backgroundColor: const Color(0xFF8A6ADE),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.airplane_ticket_outlined, color: Colors.white, size: 17),
                            SizedBox(width: 5),
                            Text(
                              'Buy now',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )


                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('Error loading data'));
        },
      ),
    );
  }
}

