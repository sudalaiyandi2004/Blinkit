// ignore_for_file: file_names


import 'package:blinkit/blocs/items_bloc/items_bloc.dart';
import 'package:blinkit/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SmallCard extends StatefulWidget {
  final List<Items> originalItems;
  const SmallCard({super.key,required this.originalItems});
  
  @override
  State<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> {
 
  late final AuthBloc authBloc;
  @override
  void initState() {
    super.initState();
    
    authBloc = BlocProvider.of<AuthBloc>(context);
   
    
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          
          
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: widget.originalItems.map((data){
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(data.img),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(18.r),
                       
                      ),
                      width: width * 0.3,
                      height: 130.h,
              
              ),
              SizedBox(height: 5,),
              Text(data.name,style: Theme.of(context).textTheme.titleMedium)
            ],
          );
        
        }).toList(),
      ),
    );
        });
  }
}