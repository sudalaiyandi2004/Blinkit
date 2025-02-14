
import 'package:blinkit/blocs/items_bloc/items_bloc.dart';
import 'package:blinkit/models/items.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cards extends StatefulWidget {
  final String originalItems;

  

  const Cards({super.key,required this.originalItems});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  late List<Map<String, dynamic>> datas;
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
          
         if(state is StateData){
             
       
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: ((authBloc.stateData.items ?? {})[widget.originalItems] ?? []).map((data) {
          
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.img),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(18.r),
                  
                ),
                width: width * 0.3,
                height: 150.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    data.category!='Fashion' ?
                    Padding(
                      padding: EdgeInsets.all(8.r),
                      
                      child: Image.asset(
                        "assets/veg.png",
                        width: 13.w,
                        height: 13.h,
                      ),
                    ) : Container(),
               
                    data.val <= 0
                        ? Padding(
                          padding: EdgeInsets.all(5.r),
                          child: ElevatedButton(
                              onPressed: () {
                              final updatedItem = Items.fromJson({
                                ...data.toJson(),
                                'val': data.val + 1,
                              });
                             
                          
                         context
                              .read<AuthBloc>()
                              .add(UpdateItems(data.id, updatedItem,'add'));
                              
                            
                              
                               
                              
                          
                                              
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 4.h),
                                foregroundColor: Colors.green,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  side: BorderSide(width: 1.w, color: Colors.green),
                                ),
                              ),
                              child: Text("ADD",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                            ),
                        )
                        : Padding(
                          padding: EdgeInsets.all(5.r),
                          child: Container(
                              height: 30.h,
                              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 5.h),
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.green,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      
                                     final updatedItem = Items.fromJson({
                                    ...data.toJson(),
                                    'val': data.val - 1,
                                  });
                                                            
                          context
                              .read<AuthBloc>()
                              .add(UpdateItems(data.id, updatedItem,'sub'));
                             
                              
                          
                                              
                                    },
                                    icon: Icon(Icons.remove, color: Colors.white, size: 14.sp),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(minWidth: 24.w, minHeight: 24.h),
                                  ),
                                  Text(
                                    data.val.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      final updatedItem = Items.fromJson({
                                      ...data.toJson(),
                                      'val': data.val + 1,
                                    });
                                                
                          context
                              .read<AuthBloc>()
                              .add(UpdateItems(data.id, updatedItem,'add'));
                             
                              
                          
                                              
                                    },
                                    icon: Icon(Icons.add, color: Colors.white, size: 14.sp),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(minWidth: 24.w, minHeight: 24.h),
                                  ),
                                ],
                              ),
                            ),
                        ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Color(0xffb3b9e8),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  data.quantity,
                  style: TextStyle(color: Color(0xff6367bb), fontSize: 14.sp,fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                data.name,
                style: Theme.of(context).textTheme.titleMedium
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  icon(),
                  icon(),
                  icon(),
                  icon(),
                  Text("(1032)", style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Icon(Icons.timelapse, color: Colors.green, size: 16.sp),
                  SizedBox(width: 4.w),
                  Text(
                    data.time,
                    style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                data.rate,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10.h),
            ],
          );
        }).toList(),
      ),
    );
        }
        else{
          return Container();
        }});
  }

  Icon icon() => Icon(Icons.star, color: Colors.amber, size: 16.sp);
}
