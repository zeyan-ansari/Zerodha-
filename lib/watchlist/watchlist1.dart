import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zerodhaui/Models/eod_models.dart';
import 'package:zerodhaui/Models/tickers_models.dart';
import 'package:zerodhaui/orders/BuyStocks.dart';
import 'package:zerodhaui/orders/executed.dart';
import 'package:zerodhaui/orders/orders.dart';
import 'package:zerodhaui/sizeconfig.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:zerodhaui/ui/searchBar.dart';
import 'package:http/http.dart' as http;
import 'package:zerodhaui/ui/stocklist.dart';

class WatchList1 extends StatefulWidget {
  final String stockName;
  WatchList1({this.stockName});
  @override
  _WatchList1State createState() => _WatchList1State();
}

const String APIKey ='9126fbbe4c9ef73b792478ab6ca1db14';
const String baseUrl ='http://api.marketstack.com/v1/eod';





class _WatchList1State extends State<WatchList1> {

  Future<Eod> fetchEod() async {
    try{print(widget.stockName);
      var url='http://api.marketstack.com/v1/eod?access_key=9126fbbe4c9ef73b792478ab6ca1db14&symbols=${widget.stockName}.XNSE';
      print(url);
      final response = await http
          .get(Uri.parse(url));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print(response.body);
        return Eod.fromJson(jsonDecode(response.body));
      }
    }catch(exception){
      // throw Exception('Failed to load album');
      print('failed to load album');
      print(exception);
      throw exception;

    }


