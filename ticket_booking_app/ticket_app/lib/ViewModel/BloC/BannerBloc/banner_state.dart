


import 'package:ticket_app/Model/banner_model.dart';

abstract class BannerState{}

class BannerInitial extends BannerState{}
class BannerLoading extends BannerState{}
class BannerLoaded extends BannerState{
  final List<BannerModel> banners;
  BannerLoaded(this.banners);
}
class BannerFail extends BannerState{
  final String message;
  BannerFail(this.message);
}
