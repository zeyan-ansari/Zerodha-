import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import '../sizeconfig.dart';
import 'package:http/http.dart' as http;

class SellStocks extends StatefulWidget {
  final String StockName;
  final String Exchange;
  final String TransactionType;
  final String Price;
  final String TradingSymbol;

  const SellStocks({Key key, this.StockName, this.Exchange, this.TransactionType, this.Price, this.TradingSymbol}) : super(key: key);

  @override
  _SellStocksState createState() => _SellStocksState(StockName: StockName,TradingSymbol: TradingSymbol,TransactionType: TransactionType,Price: Price,Exchange: Exchange);
}

void confirmed() {
  print('Slider confirmed!');
}

class _SellStocksState extends State<SellStocks> {
  final String StockName;
  final String Exchange;
  final String TransactionType;
  final String Price;
  final String TradingSymbol;

  bool _isLoading = false;
  var errorMsg;
  final TextEditingController quantityController = new TextEditingController();
  final TextEditingController priceController = new TextEditingController();

  Future<http.Response> createStock(String price,String quantity) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return http.patch(
      Uri.parse('http://stockapp.techverden.com/api/v1/market/stock/{ID}'),
      headers: <String, String>{

        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader:
        'Bearer ${sharedPreferences.get('token')}',
      },
      body: jsonEncode(<String, String>{
        'tradingsymbol':TradingSymbol,
        'exchange':Exchange,
        'transaction_type':TransactionType,
        'order_type':'',
        'quantity': quantity,
        'product':StockName,
        'price': price,
      }),

    );

  }

  _SellStocksState({Key key, this.StockName, this.Exchange, this.TransactionType, this.Price, this.TradingSymbol});
  Future<http.Response> _futureCreatestock;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context)),
            elevation: 0,
            backgroundColor: Color(0xFFEEEEEE),
            bottom: const TabBar(
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: 'Regular',
                ),
                Tab(
                  text: 'Cover',
                ),
                Tab(
                  text: 'AMO',
                ),
              ],
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StockName,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: Radio(
                                value: true,
                                groupValue: false,
                                onChanged: null),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'NSE: ₹ 41.01',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 13),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: 15,
                              width: 15,
                              child: Radio(
                                  value: true,
                                  groupValue: false,
                                  onChanged: null)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'BSE: ₹ 41.01',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 13),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            centerTitle: false,
            actions: [
              Icon(
                Icons.more_vert_sharp,
                size: 30,
                color: Colors.black,
              )
            ],
          ),
        ),
        bottomNavigationBar: Material(elevation: 5,
          child: Container(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),
            child: ConfirmationSlider(width: 330,
              text: 'SWIPE TO BUY',
              textStyle: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w300,letterSpacing: 1),
              backgroundColor: Colors.blueAccent,
              iconColor: Colors.white,
              sliderButtonContent: Icon(Icons.chevron_right,color: Colors.blueAccent,size: 35,),
              backgroundColorEnd:  Colors.blueAccent,
              foregroundColor: Colors.white,
              onConfirmation: () {
                setState(() {                  _futureCreatestock = createStock(priceController.text,quantityController.text);

                });
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Transaction Successful!!"),

                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(ctx)..pop()..pop()..pop();
                        },
                        child: Text("okay"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        body: TabBarView(
          children: [
            //Tab1 (Regular)
            Container(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          color: Color(0xFFEEEEEE),
                          height: 100,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Product',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(15),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.5))),
                                        child: Text('Intraday MIS')),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(15),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.5))),
                                        child: Text('Longterm CNC')),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Type',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          padding: EdgeInsets.all(15),
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.5))),
                                          child: Text('Market')),
                                    ),
                                    Expanded(
                                      child: Container(
                                          padding: EdgeInsets.all(15),
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.5))),
                                          child: Text('Limit')),
                                    ),
                                    Expanded(
                                      child: Container(
                                          padding: EdgeInsets.all(15),
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.5))),
                                          child: Text('SL')),
                                    ),
                                    Expanded(
                                      child: Container(
                                          padding: EdgeInsets.all(15),
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.5))),
                                          child: Text('SL-M')),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: SizeConfig.blockSizeVertical * 2,
                      left: SizeConfig.blockSizeHorizontal * 4,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 13.0,
                                color: Colors.black.withOpacity(.03),
                                offset: Offset(1.0, 7.0),
                              )
                            ]),
                        width: SizeConfig.blockSizeHorizontal * 92,
                        height: SizeConfig.blockSizeVertical * 18,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Quantity',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          'Lot: 1',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        margin:
                                        EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.5))),
                                        child: TextFormField(controller: quantityController,
                                          cursorColor: Colors.black,
                                          // keyboardType: inputType,
                                          decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: 15,
                                                  bottom: 11,
                                                  top: 11,
                                                  right: 15),
                                              hintText: "Quantity here"),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Price',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          'Tick: 0.01',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        margin:
                                        EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.5))),
                                        child: TextFormField(controller: priceController,
                                          cursorColor: Colors.black,
                                          // keyboardType: inputType,
                                          decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: 15,
                                                  bottom: 11,
                                                  top: 11,
                                                  right: 15),
                                              hintText: "Amount here"),
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Tab2 (Cover)
            Container(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          color: Color(0xFFEEEEEE),
                          height: 50,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: SizeConfig.blockSizeVertical * 3,
                      left: SizeConfig.blockSizeHorizontal * 4,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 13.0,
                                color: Colors.black.withOpacity(.03),
                                offset: Offset(1.0, 7.0),
                              )
                            ]),
                        width: SizeConfig.blockSizeHorizontal * 92,
                        height: SizeConfig.blockSizeVertical * 9,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Commodity not active',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Tab3 (AMO)
            Container(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          color: Color(0xFFEEEEEE),
                          height: 50,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: SizeConfig.blockSizeVertical * 3,
                      left: SizeConfig.blockSizeHorizontal * 4,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 13.0,
                                color: Colors.black.withOpacity(.03),
                                offset: Offset(1.0, 7.0),
                              )
                            ]),
                        width: SizeConfig.blockSizeHorizontal * 92,
                        height: SizeConfig.blockSizeVertical * 9,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Commodity not active',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
