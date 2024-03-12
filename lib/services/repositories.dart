import 'dart:async';
import 'dart:convert';
import 'package:datacode_interview/model/currency_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ExchangeRepository {
  final BuildContext context;
  final WebSocketChannel channel;

  ExchangeRepository(this.context)
      : channel = WebSocketChannel.connect(
          Uri.parse('wss://ws.kraken.com'),
        ) {
    channel.sink.add('{"event":"subscribe", "pair":["XBT/USD"], "subscription":{"name":"ticker"}}');
  }

  Stream<CurrencyModel> getExchangeStream() {
    return channel.stream.where((data) => data.toString().startsWith("[")).map((data) => CurrencyModel.fromJson(json.decode(data)[1]));
  }
}
