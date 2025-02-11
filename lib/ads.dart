import 'package:blinkit/bloc/bloc.dart';
import 'package:blinkit/bloc/state.dart';
import 'package:blinkit/comp/button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/1.jpeg',
    'assets/5.jpeg',
    'assets/1.jpeg',
    'assets/5.jpeg',
  ];

  ImageCarousel({super.key});

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
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 225.h, 
            autoPlay: false,
            enlargeCenterPage: false,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
          items: state.filteredItems.map((item) {
            return Container(
              width: 0.95.sw, 
              
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item['img']),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.r), 
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0.r), 
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 0.5.sw,
                      child: Text(
                        item['title'],
                        softWrap: true,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    SizedBox(
                      width: 0.5.sw,
                      
                      child: Text(
                        softWrap: true,
                        maxLines: 2,
                        item['subtitle'],
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: 10.h), 
                    Button(), 
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
        });
  }
}
