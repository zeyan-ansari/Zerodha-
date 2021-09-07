import 'package:flutter/material.dart';
import 'package:zerodhaui/account/register.dart';

import 'login.dart';

class Intro extends StatefulWidget {
  const Intro({key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white,
       
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
          child: 
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/logo.png',height: 80,),
              SizedBox(height: 60,),
              Text('Welcome to\nKite by Zerodha',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30),),
              SizedBox(height: 50,),
              GestureDetector(
                onTap:  () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Container(margin: EdgeInsets.symmetric(horizontal: 5,),
                  padding: EdgeInsets.symmetric(vertical: 23,horizontal: 0),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey, width: 0.5),bottom:BorderSide(color: Colors.grey, width: 0.5) ),
                  ),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Login to Kite',style: TextStyle(fontSize: 20),),
                      Icon(Icons.login,size: 23,)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap:  () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Container(margin: EdgeInsets.symmetric(horizontal: 5,),
                  padding: EdgeInsets.symmetric(vertical: 23,horizontal: 0),
                  decoration: BoxDecoration(
                    border: Border(bottom:BorderSide(color: Colors.grey, width: 0.5) ),
                  ),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Continue signup',style: TextStyle(fontSize: 20),),
                      Image.asset('images/user.png',height: 20,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
