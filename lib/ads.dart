import 'package:blinkit/comp/button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: use_key_in_widget_constructors
class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls = [
    
    'assets/2.png',
    'assets/2.png',
    'assets/2.png',
    'assets/2.png',
  ];

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
     
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height:250.r,
            
            autoPlay: false, 
            enlargeCenterPage: false, 
            aspectRatio: 16 / 9,
            viewportFraction: 0.97,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
          items: imageUrls.map((url) {
            return Container(
              width: width*0.95,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("1.jpeg"),fit: BoxFit.cover),
                
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("No time for\na diaper run?",style: Theme.of(context).textTheme.headlineSmall,),
                    Text("Get baby care\nessentails in minutes",style: Theme.of(context).textTheme.titleMedium),
                    Button()
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
