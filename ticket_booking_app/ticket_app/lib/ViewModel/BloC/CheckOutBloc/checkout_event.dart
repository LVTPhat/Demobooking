

import 'package:flutter/cupertino.dart';

import '../../../Model/date_model.dart';
import '../../../Model/seat_model.dart';
import '../../../Model/time_model.dart';

abstract class CheckOutEvent{}
class CheckOutBuyNow extends CheckOutEvent{
  final Object data;
  final BuildContext context;
  CheckOutBuyNow(this.data, this.context);
}

class CheckOutInit extends CheckOutEvent{}
class CheckOutLoading extends CheckOutEvent{}
class SelectDateEvent extends CheckOutEvent {
  final int index;
  final DateModel dateModel;

  SelectDateEvent(this.index, this.dateModel);
}
class SelectTimeEvent extends CheckOutEvent {
  final int index;
  final TimeModel timeModel;
  SelectTimeEvent(this.index, this.timeModel);
}
class SelectSeatEvent extends CheckOutEvent {
  final int index;
  final SeatModel seatModel;
  final DateModel dateSelect;
  final TimeModel timeSelect;
  SelectSeatEvent(this.index, this.seatModel, this.dateSelect, this.timeSelect);
}

class UpdateDataEvent extends CheckOutEvent {
  final int indexDate;
  final int indexTime;
  final int indexSeat;
  final DateModel dateModel;
  final SeatModel seatModel;
  final TimeModel timeModel;
  UpdateDataEvent({
    required this.seatModel,
    required this.timeModel,
    required this.dateModel,
    required this.indexSeat,
    required this.indexTime,
    required this.indexDate,
  });
}