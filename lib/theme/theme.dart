import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Color(0xFFDBE9F4),
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    secondary: Colors.white,
    surface: Color(0xFFE7EAE5)
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  iconTheme: IconThemeData(
          color: Colors.black, 
          
        ),
  
  textTheme:  TextTheme(
       titleMedium: TextStyle(color: Colors.black,fontSize: 15.sp,fontFamily: 'mer',fontWeight: FontWeight.bold),
    titleSmall: TextStyle(color: Colors.grey,fontSize: 10.sp,fontFamily: 'mer',fontWeight: FontWeight.bold),
     headlineLarge: TextStyle(fontSize: 60.sp,color: Colors.black,fontFamily: 'mer',fontWeight: FontWeight.bold),
     headlineMedium: TextStyle(color: Colors.black,fontSize: 40.sp,fontWeight: FontWeight.bold,fontFamily: 'mer'),
     headlineSmall: TextStyle(color: Colors.black,fontSize: 30.sp,fontWeight: FontWeight.bold,fontFamily: 'mer'),
     displaySmall: TextStyle(fontSize: 20.sp,color: Colors.black,fontFamily: 'lo'),
     displayMedium: TextStyle(color: Colors.white,fontSize: 10.sp,fontWeight: FontWeight.bold,fontFamily: 'mer'),
     displayLarge: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.bold,fontFamily: 'mer'),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFE7EAE5),
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.black,
    selectedIconTheme: IconThemeData(
      color: Colors.amber
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.black
    )
  )
);