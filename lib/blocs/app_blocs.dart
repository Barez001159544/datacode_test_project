
import 'dart:async';
import 'dart:convert';

import 'package:datacode_interview/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../repositories.dart';
import 'app_events.dart';
import 'app_states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}

// class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
//   final ExchangeRepository _exchangeRepository;
//
//   ExchangeBloc(this._exchangeRepository) : super(ExchangeLoadingState()) {
//     on<LoadExchangeEvent>((event, emit) async {
//       emit(ExchangeLoadingState());
//       try {
//         _exchangeRepository.getExchange();
//         // emit(ExchangeLoadedState(exchange));
//       } catch (e) {
//         emit(ExchangeErrorState(e.toString()));
//       }
//     });
//   }
// }

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  final ExchangeRepository _exchangeRepository;
  final BuildContext context;

  ExchangeBloc(this._exchangeRepository, this.context) : super(ExchangeLoadingState()) {
    on<LoadExchangeEvent>((event, emit) async* {
      emit(ExchangeLoadingState());
      print("Loading");

        final channel = WebSocketChannel.connect(
          Uri.parse('wss://ws.kraken.com'),
        );
      // Completer<CurrencyModel> completer = Completer<CurrencyModel>();
      channel.sink.add('{"event":"subscribe", "pair":["XBT/USD"], "subscription":{"name":"ticker"}}');
      try {
        print("Loading2222");
        yield channel.stream.listen((data){
            if (data.toString()[0] == "["){
              // await Future.delayed(const Duration(seconds: 2));
              print("Loading3333");
              print(CurrencyModel.fromJson(json.decode(data)[1]).price);
              // BlocProvider.of<ExchangeBloc>(context).emit(ExchangeLoadedState(CurrencyModel.fromJson(jsonDecode(data)[1])));
              emit(ExchangeLoadedState(CurrencyModel.fromJson(jsonDecode(data)[1])));
              print("Loading4444");
            } else {
              // print("##########${data}");
            }
            return data;
          },
          onError: (error) {
            emit(ExchangeErrorState(error.toString()));
            print(error);
          },
          onDone: () {

          },

        );
      }catch(e){
        emit(ExchangeErrorState(e.toString()));
        print(e);
      }
    });
  }
}