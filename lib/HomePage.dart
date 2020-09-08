import 'package:blogapp/LoginPage.dart';
import 'package:blogapp/PostBlogPage.dart';
import 'package:blogapp/SignUp.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Object> _tabs;
  int _page=0;
  GlobalKey _bottomNavigationKey= GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    _tabs=[LoginPage(),PostBlogPage(),];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomNavigationBar: BottomNavigationBar(
       selectedItemColor: Colors.blue,
       unselectedItemColor: Colors.grey,
       key: _bottomNavigationKey,
       items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(icon: Icon(Icons.home),title:Text('Home') ),
         BottomNavigationBarItem(icon: Icon(Icons.event),title: Text('Events')),
         BottomNavigationBarItem(icon:Icon(Icons.developer_board),title: Text('Services')),
         BottomNavigationBarItem(icon:Icon(Icons.settings),title: Text('Setting')),
       ],
       type: BottomNavigationBarType.fixed,
       currentIndex: _page,
       onTap: (index){
         setState(() {
           _page=index;
         });
       },
     ),
      body: _tabs[_page],
    );
  }
}
