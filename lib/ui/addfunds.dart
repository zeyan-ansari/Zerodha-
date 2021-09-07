import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zerodhaui/Models/addfundmodel.dart';
import 'package:zerodhaui/profile/profile.dart';
import 'package:zerodhaui/watchlist/watchlist1.dart';

class AddFunds extends StatefulWidget {
  const AddFunds({Key key}) : super(key: key);

  @override
  _AddFundsState createState() => _AddFundsState();
}
Future<AddFund> createAddFund(String title) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final response = await http.post(
    Uri.parse('http://stockapp.techverden.com/api/v1/account/wallet'),
    headers: <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader:
      'Bearer ${sharedPreferences.get('token')}',
    },
    body: jsonEncode(<String, String>{
      'amount': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return AddFund.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
class _AddFundsState extends State<AddFunds> {

  final TextEditingController fundController = new TextEditingController();
  Future<AddFund> _futureAddFund;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed:() =>Navigator.pop(context)
        ),
        elevation: 0,
        backgroundColor: Colors.white,

        title: Text('Add Funds to Equity',style: TextStyle(
            color: Colors.black
        ),),
        centerTitle: true,
      ),
      body: Container(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Balance ₹0.00',style: TextStyle(fontSize: 16),),
            SizedBox(height: 5,),
            Divider(color: Colors.grey,),
            SizedBox(height: 30,),
            Text('Amount',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
            SizedBox(height: 10,),
            TextFormField(
              controller: fundController,
              decoration: new InputDecoration(
                labelText: "Enter amount",labelStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.3),fontSize: 25,fontWeight: FontWeight.w500
              ),
                prefixIcon: Image.asset('images/rs.png',height: 10,scale: 25,color: Colors.grey,),
                fillColor: Colors.white,
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(color: Colors.grey.withOpacity(0.3)),

                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color:  Colors.grey.withOpacity(0.3),
                  ),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Email cannot be empty";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            InkWell(

              onTap:(){
                setState(() {
                  _futureAddFund = createAddFund(fundController.text);
Navigator.of(context)..pop()..pop();
                });
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
            )
          ],
        ),
      ),
    );
  }
}
