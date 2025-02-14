
import 'package:blinkit/blocs/items_bloc/items_bloc.dart';
import 'package:blinkit/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Gird extends StatefulWidget {
  final List<Items> originalItems;
  const Gird({super.key,required this.originalItems});

  @override
  State<Gird> createState() => _GirdState();
}

class _GirdState extends State<Gird> {
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          
          
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
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(18.r),
      
      ),
      
      height: 130.h,
      width: 0.3*width,
      child: Column(
        children: [
          Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(10.r),child: Image.network(data.img,
))),
          SizedBox(height: 5,),
          Text(data.name,style: Theme.of(context).textTheme.titleMedium)
        ],
      ),
    );
  },
);


    
       
    
        });
  }
}