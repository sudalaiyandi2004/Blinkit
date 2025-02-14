import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/ads.dart';
import '../../api_services/auth_service.dart';
import '../../core/base_bloc/base_bloc.dart';
import '../../core/preference_client/preference_client.dart';

part 'ads_event.dart';
part 'ads_state.dart';

class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());

  final AuthService authService = AuthService();

  StateDatas stateData = StateDatas();

  FutureOr<void> _callAdsApi(
      CallAdsApi event, Emitter<AppState> emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      
      final Map<String, dynamic>? response=await authService.getAds(); 
    
      final List<Products> user = response?['data'] as List<Products>;
    
      PreferencesClient(prefs: prefs).saveAds(appUser:user);
      emit(stateData..ads = user);
  }

  @override
  Future<void> eventHandlerMethod(AppEvent event, Emitter<AppState> emit) async {
    switch (event.runtimeType) {
      case const (CallAdsApi):
        return _callAdsApi(event as CallAdsApi, emit);
    }
  }

  @override
  AppState getErrorState() {
    return AppError();
  }
}
