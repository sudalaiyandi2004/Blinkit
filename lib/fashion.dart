
import 'package:blinkit/bloc/bloc.dart';
import 'package:blinkit/bloc/state.dart';
import 'package:blinkit/cards.dart';

import 'package:blinkit/smallCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Fashion extends StatefulWidget {

  const Fashion({super.key});

  @override
  State<Fashion> createState() => _FashionState();
}

class _FashionState extends State<Fashion> {
  
  List<Map<String, dynamic>> filterByGender(List<Map<String, dynamic>> items, String gender) {
  return items.where((item) {
    return item['gender'] == gender;
  }).toList();
}
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
      return BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          
          if (state.isLoading && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage.isNotEmpty) {
            return Center(child: Text(state.errorMessage));
          }
    return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children:[ SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h,),
                    
                      Text("Men's Clothing",style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),),
                      SizedBox(height: 20.h,),
                      
                      Cards(originalItems: filterByGender(state.originalItems['Fashion'] ?? [], 'male')),
                      SizedBox(height: 20.h,),
                      
                      
                      Center(child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(foregroundColor: Colors.deepPurpleAccent,minimumSize: Size(width*0.9, 50)), child: Text("See all products >",style: Theme.of(context).textTheme.titleMedium,),)),
                      SizedBox(height: 20.h,),
                      Text("Women's Clothing",style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),),
                      SizedBox(height: 20.h,),
                      SmallCard(originalItems: filterByGender(state.originalItems['Fashion'] ?? [], 'female')),
                      SizedBox(height: 20.h,),
                      Center(child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(foregroundColor: Colors.deepPurpleAccent,minimumSize: Size(width*0.9, 50)), child: Text("See all products >",style: Theme.of(context).textTheme.titleMedium,),))
                
                      
                  ],
                ),
              ),
              state.cart >0  ? Positioned(
             
            right: 0,
            left: 0,
            bottom: 50.h  ,
              
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: width * 0.50,
                height: 70.h,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child:Center(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(children:[ CircleAvatar(radius: 20,backgroundImage: AssetImage('assets/3.jpeg'),),
                      Positioned(left: 20, child: CircleAvatar(radius: 20,backgroundImage: AssetImage('assets/3.jpeg'),)),
                      Positioned(left: 40, child: CircleAvatar(radius: 20,backgroundImage: AssetImage('assets/3.jpeg'),))]),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 1,
                        children: [
                          Text("View Cart",style: Theme.of(context).textTheme.displayLarge,),
                          Text("${state.cart} Item",style: Theme.of(context).textTheme.displayLarge,),
                          
                        ],
                      ),
                      CircleAvatar(radius: 20, child: Icon(Icons.arrow_right,))
                    ],
                  )
                )
              ),
            ),
          ) : Container(),
              ]
            ),
          );
        });
  }
}