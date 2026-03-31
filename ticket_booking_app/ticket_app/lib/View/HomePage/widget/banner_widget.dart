import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/ViewModel/BloC/BannerBloc/banner_bloc.dart';

import 'package:ticket_app/ViewModel/service_request.dart';

import '../../../ViewModel/BloC/BannerBloc/banner_event.dart';
import '../../../ViewModel/BloC/BannerBloc/banner_state.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int indexBanner = 0;
  int lengthbanner = 3;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<BannerBloc>().add(BannerFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          BlocBuilder<BannerBloc, BannerState>(
            builder: (context, state) {
              if (state is BannerLoading) {
                return const Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is BannerLoaded) {
                final banners = state.banners;
                lengthbanner = banners.length;
                return CarouselSlider.builder(
                  itemCount: banners.length,
                  options: CarouselOptions(
                    initialPage: indexBanner,
                    viewportFraction: 1,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        indexBanner = index;
                      });
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${ServiceRequest.baseURL}${banners[index].imageasset}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: Row(
              children: List.generate(
                lengthbanner,
                    (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: indexBanner == index ? 24 : 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: indexBanner == index ? Colors.deepOrangeAccent : Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
