import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../user_model.dart';

@immutable
abstract class UserState extends Equatable {}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final List<UserModel> users;
  UserLoadedState(this.users);
  @override
  List<Object?> get props => [users];
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

///-----------------------------------------

@immutable
abstract class ExchangeState {}

class ExchangeLoadingState extends ExchangeState {

}

class ExchangeLoadedState extends ExchangeState {
  final CurrencyModel exchange;
  ExchangeLoadedState(this.exchange);

}

class ExchangeErrorState extends ExchangeState {
  final String error;
  ExchangeErrorState(this.error);

}