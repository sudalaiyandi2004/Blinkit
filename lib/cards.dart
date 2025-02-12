import 'package:blinkit/bloc/bloc.dart';
import 'package:blinkit/bloc/event.dart';
import 'package:blinkit/bloc/state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cards extends StatefulWidget {
  final List<Map<String, dynamic>> originalItems;

  

  const Cards({super.key,required this.originalItems});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  late List<Map<String, dynamic>> datas;

  

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
       
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: widget.originalItems.map((data) {
        
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data['img']),
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
                    data['category']!='Fashion' ?
                    Padding(
                      padding: EdgeInsets.all(8.r),
                      
                      child: Image.asset(
                        "assets/veg.png",
                        width: 13.w,
                        height: 13.h,
                      ),
                    ) : Container(),
               
                    data['val'] <= 0
                        ? Padding(
                          padding: EdgeInsets.all(5.r),
                          child: ElevatedButton(
                              onPressed: () {
                                final updatedItem = {
                            ...data,
                            'val': data['val']+1
                                
                          };
                          
                          context
                              .read<ListBloc>()
                              .add(UpdateItem(data['_id'], updatedItem));
                                context
                              .read<ListBloc>()
                              .add(counting('add'));
                               
                              
                          
                                              
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
                                      
                                       final updatedItem = {
                            ...data,
                            'val': data['val']-1
                                
                          };
                          
                          context
                              .read<ListBloc>()
                              .add(UpdateItem(data['_id'], updatedItem));
                              context
                              .read<ListBloc>()
                              .add(counting('sub')); 
                              
                          
                                              
                                    },
                                    icon: Icon(Icons.remove, color: Colors.white, size: 14.sp),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(minWidth: 24.w, minHeight: 24.h),
                                  ),
                                  Text(
                                    data['val'].toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                       final updatedItem = {
                            ...data,
                            'val': data['val']+1
                                
                          };
                                                
                          context
                              .read<ListBloc>()
                              .add(UpdateItem(data['_id'], updatedItem));
                              context
                              .read<ListBloc>()
                              .add(counting('add')); 
                              
                          
                                              
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
                  data['quantity'],
                  style: TextStyle(color: Color(0xff6367bb), fontSize: 14.sp,fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                data['name'],
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
                    data['time'],
                    style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                data['rate'],
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10.h),
            ],
          );
        }).toList(),
      ),
    );
        });
  }

  Icon icon() => Icon(Icons.star, color: Colors.amber, size: 16.sp);
}
