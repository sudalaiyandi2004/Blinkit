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

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> with AutomaticKeepAliveClientMixin<All> {
  late List<Map<String, dynamic>> items;
  final ScrollController _scrollController = ScrollController();
  late int selectedIndex = 0;
   @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ListBloc>().add(LoadItems());
    _getSelectedIndex();
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

  @override
  Widget build(BuildContext context) {
     super.build(context);
    final List<Color> appBarColors = [
      //Color(0xffffac04),
      Colors.amber,
      Colors.green,
      Colors.redAccent,
      Colors.lightBlueAccent
    ];

    final height = MediaQuery.of(context).size.height;

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
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(scrollbars: false),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    
                    backgroundColor: appBarColors[state.ind],
                    expandedHeight: 80.r, 
                    pinned:false,
                    elevation: 0,
                    floating: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        color: appBarColors[state.ind],
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
                        alls(items: state.items),
                        Electronics(),
                        Fashion(),
                        Groceries(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SliverPersistentHeaderWithTabBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final List<Color> appBarColors = [
    //Color(0xffffac04),
    Colors.amber,
    Colors.green,
    Colors.redAccent,
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

    Color color = Color.lerp(Colors.amber, Color(0xffd6d6d6), percentage)!;

    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        if (state.isLoading && state.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage.isNotEmpty) {
          return Center(child: Text(state.errorMessage));
        }

        return Container(
          
            decoration: BoxDecoration(
             
              color: state.ind == 0 ? color : appBarColors[state.ind],
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
                  dividerColor: state.ind == 0 ? color : appBarColors[state.ind],
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  onTap: (index) async {
                      context.read<ListBloc>().add(updateIndex(index));
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
      },
    );
  }

  Tab tabs(String name, Icon icon) => Tab(text: name, icon: icon);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
