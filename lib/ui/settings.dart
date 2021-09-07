import 'package:flutter/material.dart';

import '../sizeconfig.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed:() =>Navigator.pop(context)
        ),
        elevation: 0,
        backgroundColor: Colors.white,

        title: Text('Profile',style: TextStyle(
            color: Colors.black
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Theme',style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                  )),SizedBox(height: SizeConfig.blockSizeVertical*2,),
                  Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Light',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15
                        )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                        Radio(value: true, groupValue: 1, onChanged:null),
                      ],
                    ),
                  ),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                  Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Dark',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15
                        )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                        Radio(value: true, groupValue: 1, onChanged:null),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Detailed profile',style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 15
                  )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                  Text('Manage account',style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 15
                  ),),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text('E-mail',style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 15
                      )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                      Text('zeyan@gmail.com',style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text('Phone',style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 15
                      )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                      Text('*7935',style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text('PAN',style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 15
                      )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                      Text('*0235',style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text('Demat (BO)',style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 15
                      )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                      Text('1252356335002',style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),),
                    ],
                  ),

                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Password & Security',style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 15
                  )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                  Text('Manage',style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 15
                  ),),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bank accounts',style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 16
                  )),SizedBox(height: SizeConfig.blockSizeVertical*2,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text('STATE BANK OF INDIA',style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 15
                      )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                      Text('*2586',style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Segments',style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 15
                  )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                  Text('MF',style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 15
                  ),),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('View active sessions',style: TextStyle(decoration: TextDecoration.underline,
                      letterSpacing: 1,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w400,
                      fontSize: 15
                  )),SizedBox(height: SizeConfig.blockSizeVertical*1,),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
