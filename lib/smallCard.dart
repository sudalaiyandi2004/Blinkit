import 'package:blinkit/bloc/bloc.dart';
import 'package:blinkit/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SmallCard extends StatefulWidget {
  
  const SmallCard({super.key});

  @override
  State<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> {
 

  @override
  void initState() {
    super.initState();
   
    
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: state.items.map((data){
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(data['img']),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      width: width * 0.3,
                      height: 130.h,
              
              ),
              SizedBox(height: 5,),
              Text(data['name'])
            ],
          );
        
        }).toList(),
      ),
    );
        });
  }
}