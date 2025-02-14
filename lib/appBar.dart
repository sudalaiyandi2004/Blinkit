// ignore_for_file: file_names

import 'package:blinkit/about.dart';
import 'package:blinkit/all.dart';

import 'package:blinkit/blocs/items_bloc/items_bloc.dart';
import 'package:blinkit/core/preference_client/preference_client.dart';
import 'package:blinkit/history.dart';
import 'package:blinkit/print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> _pages = [];
  late final AuthBloc authBloc;
  var des=false;
  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
   
    context.read<AuthBloc>().add(GetCartValue());
  }
  Future<int?> cartValue()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? vals = await PreferencesClient(prefs: prefs).getCart();
    return vals;
   }

  @override
  void initState() {
    super.initState();
   
    if(des==false){
    context.read<AuthBloc>().add(CallItemsApi());
    des=true;
    }
    _pages = [All(), About(), History(), Print()];
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    
    
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          
        }
        
        if (state is StateData) {
          
         
          return Scaffold(
            body: _pages[_currentIndex],
            floatingActionButton: (state.cart ?? 0) > 0
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
                          (state.cart ?? 0) > 1
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
                          if ((state.cart ?? 0) > 1)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                            ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("View Cart", style: Theme.of(context).textTheme.displayLarge),
                              Text("${state.cart ?? 0} Items", style: Theme.of(context).textTheme.displayLarge),
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
        } else {
          return Container();
        }
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
