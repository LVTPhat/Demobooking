


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_app/Model/movie_model.dart';

class Info2MovieWidget extends StatefulWidget {

  final MovieModel myMovie;
  const Info2MovieWidget({super.key, required this.myMovie});

  @override
  State<Info2MovieWidget> createState() => _Info2MovieWidgetState();
}

class _Info2MovieWidgetState extends State<Info2MovieWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 120,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 1)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Rate",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                ),
              ),
              Container(
                //color: Colors.red,
                height: 30,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                      itemBuilder: (context, index){
                          if(index < widget.myMovie!.favourite!.toInt()){
                            return const Icon(Icons.star, color: Colors.yellow, size: 18,);
                          }
                          return const Icon(Icons.star, size: 18,color: Colors.white24,);
                      }
                  ),
                ),

            ],
          ),
        ),

        Container(
          width: 120,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 1)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Duration",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                ),
              ),
              Container(
                //color: Colors.red,
                height: 30,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.timer, size: 15, color: Colors.white),
                    SizedBox(width: 5,),
                    Text(
                      "1h30'",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: CupertinoColors.systemGrey5
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),

        Container(
          width: 120,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 1)
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "P-G",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                ),
              ),
              Container(
                //color: Colors.red,
                height: 30,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      "18+",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: CupertinoColors.systemGrey5
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
