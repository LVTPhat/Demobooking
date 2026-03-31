

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart';
import 'package:ticket_app/Model/movie_model.dart';
import 'package:ticket_app/View/DetailPage/detail_page.dart';

class InfoMovieWidget extends StatefulWidget {
  final MovieModel? myMovie;
  const InfoMovieWidget({super.key, required this.myMovie});

  @override
  State<InfoMovieWidget> createState() => _InfoMovieWidgetState();
}

class _InfoMovieWidgetState extends State<InfoMovieWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 200,
      //color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
            Text(
              widget.myMovie!.title.toString(),
              style: const TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,

              ),
              maxLines: 2,
            ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                  "Tác giả: ",
                style: TextStyle(
                  fontSize: 15,
                  color: CupertinoColors.systemGrey,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis
                ),
              ),
              Text(
                widget.myMovie!.author.toString(),
                style: const TextStyle(
                    fontSize: 15,
                    color: CupertinoColors.systemGrey4,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Diễn viên: ",
                style: TextStyle(
                    fontSize: 15,
                    color: CupertinoColors.systemGrey,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis
                ),
              ),
              Expanded(

                child: Text(
                  widget.myMovie!.acter.toString(),
                  style: const TextStyle(
                      fontSize: 15,
                      color: CupertinoColors.systemGrey4,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Thể loại: ",
                style: TextStyle(
                    fontSize: 15,
                    color: CupertinoColors.systemGrey,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis
                ),
              ),
              Text(
                widget.myMovie!.category.toString(),
                style: const TextStyle(
                    fontSize: 15,
                    color: CupertinoColors.systemGrey4,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis

                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
