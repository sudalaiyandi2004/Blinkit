import 'dart:async';
import 'package:dio/dio.dart';
import '../core/api_repository/api_repository.dart';
import '../models/ads.dart';
import '../models/items.dart';

class AuthService extends ApiRepository {

//************************************ log-in *********************************//
  Future<Map<String, dynamic>?> getAds(
      ) async {
        
    final Response<dynamic> res = await ApiRepository.apiClient.get(
      '/itemss',
      
    );
   
    List<Products> response=Products.listFromJson(res.data);
 
    return <String, dynamic>{'data':response };
  }
  Future<Map<String, dynamic>?> getItems(
      ) async {
        
    final Response<dynamic> res = await ApiRepository.apiClient.get(
      '/items',
      
    );
   
    Map<String, List<Items>> response=Items.listFromJson(res.data);
 
    return <String, dynamic>{'data':response };
  }

//************************************ log-out *********************************//
  Future<Response<dynamic>> logOut(
      {Map<String, String>? headersToApi}) async {
    final Response<dynamic> res = await ApiRepository.apiClient.delete(
      '/user_management/employee/logout',
      options: Options(headers: headersToApi)
    );
    return res;
  }
}
