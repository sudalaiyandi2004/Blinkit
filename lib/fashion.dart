
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  
                    Text("Men's Clothing",style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),),
                    SizedBox(height: 20.h,),
                    
                    Cards(originalItems: filterByGender(state.originalItems['Fashion'] ?? [], 'male')),
                    SizedBox(height: 20.h,),
                    
                    
                    Center(child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(foregroundColor: Colors.deepPurpleAccent,minimumSize: Size(width*0.9, 50)), 
                     child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See all products",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Color(0xff115056)),
                            ),
                            Icon(Icons.arrow_right,size: 30,color: Color(0xff115056),)
                          ],
                        ),)),
                    SizedBox(height: 20.h,),
                    Text("Women's Clothing",style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),),
                    SizedBox(height: 20.h,),
                    SmallCard(originalItems: filterByGender(state.originalItems['Fashion'] ?? [], 'female')),
                    SizedBox(height: 20.h,),
                    Center(child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(foregroundColor: Colors.deepPurpleAccent,minimumSize: Size(width*0.9, 50)), 
                     child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See all products",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Color(0xff115056)),
                            ),
                            Icon(Icons.arrow_right,size: 30,color: Color(0xff115056),)
                          ],
                        ),))
              
                    
                ],
              ),
            ),
          );
        });
  }
}