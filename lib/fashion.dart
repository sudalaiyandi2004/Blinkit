
import 'package:blinkit/blocs/items_bloc/items_bloc.dart';

import 'package:blinkit/grid.dart';


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
  
 

 late final AuthBloc authBloc;
  @override
  void initState(){
    super.initState();
     authBloc = BlocProvider.of<AuthBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
      return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          
          
    return Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  
                    Text("Men's Clothing",style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),),
                    SizedBox(height: 20.h,),
                    
                   Gird(originalItems: authBloc.stateData.items?['Fashion'] ?? []),
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
                    SmallCard(originalItems: authBloc.stateData.items?['female'] ?? []),
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