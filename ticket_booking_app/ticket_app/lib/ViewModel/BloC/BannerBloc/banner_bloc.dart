

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_app/Model/banner_model.dart';
import 'package:ticket_app/ViewModel/BloC/BannerBloc/banner_event.dart';
import 'package:ticket_app/ViewModel/BloC/BannerBloc/banner_state.dart';
import 'package:ticket_app/ViewModel/service_request.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState>{
  BannerBloc({required this.serviceRepository}) : super(BannerInitial()){
    on<BannerFetch>(_bannerFetch);
  }
  final ServiceRequest serviceRepository;
  void _bannerFetch(BannerFetch event, Emitter<BannerState> emit) async{
    emit(BannerLoading());
    List<BannerModel> data = await serviceRepository.fetchBanner();
    if(data.isNotEmpty){
      emit(BannerLoaded(data));
    }else{
      emit(BannerFail("Ko tìm thấy Banner"));
    }
  }
}