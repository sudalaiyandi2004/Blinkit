
import 'package:blinkit/blocs/items_bloc/items_bloc.dart';
import 'package:blinkit/cards.dart';



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Electronics extends StatefulWidget {

  const Electronics({super.key});

  @override
  State<Electronics> createState() => _ElectronicsState();
}

class _ElectronicsState extends State<Electronics> {
  
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
                  
                    Text("Sounds",style:Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(height: 20,),
                    Cards(originalItems: 'electronics'),
                    SizedBox(height: 20,),
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