
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app/Model/news_model.dart';


class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final listNews = [
    NewsModel(
      id: "new1",
      title: "New 1",
      content: "assssssdfsdfsdfsdfsdfsdf",
      imageAssets: 'assets/images/banner_1.jpg',
    ),
    NewsModel(
      id: "new2",
      title: "New 2",
      content: "assssssdfsdfsdfsdfsdfsdf",
      imageAssets: 'assets/images/banner_2.jpg',
    ),
    NewsModel(
      id: "new3",
      title: "New 3",
      content: "assssssdfsdfsdfsdfsdfsdf",
      imageAssets: 'assets/images/banner_3.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 13, left: 10,top: 10),
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "The news",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
              InkWell(
                onTap: (){},
                child: const Text(
                  "View all",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.yellow
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          // color: Colors.red,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listNews.length,

              itemBuilder: (context, index){
                return InkWell(
                  onTap: () {
                    print(listNews[index].title.toString());
                  },
                  child: mainNews(listNews[index]),
                );
              }
          ),
        )
      ],
    );
  }
  Widget mainNews(NewsModel movie){
    //print(movie.imageAssets);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          //fit: StackFit.expand,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, top: 7, right: 3),
                width: 250,
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(movie.imageAssets.toString()),
                        fit: BoxFit.cover
                    )
                ),
              ),

            ]
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 5),
          child: Container(


           // color: Colors.green,
            child: Text(
              movie.title.toString(),
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                  fontStyle: FontStyle.italic,
                  color: Colors.white
              ),
            ),
          ),
        ),

      ],


    );
  }

}
