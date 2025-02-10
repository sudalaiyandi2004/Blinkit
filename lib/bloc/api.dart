
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages


class UserRepositors {
  
  final Dio dio=Dio();
 

 
  Future<List<dynamic>> fetchItems() async {
    try {
   
    Response response = await Dio().get("http://localhost:4000/items",
      
      options: Options(
        receiveTimeout: Duration(seconds: 5),
        sendTimeout: Duration(seconds: 5),
      ),
    );
    
    return response.data;
  } on DioException catch (e) {
    
    if (e.type == DioExceptionType.connectionTimeout) {
    
    } else if (e.type == DioExceptionType.receiveTimeout) {
  
    } else {
   
    }
    return [];
  }
  }


  



}


