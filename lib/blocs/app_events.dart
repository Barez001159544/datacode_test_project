import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ExchangeEvent extends Equatable {
  const ExchangeEvent();
}

class LoadExchangeEvent extends ExchangeEvent {
  @override
  List<Object?> get props => [];
}
