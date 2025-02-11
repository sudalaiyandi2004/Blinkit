import 'package:blinkit/bloc/bloc.dart';
import 'package:blinkit/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Gird extends StatefulWidget {
  final List<Map<String, dynamic>> originalItems;
  const Gird({super.key,required this.originalItems});

  @override
  State<Gird> createState() => _GirdState();
}

class _GirdState extends State<Gird> {
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
   return GridView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
  ),
  itemCount: widget.originalItems.length,
  itemBuilder: (context, index) {
    var data = widget.originalItems[index];
    return Container(
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),
      boxShadow: [
      BoxShadow(
        // ignore: deprecated_member_use
        color: Colors.black.withOpacity(0.3),
        offset: Offset(4, 4),  
        blurRadius: 8, 
        spreadRadius: 1, 
      ),
    ],
      ),
      
      height: 130.h,
      width: 0.3*width,
      child: Column(
        children: [
          Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(10.r),child: Image.network(data['img'],
))),
          SizedBox(height: 5,),
          Text(data['name'],style: Theme.of(context).textTheme.titleMedium)
        ],
      ),
    );
  },
);


    
       
    
        });
  }
}