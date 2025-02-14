// ignore_for_file: file_names

import 'package:blinkit/alls.dart';
import 'package:blinkit/bloc/bloc.dart';
import 'package:blinkit/bloc/event.dart';

import 'package:blinkit/blocs/ads_bloc/ads_bloc.dart';
import 'package:blinkit/blocs/items_bloc/items_bloc.dart';

import 'package:blinkit/comp/tf.dart';
import 'package:blinkit/electronics.dart';
import 'package:blinkit/fashion.dart';
import 'package:blinkit/groceries.dart';
import 'package:blinkit/profile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All>  {
  late List<Map<String, dynamic>> items;
  final ScrollController _scrollController = ScrollController();
  late int selectedIndex = 0;
  late final AuthBloc authBloc;
  late bool des=false;
  Future<void>setIndex(int value) async {
  // Get SharedPreferences instance
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Set value for the given key
  await prefs.setInt('ind', value);


}
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    setIndex(0);
   
    if(des==false){
    context.read<AppBloc>().add(CallAdsApi());
    
    des=true;
    }
    authBloc = BlocProvider.of<AuthBloc>(context);
    _getSelectedIndex();
    context.read<AuthBloc>().add(GetCartValue());
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<ListBloc>().add(LoadMoreItems());
    }
  }

  void _getSelectedIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedIndex = prefs.getInt("index") ?? 0;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  Future<int?>getIndex() async {
  
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  
  return  prefs.getInt('ind');

}
int? currentIndexs=0;
  @override
  Widget build(BuildContext context) {
      
    final List<Color> appBarColors = [
      //Color(0xffffac04),
      Colors.amber,
      Colors.green,
      Colors.redAccent,
      Colors.lightBlueAccent
    ];
    
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          
          getIndex().then((result) {
      currentIndex=result ?? 0;
    
    });
          
         
          if(state is StateData){
          
          return DefaultTabController(
            length: 4,
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(scrollbars: false),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    
                    backgroundColor: appBarColors[currentIndex],
                    expandedHeight: 80.r, 
                    pinned:false,
                    elevation: 0,
                    floating: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: appBarColors[currentIndex],
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            title: Text(
                              "Blinkit",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Profile()),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverPersistentHeaderWithTabBarDelegate(
                      minHeight: height * 0.2, 
                      maxHeight: height * 0.2, 
                    ),
                  ),
                  SliverFillRemaining(
                    child: TabBarView(
                      children: [
                        alls(),
                        Electronics(),
                        Fashion(),
                        Groceries(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );}
          else{
            return Container();
          }
        }
      )
    );
    
  }
}
int currentIndex=0;
class _SliverPersistentHeaderWithTabBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final List<Color> appBarColors = [
    Colors.amber,
      Colors.green,
      Colors.redAccent,
      Colors.lightBlueAccent
  ];
  
      Future<void>setIndex(int value) async {
  // Get SharedPreferences instance
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Set value for the given key
  await prefs.setInt('ind', value);


}

Future<int?>getIndex() async {
  // Get SharedPreferences instance
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Set value for the given key
  return  prefs.getInt('ind');

}
  _SliverPersistentHeaderWithTabBarDelegate({
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;
  
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    
    BlocProvider.of<AuthBloc>(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
          
        if (state is StateData) {
         
          final Color backgroundColor = (currentIndex == 0 )
            ? Color.lerp(Colors.amber, Color(0xffd6d6d6), shrinkOffset / maxExtent)!
            : appBarColors[currentIndex];

          return Container(
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Texts(),
                  ),
                  TabBar(
                    dividerColor: backgroundColor,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    onTap: (index) {
                      currentIndex=index;
                      setIndex(index);
                      context.read<AuthBloc>().add(GetCartValue());
                    },
                    tabs: [
                      tabs('All', Icon(Icons.shopping_bag, size: 30.r)),
                      tabs('Electronics', Icon(Icons.headphones_outlined, size: 30.r)),
                      tabs('Fashion', Icon(Icons.face_sharp, size: 30.r)),
                      tabs('Groceries', Icon(Icons.local_grocery_store_rounded, size: 30.r)),
                      tabs('Kids', Icon(Icons.toys, size: 30.r)),
                      tabs('Gifts', Icon(Icons.card_giftcard_sharp, size: 30.r)),
                    ],
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    labelColor: Colors.black,
                    unselectedLabelColor: Color(0xFF24181c),
                    indicatorColor: Colors.black,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Tab tabs(String name, Icon icon) => Tab(text: name, icon: icon);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}