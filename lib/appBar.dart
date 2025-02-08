import 'package:blinkit/about.dart';

import 'package:blinkit/all.dart';

import 'package:blinkit/history.dart';
import 'package:blinkit/print.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
     List<Widget> _pages=[];
     void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index; 
    });
  }
  @override
  void initState() {
    super.initState();
    
    setState(() {
      _pages=[
        All(),
    About(),
    History(),
    Print()
  ];
    });
    }
  final TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      body:_pages[_currentIndex],
       bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabSelected, 
        items:  [
          bnb("Home",Icons.home),
          bnb("Settings",Icons.settings),
          bnb("History",Icons.history),
          bnb("Print",Icons.print)
        ],
      ),
    );
  }
  BottomNavigationBarItem bnb(val,ico) {
    return BottomNavigationBarItem(
          icon: Icon(ico),
          label: val,
        );
  }
 
}

