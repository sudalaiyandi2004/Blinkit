import 'package:blinkit/ads.dart';

import 'package:blinkit/blocs/items_bloc/items_bloc.dart';
import 'package:blinkit/cards.dart';

import 'package:blinkit/grid.dart';
import 'package:blinkit/smallCard.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
class alls extends StatefulWidget {
 
  const alls({super.key});

  @override
  State<alls> createState() => _allsState();
}

// ignore: camel_case_types
class _allsState extends State<alls> {
  
  late final AuthBloc authBloc;
  

  @override
  void initState(){
    super.initState();
     authBloc = BlocProvider.of<AuthBloc>(context);
     
  }
   
   
    
   
  

  @override
  Widget build(BuildContext context) {
    
    final width = MediaQuery.of(context).size.width;
    
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
       
        return 
         Padding(
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
                    Cards(originalItems: 'special'),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.deepPurpleAccent,
                          minimumSize: Size(width * 0.9, 50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See all products",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Color(0xff115056)),
                            ),
                            Icon(Icons.arrow_right,size: 30,color: Color(0xff115056),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Grocery & Kitchen",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.h),
                    SmallCard(originalItems: authBloc.stateData.items?['grocery'] ?? []),
                    SizedBox(height: 20.h),
                    Center(
                      child: ElevatedButton(
                        
                        onPressed: () {
                          
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.deepPurpleAccent,
                          minimumSize: Size(width * 0.9, 50),
                        ),
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See all products",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Color(0xff115056)),
                            ),
                            Icon(Icons.arrow_right,size: 30,color: Color(0xff115056),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Electronics",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    SmallCard(originalItems: authBloc.stateData.items?['electronics'] ?? []),
                    SizedBox(height: 20.h),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.deepPurpleAccent,
                          minimumSize: Size(width * 0.9, 50),
                        ),
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See all products",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Color(0xff115056)),
                            ),
                            Icon(Icons.arrow_right,size: 30,color: Color(0xff115056),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Fashion",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Gird(originalItems: authBloc.stateData.items?['Fashion'] ?? []),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.deepPurpleAccent,
                          minimumSize: Size(width * 0.9, 50),
                        ),
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See all products",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Color(0xff115056)),
                            ),
                            Icon(Icons.arrow_right,size: 30,color: Color(0xff115056),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          
             
        
      },
    );
  }
}
