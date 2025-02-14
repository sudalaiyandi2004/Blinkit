part of 'items_bloc.dart';


abstract class AuthState extends ErrorState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {}


class StateData extends AuthState{
  StateData({this.items,this.cart=0,this.ind=0});

  Map<String, List<Items>>? items;
  int? cart;
  int? ind;
}
