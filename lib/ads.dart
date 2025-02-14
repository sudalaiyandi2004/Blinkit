
import 'package:blinkit/blocs/ads_bloc/ads_bloc.dart';
import 'package:blinkit/comp/button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageCarousel extends StatefulWidget {

  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final List<String> imageUrls = [
    'assets/1.jpeg',
    'assets/5.jpeg',
    'assets/1.jpeg',
    'assets/5.jpeg',
  ];
  late final AppBloc  appBloc;
  @override
  void initState(){
    super.initState();
     appBloc = BlocProvider.of<AppBloc>(context);
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          
          
    return Scaffold(
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 225.h, 
            autoPlay: false,
            enlargeCenterPage: false,
            aspectRatio: 16 / 9,
            viewportFraction: 1.07,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
          items: (appBloc.stateData.ads ??[]).map((item) {
            return Container(
              width: 0.95.sw, 
              
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item.img),
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
                        item.title,
                        softWrap: true,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    SizedBox(
                      width: 0.5.sw,
                      
                      child: Text(
                        softWrap: true,
                        maxLines: 2,
                        item.subtitle,
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
