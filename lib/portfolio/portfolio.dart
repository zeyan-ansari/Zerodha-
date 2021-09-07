import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zerodhaui/Models/portfolio.dart';
import 'package:zerodhaui/portfolio/Holdings.dart';
import 'package:zerodhaui/portfolio/positions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../sizeconfig.dart';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}
Future<PortfolioUser> fetchPortfolioUser() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final response = await http
      .get(Uri.parse('http://stockapp.techverden.com/api/v1/market/stock'),
      headers: <String, String>{

        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader:
        'Bearer ${sharedPreferences.get('token')}',
      }
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return PortfolioUser.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}Future<PortfolioUser> futurePortfolioUser;
class _PortfolioState extends State<Portfolio> with TickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    futurePortfolioUser = fetchPortfolioUser();
  }

  TabController tabController;
  TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            backgroundColor: Color(0xFFEEEEEE),
            title: Text(
              'Portfolio',
              style: TextStyle(fontSize: 27, color: Colors.black),
            ),
            actions: <Widget>[
              Icon(
                Icons.keyboard_arrow_down,
                size: 45,
                color: Colors.black,
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(35.0),
              child: Column(
                children: <Widget>[
                  TabBar(
                    controller: tabController,
                    isScrollable: true,
                    indicatorColor: Colors.blue,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black,
                    labelPadding: EdgeInsets.symmetric(horizontal: 70),
                    tabs: <Widget>[
                      Tab(
                        text: 'Holdings',
                      ),
                      Tab(
                        text: 'Positions',
                      ),

                    ],
                  ),


                ],
              ),
            )),
        body: TabBarView(

          controller: tabController,
          children: <Widget>[
            Holdings(),
            Positions(),
          ],
        ),
      ),
    );

  }
}
