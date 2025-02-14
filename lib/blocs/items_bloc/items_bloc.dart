import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:blinkit/models/models.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_services/auth_service.dart';
import '../../core/base_bloc/base_bloc.dart';
import '../../core/preference_client/preference_client.dart';

part 'items_event.dart';
part 'items_state.dart';

class AuthBloc extends BaseBloc<AppEvent, AuthState> {
  AuthBloc() : super(AuthInitial());
    

  final AuthService authService = AuthService();

  StateData stateData = StateData();
   
  FutureOr<void>_callItemsApi(
      CallItemsApi event, Emitter<AuthState> emit) async {
        
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      
      final Map<String, dynamic>? response=await authService.getItems(); 
    
      final Map<String, List<Items>> user = response?['data'] as Map<String, List<Items>>;
      
      PreferencesClient(prefs: prefs).saveItem(appUser:user);
      emit(stateData..items = user);
  }
  FutureOr<void> _getCartValue(GetCartValue event, Emitter<AuthState> emit) async {
   final SharedPreferences prefs = await SharedPreferences.getInstance();
  int? vals = await PreferencesClient(prefs: prefs).getCart();  
  emit(StateData( cart: vals));
  }
  FutureOr<void> _updateItem(UpdateItems event, Emitter<AuthState> emit) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int? vals = await PreferencesClient(prefs: prefs).getCart(); 

  final Map<String, List<Items>> updatedItems = Map.from(stateData.items ?? {});
 
  
  bool itemUpdated = false;

  updatedItems.forEach((key, value) {
    for (var i = 0; i < value.length; i++) {
      var item = value[i];

      if (item.id == event.index) {
        updatedItems[key]?[i] = event.updatedItem;
        itemUpdated = true;

        if (event.operation == 'add') {
          vals = (vals ?? 0) + 1;
        } else {
          vals = (vals ?? 0) - 1;
        }

        break;
      }
    }
  });

  if (itemUpdated) {
   
    emit(StateData( cart: vals,items: Map.from(updatedItems)));
    PreferencesClient(prefs: prefs).saveCart(vals);
    
  }
}




  


  // ignore: non_constant_identifier_names
  void _UpdateIndex(UpdateIndexs event, Emitter<AuthState> emit) async {
    int vals = event.indexs;
    emit(StateData(ind:vals));
  }


  @override
  Future<void> eventHandlerMethod(AppEvent event, Emitter<AuthState> emit) async {
    switch (event.runtimeType) {
      case const (CallItemsApi):
        return _callItemsApi(event as CallItemsApi, emit);
      case const (UpdateItems):
        return _updateItem(event as UpdateItems, emit);
      case const (GetCartValue):
        return _getCartValue(event as GetCartValue,emit);
      case const (UpdateIndexs):
        return _UpdateIndex(event as UpdateIndexs, emit);
    }
  }

  @override
  AuthState getErrorState() {
    return AuthError();
  }
}
