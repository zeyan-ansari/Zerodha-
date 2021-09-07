import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sizeconfig.dart';

class UserProfile extends StatefulWidget {
  final String Name;
  final String Email;

   UserProfile({ this.Name, this.Email});


  @override
  _UserProfileState createState() => _UserProfileState(Name: Name,Email: Email);
}

class _UserProfileState extends State<UserProfile> {
  final String Name;
  final String Email;

  _UserProfileState({ this.Name, this.Email});
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
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Name,style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 25
                      )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                      Text(Email,style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                      ),),
                    ],
                  ),
                  Container(
                    width: 90,
                    height: 90,
                    child: Center(child: Text(Name.characters.first.toUpperCase(),style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue[200]
                    ),)),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[50]),
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
                      Text(Email,style: TextStyle(
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
                  // SizedBox(height: 15,),
                  // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //
                  //   children: [
                  //     Text('PAN',style: TextStyle(
                  //         color: Colors.grey,
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 15
                  //     )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                  //     Text('*0235',style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 15
                  //     ),),
                  //   ],
                  // ),
                  // SizedBox(height: 15,),
                  // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //
                  //   children: [
                  //     Text('Demat (BO)',style: TextStyle(
                  //         color: Colors.grey,
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 15
                  //     )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
                  //     Text('1252356335002',style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 15
                  //     ),),
                  //   ],
                  // ),

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
            // Container(color: Colors.white,
            //   padding: EdgeInsets.all(20),
            //   child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text('Bank accounts',style: TextStyle(
            //           color: Colors.grey,
            //           fontWeight: FontWeight.w400,
            //           fontSize: 16
            //       )),SizedBox(height: SizeConfig.blockSizeVertical*2,),
            //       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //
            //         children: [
            //           Text('STATE BANK OF INDIA',style: TextStyle(
            //               color: Colors.grey,
            //               fontWeight: FontWeight.w400,
            //               fontSize: 15
            //           )),SizedBox(height: SizeConfig.blockSizeVertical*1,),
            //           Text('*2586',style: TextStyle(
            //               color: Colors.black,
            //               fontSize: 15
            //           ),),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

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
