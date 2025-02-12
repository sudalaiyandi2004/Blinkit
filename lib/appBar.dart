// ignore_for_file: file_names

import 'package:blinkit/about.dart';
import 'package:blinkit/all.dart';
import 'package:blinkit/bloc/bloc.dart';
import 'package:blinkit/bloc/state.dart';
import 'package:blinkit/history.dart';
import 'package:blinkit/print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<Widget> _pages = [];
  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

   @override
  void initState() {
    super.initState();
    _pages = [All(), About(), History(), Print()];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        if (state.isLoading && state.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage.isNotEmpty) {
          return Center(child: Text(state.errorMessage));
        }

       
        

        return Scaffold(
          body:IndexedStack(index: _currentIndex,children: _pages,),
          floatingActionButton: state.cart > 0
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                
                  child: FloatingActionButton.extended(
                    onPressed: () {},
                    backgroundColor: Colors.green,
                    icon: Stack(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/3.jpeg'),
                        ),
                        state.cart > 1
                            ? Positioned(
                                left: 20,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage('assets/3.jpeg'),
                                ),
                              )
                            : Container()
                      ],
                    ),
                    label: Row(
                      children: [
                        if (state.cart > 1)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("View Cart", style: Theme.of(context).textTheme.displayLarge),
                            Text("${state.cart} Item", style: Theme.of(context).textTheme.displayLarge),
                          ],
                        ),
                        const Icon(Icons.arrow_right),
                      ],
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: _onTabSelected,
            items: [
              bnb("Home", Icons.home_outlined),
              bnb("Bag", Icons.shopping_bag_outlined),
              bnb("Category", Icons.category_outlined),
              bnb("Print", Icons.print_outlined),
            ],
          ),
        );
      },
    );
  }

  BottomNavigationBarItem bnb(val, ico) {
    return BottomNavigationBarItem(
      icon: Icon(ico),
      label: val,
    );
  }
}