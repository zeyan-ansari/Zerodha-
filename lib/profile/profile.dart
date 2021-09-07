import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zerodhaui/ui/UserProfile.dart';
import 'package:zerodhaui/ui/funds.dart';
import 'package:zerodhaui/ui/settings.dart';
import 'package:http/http.dart' as http;
import 'package:zerodhaui/Models/userProfile_models.dart';
import '../sizeconfig.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

Future<ProfileUser> fetchProfileUser() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse('http://stockapp.techverden.com/api/v1/account/user'),
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          'Bearer ${sharedPreferences.get('token')}',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ProfileUser.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class _ProfileState extends State<Profile> {
  Future<ProfileUser> futureProfileUser;

  @override
  void initState() {
    super.initState();
    futureProfileUser = fetchProfileUser();
  }

  TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 2,
      child: FutureBuilder<ProfileUser>(
          future: futureProfileUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                  appBar: AppBar(
                      leading: null,
                      centerTitle: false,
                      elevation: 0,
                      backgroundColor: Color(0xFFEEEEEE),
                      title: Text(
                        'Account',
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  snapshot.data.data.name,
                                  style: TextStyle(
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  body: SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: Color(0xFFEEEEEE),
                          height: SizeConfig.blockSizeVertical * 5,
                        ),
                        Positioned(
                          top: SizeConfig.blockSizeVertical * 2,
                          left: SizeConfig.blockSizeHorizontal * 4,
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                blurRadius: 13.0,
                                color: Colors.black.withOpacity(.03),
                                offset: Offset(1.0, 7.0),
                              )
                            ]),
                            width: SizeConfig.blockSizeHorizontal * 92,
                            height: SizeConfig.blockSizeVertical * 12,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                          snapshot.data.data.id.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 21),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.blockSizeVertical * 1,
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshot.data.data.email,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                          child: Container(
                                        width: 60,
                                        height: 60,
                                        child: Center(
                                            child: Text(
                                                snapshot.data.data.name.characters.first.toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.blue[200]),
                                        )),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue[50]),
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: SizeConfig.blockSizeVertical * 15,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Funds()),
                                  );
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 14.0),
                                    child: ListTile(
                                      title: Text('Funds'),
                                      trailing: Text(
                                        '\u20B9',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.grey),
                                      ),
                                    )),
                              ),
                              Divider(
                                height: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserProfile(Name:snapshot.data.data.name ,Email:snapshot.data.data.email)),
                                  );
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 14.0),
                                    child: ListTile(
                                        title: Text('Profile'),
                                        trailing: Icon(
                                          Icons.person_outline,
                                          color: Colors.grey,
                                          size: 25,
                                        ))),
                              ),
                              Divider(
                                height: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Settings()),
                                  );
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 14.0),
                                    child: ListTile(
                                        title: Text('Settings'),
                                        trailing: Icon(
                                          Feather.settings,
                                          color: Colors.grey,
                                          size: 25,
                                        ))),
                              ),
                              Divider(
                                height: 1,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 14.0),
                                  child: ListTile(
                                      title: Text('Support'),
                                      trailing: Icon(
                                        Feather.info,
                                        color: Colors.grey,
                                        size: 25,
                                      ))),
                              Divider(
                                height: 1,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 14.0),
                                  child: ListTile(
                                      title: Text('Invite Friends'),
                                      trailing: Icon(
                                        MaterialIcons.person_add,
                                        color: Colors.grey,
                                        size: 25,
                                      ))),
                              Divider(
                                height: 1,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 14.0),
                                  child: ListTile(
                                      title: Text('User Manual'),
                                      trailing: Icon(
                                        AntDesign.questioncircleo,
                                        color: Colors.grey,
                                        size: 25,
                                      ))),
                              Divider(
                                height: 1,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 14.0),
                                  child: ListTile(
                                      title: Text('Logout'),
                                      trailing: Icon(
                                        Feather.log_out,
                                        color: Colors.grey,
                                        size: 25,
                                      ))),
                              Divider(
                                height: 1,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 14.0),
                                  child: ListTile(
                                    title: Text(
                                      'Version 3.0.21 Build 109',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )),
                              Divider(
                                height: 1,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }

            // By default, show a loading spinner.
            return Center(child: Container(child: const CircularProgressIndicator()));
          }),
    );
  }
}
