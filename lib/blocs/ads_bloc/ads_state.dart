part of 'ads_bloc.dart';

abstract class AppState extends ErrorState {}

class AppInitial extends AppState {}

class AppLoading extends AppState {}

class AppError extends AppState {}


class StateDatas extends AppState {
  StateDatas({this.ads});

  List<Products>? ads;
}
