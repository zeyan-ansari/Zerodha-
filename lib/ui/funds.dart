
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zerodhaui/Models/userfunds.dart';
import 'package:http/http.dart' as http;

import '../sizeconfig.dart';
import 'addfunds.dart';

class Funds extends StatefulWidget {
  const Funds({Key key}) : super(key: key);

  @override
  _FundsState createState() => _FundsState();
}
Future<FundUser> fetchFundUser() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final response = await http
      .get(Uri.parse('http://stockapp.techverden.com/api/v1/account/wallet'),
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader:
      'Bearer ${sharedPreferences.get('token')}',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return FundUser.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User Funds');
  }
}
class _FundsState extends State<Funds> {
  Future<FundUser> futureFundUser;

  @override
  void initState() {
    super.initState();
    futureFundUser = fetchFundUser();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.black,),
              onPressed:() =>Navigator.pop(context)
          ),
          elevation: 0,
          backgroundColor: Color(0xFFEEEEEE),
          bottom: const TabBar(labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),labelColor: Colors.blueAccent,unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: 'Equity',),
              Tab(text: 'Commodity',),
            ],
          ),
          title: Text('Funds',style: TextStyle(
            color: Colors.black
          ),),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            //Tab1 (Equity)
            FutureBuilder<FundUser>(
                future: futureFundUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child:SingleChildScrollView(
                        child: Stack(
                          children: [

                            Column(
                              children: [
                                Container(color:  Color(0xFFEEEEEE),
                                  height: 70,
                                ),
                                Container(margin: EdgeInsets.symmetric(horizontal: 0),
                                  child: Column(
                                    children: [
                                      SizedBox(height: MediaQuery.of(context).size.height*0.12,),
                                      Container(margin: EdgeInsets.symmetric(horizontal: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(

                                                onTap:(){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => AddFunds()),
                                                  );
                                                },
                                                child: Container(padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: Colors.green
                                                  ),child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.add,color: Colors.white,size: 28,),
                                                      SizedBox(width: 5,),
                                                      Text('Add funds',style: TextStyle(
                                                          fontSize: 17,color: Colors.white,fontWeight: FontWeight.w500
                                                      ),),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),Expanded(
                                              child: Container(padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: Colors.blueAccent
                                                ),child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.restart_alt_outlined,color: Colors.white,size: 28,),
                                                    SizedBox(width: 5,),
                                                    Text('Withdraw',style: TextStyle(
                                                        fontSize: 17,color: Colors.white,fontWeight: FontWeight.w500
                                                    ),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),

                                            ),child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('Available cash',style: TextStyle(
                                                    color: Colors.grey,

                                                    fontSize: 15
                                                ),),
                                                SizedBox(height: 5,),
                                                Text(snapshot.data.balance,style: TextStyle(
                                                    fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500
                                                ),),
                                              ],
                                            ),
                                          ),Container(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),

                                            ),child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('Used margin',style: TextStyle(
                                                    color: Colors.grey,

                                                    fontSize: 15
                                                ),),
                                                SizedBox(height: 5,),
                                                Text('0.00',style: TextStyle(
                                                    fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500
                                                ),),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(margin: EdgeInsets.symmetric(horizontal: 15),
                                        child: Divider(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      greybox(type: Color(0xFFEEEEEE),value: 'Opening balance',),
                                      greybox(type: Colors.white,value: 'Paying',),
                                      greybox(type: Color(0xFFEEEEEE),value: 'SPAN',),
                                      greybox(type: Colors.white,value: 'Delivery margin',),
                                      greybox(type: Color(0xFFEEEEEE),value: 'Exposure',),
                                      greybox(type: Colors.white,value: 'Option premium',),
                                      Container(margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                        child: Divider(
                                          color: Colors.grey,
                                        ),

                                      ),
                                      greybox(type: Color(0xFFEEEEEE),value: 'Collateral (Liquid funds)',),
                                      greybox(type: Colors.white,value: 'Collateral (Equity)',),
                                      greybox(type: Color(0xFFEEEEEE),value: 'Total collateral',),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                              top: SizeConfig.blockSizeVertical*2,
                              left: SizeConfig.blockSizeHorizontal*4,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,borderRadius: BorderRadius.circular(5),
                                    boxShadow: [BoxShadow(
                                      blurRadius: 13.0,
                                      color: Colors.black.withOpacity(.03),
                                      offset: Offset(1.0, 7.0),
                                    )]
                                ),
                                width: SizeConfig.blockSizeHorizontal*92,
                                height: SizeConfig.blockSizeVertical*18,

                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Center(
                                          child: Text('Available margin (Cash + Collateral)',style: TextStyle(
                                              color: Colors.grey,

                                              fontSize: 15
                                          ),),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Expanded(
                                        child: Center(
                                          child: Text('₹${snapshot.data.balance}',style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25
                                          ),),
                                        ),
                                      ), SizedBox(height: 5,),Expanded(
                                        child: Center(
                                          child: Text('View statement',style: TextStyle(
                                              color: Colors.blueAccent,

                                              fontSize: 16
                                          ),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ) ,
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Center(child: const CircularProgressIndicator());
              }
            ),



            //Tab2 (Commodity)
            Container(
              child:SingleChildScrollView(
                child: Stack(
                  children: [

                    Column(
                      children: [
                        Container(color:  Color(0xFFEEEEEE),
                          height: 50,
                        ),
                        Container(margin: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            children: [
                              SizedBox(height: 80,),




                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: SizeConfig.blockSizeVertical*3,
                      left: SizeConfig.blockSizeHorizontal*4,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,borderRadius: BorderRadius.circular(5),
                            boxShadow: [BoxShadow(
                              blurRadius: 13.0,
                              color: Colors.black.withOpacity(.03),
                              offset: Offset(1.0, 7.0),
                            )]
                        ),
                        width: SizeConfig.blockSizeHorizontal*92,
                        height: SizeConfig.blockSizeVertical*9,

                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Text('Commodity not active',style: TextStyle(
                                      color: Colors.grey,

                                      fontSize: 15
                                  ),),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ) ,
            ),

          ],
        ),
      ),
    );
  }
}

class greybox extends StatelessWidget {
  final Color type;
  final String value;

  const greybox({
    Key key, this.type, this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: type,
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value,style: TextStyle(
          fontSize: 17,color: Colors.black,
      ),),
          Text('0.00',style: TextStyle(
            fontSize: 17,color: Colors.black,
          ),)
        ],
      ),
    );
  }
}
