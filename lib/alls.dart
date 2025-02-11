import 'package:blinkit/ads.dart';
import 'package:blinkit/bloc/bloc.dart';
import 'package:blinkit/bloc/state.dart';

import 'package:blinkit/cards.dart';
import 'package:blinkit/grid.dart';
import 'package:blinkit/smallCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: camel_case_types
class alls extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const alls({super.key,required this.items});

  @override
  State<alls> createState() => _allsState();
}

// ignore: camel_case_types
class _allsState extends State<alls> {
  late List<Map<String, dynamic>> items;

  @override
  void initState() {
    super.initState();
    items = List<Map<String, dynamic>>.from(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        if (state.isLoading && state.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage.isNotEmpty) {
          return Center(child: Text(state.errorMessage));
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false, scrollbars: false),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    SizedBox(height: 250.h, child: ImageCarousel()),
                    SizedBox(height: 10.h),
                    Text(
                      "Today's Special",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold,fontSize: 22),
                    ),
                    SizedBox(height: 20),
                    Cards(originalItems: state.originalItems['special'] ?? []),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.deepPurpleAccent,
                          minimumSize: Size(width * 0.9, 50),
                        ),
                        child: Text(
                          "See all products >",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Grocery & Kitchen",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.h),
                    SmallCard(originalItems: state.originalItems['grocery'] ?? []),
                    SizedBox(height: 20.h),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.deepPurpleAccent,
                          minimumSize: Size(width * 0.9, 50),
                        ),
                        child: Text(
                          "See all products >",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Electronics",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    SmallCard(originalItems: state.originalItems['electronics'] ?? []),
                    SizedBox(height: 20.h),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.deepPurpleAccent,
                          minimumSize: Size(width * 0.9, 50),
                        ),
                        child: Text(
                          "See all products >",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Fashion",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Gird(originalItems: state.originalItems['Fashion'] ?? []),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.deepPurpleAccent,
                          minimumSize: Size(width * 0.9, 50),
                        ),
                        child: Text(
                          "See all products >",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
             
        );
      },
    );
  }
}
