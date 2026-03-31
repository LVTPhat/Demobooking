

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/Model/users_model.dart';
import 'package:ticket_app/View/AdminPage/Widget/movie_page.dart';
import 'package:ticket_app/View/AdminPage/admin_movie_control.dart';
import 'package:ticket_app/View/HomePage/widget/news_widget.dart';
import 'package:ticket_app/View/HomePage/widget/movie_widget.dart';
import 'package:ticket_app/View/HomePage/widget/banner_widget.dart';
import 'package:ticket_app/View/LoginPage/login_page.dart';
import 'package:ticket_app/ViewModel/BloC/CheckOutBloc/checkout_bloc.dart';



import '../../ViewModel/BloC/BannerBloc/banner_bloc.dart';
import '../../ViewModel/BloC/MovieBloc/movie_bloc.dart';

import '../../ViewModel/repository.dart';
import '../../ViewModel/service_request.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        Provider<BannerBloc>(create: (_) => BannerBloc(serviceRepository: ServiceRequest())),
        Provider<MovieBloc>(create: (_) => MovieBloc(serviceRepository: ServiceRequest())),
      ],
      child: const MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xFF1E192B),
          body: MyHomePage(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1E192B),
      appBar: AppBar(
        title: const Text("PhatDev App", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          fontSize: 18
        ),),
        backgroundColor: const Color(0xFF1E192B),
        leading: InkWell(
          onTap: (){
            _scaffoldKey.currentState?.openDrawer();
          },
            child: const Icon(
              Icons.sort, color: Colors.white,
            )
        ),
        elevation: 0,
        actions: [
          InkWell(
            onTap: (){},
            child: Icon(Icons.favorite_border, color: Colors.white, size: 22,),
          ),
          SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: (){

              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/avt.jpg'),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
          )

        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF1E192B),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                //color: Colors.blue,
              ),
              child: Text(
                'My Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Trang Chính', style: TextStyle(color: Colors.white)),
              onTap: () {

                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.admin_panel_settings, color: Colors.white),
              title: const Text('Admin', style: TextStyle(color: Colors.white)),
              onTap: () {

               Navigator.push(context,
                 MaterialPageRoute(builder: (context) => const AdminPage())
               );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text('Đăng xuất', style: TextStyle(color: Colors.white)),
              onTap: () {
                RepositoryModel.usersModel = UsersModel();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage())
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [

            // Banner
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 200,
              //color: Colors.green,
              child: const BannerWidget(),
            ),

            // Movie
            Container(
              width: MediaQuery.of(context).size.width,
              //color: Colors.green,
              child: const MovieWidget(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
             // color: Colors.green,
              child: const NewsWidget(),
            )

          ],
        ),

      ),
    );

  }
}

