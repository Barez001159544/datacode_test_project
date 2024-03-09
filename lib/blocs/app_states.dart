import 'package:flutter/cupertino.dart';
import '../model/currency_model.dart';

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
