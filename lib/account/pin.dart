import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zerodhaui/ui/HomePage.dart';

class Pin extends StatefulWidget {
  const Pin({Key key}) : super(key: key);

  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            CircleAvatar(radius: 60,
              backgroundImage: NetworkImage('https://www.pngkey.com/png/full/73-730477_first-name-profile-image-placeholder-png.png'),
            ),
            SizedBox(height:110,),
            TextFormField(
              decoration: new InputDecoration(
                labelText: "User ID",labelStyle: TextStyle(
                  color: Colors.grey
              ),
                suffixIcon: GestureDetector(
                  onTap:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Container(margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
                        border: Border.all(color: Colors.blueAccent,width: 2)
                      ),
                      child: Icon(Icons.keyboard_arrow_right_rounded,color: Colors.blueAccent,size: 20,)),
                ),
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
            ),SizedBox(height:10,),
            Container(margin: EdgeInsets.symmetric(horizontal: 5,),
              padding: EdgeInsets.symmetric(vertical: 23,horizontal: 0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(

                      child: Icon(Icons.fingerprint,size: 28,color: Colors.grey,)),
                  SizedBox(width:10,),
                  Text('Enable Fingerprint in settings after\nlogin',style: TextStyle(fontSize: 15,color: Colors.grey),),

                ],
              ),
            ),
            SizedBox(height:10,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ Container(
                  alignment: Alignment.centerRight,
                  child: Text('Switch account',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w400,fontSize: 15),)),
                Container(
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Pin?',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w400,fontSize: 15),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
