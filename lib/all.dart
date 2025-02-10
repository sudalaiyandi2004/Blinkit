
import 'package:blinkit/alls.dart';
import 'package:blinkit/bloc/bloc.dart';
import 'package:blinkit/bloc/event.dart';
import 'package:blinkit/bloc/state.dart';

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
  final int indexs=0;

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  late List<Map<String, dynamic>> items;

 final ScrollController _scrollController = ScrollController();
  late int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ListBloc>().add(LoadItems());
    _getSelectedIndex();
     
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
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
  
  
  @override
  Widget build(BuildContext context) {
    final List<Color> appBarColors = [
    Colors.amber,
    Colors.green,
    Colors.orange,
    Colors.lightBlueAccent
  ];
   
    
    final height=MediaQuery.of(context).size.height;
    
    return Scaffold(  
      body: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          if (state.isLoading && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage.isNotEmpty) {
            return Center(child: Text(state.errorMessage));
          }
         
 return DefaultTabController(
        length: 4,
        child: NestedScrollView(
          
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: appBarColors[selectedIndex],
                expandedHeight: 30, 
                pinned: false, 
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color:  appBarColors[state.ind],
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(title: Text("Blinkit",style: Theme.of(context).textTheme.headlineSmall,),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                        },
                        child: CircleAvatar(backgroundColor: Colors.white,child: Icon(Icons.person,color: Colors.black,size: 30,))),),
                    )
                  ),
                ),
              ),
               SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverPersistentHeaderWithTabBarDelegate(
                    minHeight:height*0.20,
                    maxHeight:height*0.20
                    
                  ),
                ),
                SliverFillRemaining(
                   
              child: TabBarView(
                children: [
                  alls(items: state.items),
                  Electronics(),
                  Fashion(),
                  Groceries()
                ],
              ),
            ),
            ];
          },
          body:
          Container()
          
        ),
      );
        })
       
    );
  }
}
class _SliverPersistentHeaderWithTabBarDelegate extends SliverPersistentHeaderDelegate {
  
  // ignore: prefer_typing_uninitialized_variables
  var minHeight;
  
  // ignore: prefer_typing_uninitialized_variables
  var maxHeight;
  int _selectedIndex = 0;
   final List<Color> appBarColors = [
    Colors.amber,
    Colors.green,
    Colors.orange,
    Colors.lightBlueAccent
  ];
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
        double percentage = (shrinkOffset / maxExtent).clamp(0.0, 1.0);
    
    Color color = Color.lerp(Colors.amber, Colors.grey, percentage)!;
    return BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          
          if (state.isLoading && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage.isNotEmpty) {
            return Center(child: Text(state.errorMessage));
          }
          
    return Container(
      color: state.ind==0 ? color : appBarColors[state.ind],
      child: Padding(
        padding: const EdgeInsets.only(top:12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Texts()
            ),
            
            TabBar(
              onTap: (index) async{
        
                _selectedIndex = index;
                
                context
                            .read<ListBloc>()
                            .add(updateIndex(_selectedIndex));
                
              
            },
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                tabs('All',Icon(Icons.all_inclusive,size: 30.r,)),
                tabs('Electronics',Icon(Icons.speaker,size: 30.r,)),
                tabs('Fashion',Icon(Icons.face_sharp,size: 30.r,)),
                tabs('Groceries',Icon(Icons.toys,size: 30.r,)),
                tabs('Kids',Icon(Icons.toys,size: 30.r,)),
                tabs('Gifts',Icon(Icons.card_giftcard_sharp,size: 30.r,)),
                
                
              ],
              labelStyle: Theme.of(context).textTheme.titleMedium,
            
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.black,
            ),
          ],
        ),
      ),
    );
        });
  }

  Tab tabs(name,icons) => Tab(text: name,icon: icons);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

