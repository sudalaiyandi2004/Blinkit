
import 'package:blinkit/appBar.dart';

import 'package:blinkit/blocs/ads_bloc/ads_bloc.dart';
import 'package:blinkit/blocs/items_bloc/items_bloc.dart';


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
        home: MultiBlocProvider(
          providers:[ 
          BlocProvider(
          create: (context) => AppBloc()),
          BlocProvider(
          create: (context) => AuthBloc())],
          child: Home(),
                ),
        ),
      );
    
  }
}


