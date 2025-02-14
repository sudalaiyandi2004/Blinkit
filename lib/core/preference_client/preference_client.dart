import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ads.dart';
import '../../models/items.dart';

class PreferencesClient {
  PreferencesClient({required this.prefs});

  final SharedPreferences prefs;

  Future<List<Products>> getAds() async {
    final String? userString = prefs.getString('appUser');
    if (userString == null || userString.isEmpty) {
      return [];
    }
    final List<Map<String, dynamic>> user = json.decode(userString) as List<Map<String, dynamic>>;
    return Products.listFromJson(user);
  }

  void saveAds({List<Products>? appUser}) {
    if (appUser == null) {
      prefs.setString('appUser', '');
      return;
    }
    final String userString = json.encode(appUser);
    
    prefs.setString('appUser', userString);
  }
  Future<Map<String, List<Items>>> getItem() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userString = prefs.getString('appItem');
  if (userString == null || userString.isEmpty) {
    return {};
  }

  
  
  final Map<String, dynamic> user = json.decode(userString);
  
return Items.listFromJsons(user);
  
}

  void saveItem({Map<String, List<Items>>? appUser}) {
    if (appUser == null) {
      prefs.setString('appItem', '');
      return;
    }
    final String userString = json.encode(appUser);
    
    prefs.setString('appItem', userString);
  }
  Future<int?> getCart() async {
    final int? cart = prefs.getInt('appCart');
    
    
    return cart;
  }

  void saveCart(int? appCart) async{
    
      
    
    prefs.setInt('appCart', appCart ?? 0);
  }
  
}
 
  
