
import 'package:blinkit/alls.dart';
import 'package:blinkit/bloc/bloc.dart';
import 'package:blinkit/bloc/event.dart';
import 'package:blinkit/bloc/state.dart';

import 'package:blinkit/comp/tf.dart';
import 'package:blinkit/electronics.dart';

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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ListBloc>().add(LoadItems());
     
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<ListBloc>().add(LoadMoreItems()); 
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
   
  
  @override
  Widget build(BuildContext context) {
   
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
        length: 3,
        child: NestedScrollView(
          
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.amber,
                expandedHeight: 30, 
                pinned: false, 
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.amber,
                    alignment: Alignment.center,
                    child: ListTile(title: Text("Blinkit",style: Theme.of(context).textTheme.headlineSmall,),
                    trailing: Icon(Icons.account_circle,size: 40,),)
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
                  Center(child: Text('Content for Tab 3')),
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

  _SliverPersistentHeaderWithTabBarDelegate({
    required this.minHeight,
    required this.maxHeight,
  });
   int _selectedIndex = 0;
   final List<Color> _appBarColors = [
    Colors.amber,
    Colors.green,
    Colors.orange,
  ];
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
    return Container(
      color: _selectedIndex==0 ? color : _appBarColors[_selectedIndex],
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
                
                SharedPreferences prefs=await SharedPreferences.getInstance();
                await prefs.setInt("index", _selectedIndex);
              
            },
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                tabs('All',Icon(Icons.all_inclusive,size: 30.r,)),
                tabs('Electronics',Icon(Icons.speaker,size: 30.r,)),
                tabs('Fashion',Icon(Icons.face_sharp,size: 30.r,)),
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
  }

  Tab tabs(name,icons) => Tab(text: name,icon: icons);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

