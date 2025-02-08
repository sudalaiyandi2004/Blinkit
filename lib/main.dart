
import 'package:blinkit/appBar.dart';
import 'package:blinkit/bloc/bloc.dart';


import 'package:blinkit/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      splitScreenMode: true,
      minTextAdapt: true, 
      builder: (context,child) => MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
        create: (context) => ListBloc(),
        child: Home(),
      ),
      ),
    );
  }
}


