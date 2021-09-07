import 'package:flutter/cupertino.dart';
import 'package:zerodhaui/watchlist/watchlist1.dart';
import 'package:zerodhaui/watchlist/watchlist2.dart';
import 'package:zerodhaui/watchlist/watchlist3.dart';
import 'package:zerodhaui/watchlist/watchlist4.dart';
import 'package:zerodhaui/watchlist/watchlist5.dart';
import 'package:flutter/material.dart';
import 'package:zerodhaui/sizeconfig.dart';
import 'package:flutter_icons/flutter_icons.dart';
class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin{
  TabController tabController;
  TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        
        appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFFEEEEEE),
            title: Text(
              'Marketwatch',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            actions: <Widget>[
              // Container(margin: EdgeInsets.only(right: 8),
              //   child: Icon(
              //     Icons.keyboard_arrow_down,
              //     size: 45,
              //     color: Colors.black,
              //   ),
              // )
        IconButton(
        icon: Icon(
                Icons.keyboard_arrow_down,
                size: 40,
                color: Colors.black,
              ),
          onPressed: () {
            return showGeneralDialog(
              context: context,
              barrierDismissible: true,
              transitionDuration: Duration(milliseconds: 500),
              barrierLabel: MaterialLocalizations.of(context).dialogLabel,
              barrierColor: Colors.black.withOpacity(0.5),
              pageBuilder: (context, _, __) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Card(
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            ListTile(
                              title: Text('Item 1'),
                              onTap: () => Navigator.of(context).pop('item1'),
                            ),
                            ListTile(
                              title: Text('Item 2'),
                              onTap: () => Navigator.of(context).pop('item2'),
                            ),
                            ListTile(
                              title: Text('Item 3'),
                              onTap: () => Navigator.of(context).pop('item3'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              transitionBuilder: (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ).drive(Tween<Offset>(
                    begin: Offset(0, -1.0),
                    end: Offset.zero,
                  )),
                  child: child,
                );
              },
            );
          }
      )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(35.0),
              child: Column(
                children: <Widget>[

                  TabBar(
                    controller: tabController,
                    isScrollable: true,
                    indicatorColor: Colors.blue,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black,
                    labelPadding: EdgeInsets.symmetric(horizontal: 25),
                    tabs: <Widget>[
                      Tab(
                        text: 'Watchlist 1',
                      ),
                      Tab(
                        text: 'Watchlist 2',
                      ),
                      Tab(
                        text: 'Watchlist 3',
                      ),
                      Tab(
                        text: 'Watchlist 4',
                      ),
                      Tab(
                        text: 'Watchlist 5',
                      ),
                    ],
                  ),


                ],
              ),
            )),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            WatchList1(),
            WatchList2(),
            WatchList3(),
            WatchList4(),
            WatchList5(),
          ],
        ),
      ),
    );

  }
}


