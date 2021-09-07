import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:zerodhaui/account/login.dart';

class Register extends StatefulWidget {



  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  var errorMsg;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();

  Register(String email, pass, name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'name': name,
      'email': email,
      'password': pass
    };
    var jsonResponse = null;
    var response = await http.post(Uri.parse("http://stockapp.techverden.com/api/v1/register"), body: data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if(jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        // sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      errorMsg = response.body;
      print("The error message is: ${response.body}");
    }
  }



  @override
  Widget build(BuildContext context) {
    return _isLoading ? Center(child: CircularProgressIndicator()) :Scaffold(backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed:() =>Navigator.pop(context)
        ),
        actions: [
          Image.asset('images/logo.png',height: 80,),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Text('Register',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 26),),
            SizedBox(height:80,),
            TextFormField(
              controller: nameController,
              decoration: new InputDecoration(
                labelText: "Name",labelStyle: TextStyle(
                  color: Colors.grey
              ),
                suffixIcon: Image.asset('images/user.png',height: 10,scale: 25,color: Colors.grey,),
                fillColor: Colors.white,
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(color: Colors.grey.withOpacity(0.5)),

                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color:  Colors.grey.withOpacity(0.5),
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
            ),SizedBox(height:60,),
            TextFormField(
              controller: emailController,
              decoration: new InputDecoration(
                labelText: "Email ID",labelStyle: TextStyle(
                  color: Colors.grey
              ),
                suffixIcon: Image.asset('images/user.png',height: 10,scale: 25,color: Colors.grey,),
                fillColor: Colors.white,
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(color: Colors.grey.withOpacity(0.5)),

                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color:  Colors.grey.withOpacity(0.5),
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
            ),SizedBox(height:60,),
            TextFormField(obscureText: true,
              controller: passwordController,
              decoration: new InputDecoration(
                labelText: "Password",labelStyle: TextStyle(
                  color: Colors.grey
              ),
                suffixIcon: Icon(Icons.remove_red_eye_rounded,size: 23,color: Colors.grey,),
                fillColor: Colors.white,
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(color: Colors.grey.withOpacity(0.5)),

                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color:  Colors.grey.withOpacity(0.5),
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

              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),SizedBox(height:55,),
            GestureDetector(
              onTap:  () {
                print("Register pressed");
                setState(() {
                  _isLoading = true;
                });
                Register(emailController.text, passwordController.text,nameController.text);
              },
              child: Container(width: double.infinity,alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 18.5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blueAccent
                ),
                child: Text(
                  'LOGIN',style: TextStyle(
                    color: Colors.white,fontWeight: FontWeight.bold
                ),
                ),
              ),
            ),SizedBox(height:35,),

          ],
        ),
      ),
    );
  }
}
