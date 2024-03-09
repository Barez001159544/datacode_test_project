import 'dart:async';
import 'dart:convert';

import 'package:datacode_interview/blocs/app_blocs.dart';
import 'package:datacode_interview/blocs/app_states.dart';
import 'package:datacode_interview/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserRepository {
  String userUrl = 'https://reqres.in/api/users?page=2';

  Future<List<UserModel>> getUsers() async {
    ///----------------
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.kraken.com'),
    );

    try {
      channel.sink.add('{"event":"subscribe", "pair":["XBT/USD"], "subscription":{"name":"ticker"}}');
      channel.stream.listen(
            (data) {
              if(data.toString()[0]=="["){
                // print(json.decode(data)[1]["a"]);
                // print(json.decode(data));
                print(CurrencyModel.fromJson(json.decode(data)[1]));
              }else {
                print("##########${data}");
              }
        },
        onError: (error) {
          // print('WebSocket error: $error');
        },
        onDone: () {
        },
      );
    } catch (e) {
      throw Exception(e);
    }
    ///----------------
    Response response = await get(Uri.parse(userUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }


  }
}

class ExchangeRepository {
  bool isCompleted=false;
  final BuildContext context;
  ExchangeRepository(this.context);
  Future<CurrencyModel> getExchange(){
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.kraken.com'),
    );
    Completer<CurrencyModel> completer = Completer<CurrencyModel>();
    // WebSocketChannel channel= WebSocketService().channel;

      channel.sink.add('{"event":"subscribe", "pair":["XBT/USD"], "subscription":{"name":"ticker"}}');
      channel.stream.listen(
            (data) {
          if(data.toString()[0]=="["){
            print("^^^^^^^^^^");
            print(CurrencyModel.fromJson(json.decode(data)[1]));
            // print(json.decode(data)[1]);
            // BlocProvider.of<ExchangeBloc>(context).emit(ExchangeLoadedState(CurrencyModel.fromJson(json.decode(data)[1])));
            if(!isCompleted){
              completer.complete(CurrencyModel.fromJson(json.decode(data)[1]));
              isCompleted=true;
            }
          }else {
            // print("##########${data}");
          }
          return data;
        },
        onError: (error) {
          // print('WebSocket error: $error');
        },
        onDone: () {
        },
      );

    return completer.future;
  }
}


// class WebSocketService {
//   late WebSocketChannel _channel;
//
//   WebSocketService() {
//     _channel = WebSocketChannel.connect(Uri.parse('wss://ws.kraken.com'),);
//   }
//
//   WebSocketChannel get channel => _channel;
//
//   // void dispose() {
//   //   _channel.sink.close();
//   // }
// }