    // if (response.statusCode == 200) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON.
    //   return Eod.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //
    // }
  }
  Future<Eod> futureEod;


  @override
  void initState() {
    super.initState();
    futureEod = fetchEod();
    print(widget.stockName);
  }
  TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            color: Color(0xFFEEEEEE),
            height: SizeConfig.blockSizeVertical*5,
          ),
          GestureDetector(
            onTap: (){ showSearch(
                context: context,
                delegate: DataSearch()
            );},
            child: Container(margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                boxShadow: [BoxShadow(
                  blurRadius: 13.0,
                  color: Colors.black.withOpacity(.03),
                  offset: Offset(1.0, 7.0),
                )]
              ),
              width: SizeConfig.blockSizeHorizontal*92,
              height: SizeConfig.blockSizeVertical*6,

              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(margin:EdgeInsets.symmetric(horizontal: 15),

                        child: Icon(AntDesign.search1,color:Colors.grey ,size: 22,)),

                    Container(width: 100,
                      child: TextField(
                        onTap: ()
                          {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => SearchBar()),
                            // );

                        },
                        controller: textEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xFFEEEEEE),
                            hintText: 'Search & add'
                        ),),
                    ),
                    SizedBox(width: 70,),
                    Text('2/50',style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                    ),),
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.all(15),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Filter',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                      Text('CLEAR',style: TextStyle(fontSize:15,color: Colors.blueAccent),)
                                    ],
                                  ),
                                    SizedBox(height: 10,),
                                    Container( padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10)
                                      ),child: Text('NSE',textAlign: TextAlign.center,),
                                    ),
                                    SizedBox(height: 10,),
                                    Divider(color: Colors.grey,),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Sort',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                        Icon(Icons.cloud_done_rounded,color: Colors.blueAccent,)
                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Container(margin: EdgeInsets.symmetric(vertical: 10),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('A-Z',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                          SizedBox(width: 5,),
                                          Text('Alphabetically',style: TextStyle(fontSize:15,))
                                        ],
                                      ),
                                    ),
                                    Divider(color: Colors.grey,),
                                    Container(margin: EdgeInsets.symmetric(vertical: 10),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(' % ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                          SizedBox(width: 5,),
                                          Text('Change',style: TextStyle(fontSize:15,))
                                        ],
                                      ),
                                    ),
                                    Divider(color: Colors.grey,),
                                    Container(margin: EdgeInsets.symmetric(vertical: 10),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('LTP',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                          SizedBox(width: 5,),
                                          Text('Last Traded Price',style: TextStyle(fontSize:15,))
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Icon(Octicons.settings,color: Colors.grey,)),
                    ),
                  ]),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(height: SizeConfig.blockSizeVertical*10,),
                Container(
                  child: FutureBuilder<Eod>(
                    future: futureEod,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return  Container(height: 700,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide( //                   <--- left side
                                color: Colors.black,
                                width: 1.0,
                              ),)
                          ),
                          child: ListView.builder(
                              itemCount: favs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    showModalBottomSheet<void>(backgroundColor: Colors.transparent,

                                      context: context,isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 500,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
                                          ),
                                          child: Container(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                 Text(favs[index].nameOfCompany.length > 30 ? favs[index].symbol :
                                              favs[index].nameOfCompany,style: TextStyle(
                                                  fontSize: 20,
                                                ),),
                                                SizedBox(height: 5,)
                                                ,
                                                Row(
                                                  children: [
                                                    Text(snapshot.data.data[index].exchange,style: TextStyle(
                                                        fontSize: 13,fontWeight: FontWeight.w300
                                                    ),),
                                                    SizedBox(width: 15,)
                                                    ,Text(snapshot.data.data[index].open.toString(),style: TextStyle(
                                                        fontSize: 13,color: Colors.red,fontWeight: FontWeight.w300
                                                    ),), SizedBox(width: 15,)
                                                    ,Text('-0.22',style: TextStyle(
                                                        fontSize: 13,fontWeight: FontWeight.w300
                                                    ),), SizedBox(width: 5,)
                                                    ,Text('(-0.22%)',style: TextStyle(
                                                        fontSize: 13,fontWeight: FontWeight.w300
                                                    ),),
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Divider(
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap:(){
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => BuyStocks(StockName: snapshot.data.data[index].symbol,


                                                            TradingSymbol:snapshot.data.data[index].symbol ,Exchange:snapshot.data.data[index].exchange ,Price: snapshot.data.data[index].open.toString(),TransactionType: 'Buy',
                                                            )),
                                                          );
                                                        },
                                                        child: Container(padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                                                          alignment: Alignment.center,
                                                          margin: EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              color: Colors.blueAccent
                                                          ),child: Text('BUY',style: TextStyle(
                                                              fontSize: 14,color: Colors.white,fontWeight: FontWeight.w500
                                                          ),),
                                                        ),
                                                      ),
                                                    ),Expanded(
                                                      child: Container(padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                                                        alignment: Alignment.center,
                                                        margin: EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            color: Colors.red
                                                        ),child: Text('SELL',style: TextStyle(
                                                            fontSize: 14,color: Colors.white,fontWeight: FontWeight.w500
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [ Container(

                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.bar_chart,color: Colors.blueAccent,),SizedBox(width: 5,),
                                                          Text('View chart',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w400,fontSize: 14),),
                                                        ],
                                                      )),
                                                    Container(

                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.fast_forward_rounded,color: Colors.blueAccent,),SizedBox(width: 5,),
                                                            Text('Create GTT',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w400,fontSize: 14),),
                                                          ],
                                                        )),
                                                  ],
                                                ),SizedBox(height: 20,),
                                                Text('Market depth',style: TextStyle(
                                                    fontSize: 15,fontWeight: FontWeight.w500
                                                ),)
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(favs[index].nameOfCompany.length > 30 ? favs[index].symbol :
                                              favs[index].nameOfCompany,),
                                              Text(snapshot.data.data[index].open.toString(),style: TextStyle(
                                                  color: Colors.green
                                              ),)
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: SizeConfig.blockSizeVertical*1,),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(snapshot.data.data[index].exchange,style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13
                                              ),),
                                              Text('${snapshot.data.data[index].adjClose.toString()} (+0.28%)',style: TextStyle(
                                                  fontSize: 13
                                              ),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          ),
                        );


                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },


                  ),
                ),




              ],
            ),
          )
        ],
      ),
    );
  }
}
