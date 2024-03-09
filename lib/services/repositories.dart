import 'dart:async';
import 'dart:convert';
import 'package:datacode_interview/model/currency_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ExchangeRepository {
  bool isCompleted=false;
  final BuildContext context;
  ExchangeRepository(this.context);

  Future<CurrencyModel> getExchange(){

    final channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.kraken.com'),
    );
    Completer<CurrencyModel> completer = Completer<CurrencyModel>();

      channel.sink.add('{"event":"subscribe", "pair":["XBT/USD"], "subscription":{"name":"ticker"}}');

      channel.stream.listen(
            (data) {
          if(data.toString()[0]=="["){
            if(!isCompleted){
              completer.complete(CurrencyModel.fromJson(json.decode(data)[1]));
              isCompleted=true;
            }
          }
          return data;
        },
        onError: (error) {
              //
        },
        onDone: () {
              //
        },
      );

    return completer.future;
  }
}


