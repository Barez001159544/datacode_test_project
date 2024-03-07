import 'package:datacode_interview/repositories.dart';
import 'package:datacode_interview/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/app_blocs.dart';
import 'blocs/app_events.dart';
import 'blocs/app_states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<ExchangeBloc>(
          create: (BuildContext c) => ExchangeBloc(ExchangeRepository(c), c),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
            body: blocBody()),
      ),
    );
  }

  Widget blocBody() {

    return BlocProvider(
      create: (context) => ExchangeBloc(
        ExchangeRepository(context),
        context,
      )..add(LoadExchangeEvent()),
      child: BlocBuilder<ExchangeBloc, ExchangeState>(
        builder: (context, state) {
          print("Current State-----> $state");
          double wid= MediaQuery.of(context).size.width;
          double hei= MediaQuery.of(context).size.height;
          if (state is ExchangeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ExchangeErrorState) {
            return Center(child:  Text("Error${state.error}"));
          }
          if (state is ExchangeLoadedState) {
            CurrencyModel userList = state.exchange;
            return Flex(
              direction: wid>700?Axis.horizontal:Axis.vertical,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black87,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.currency_bitcoin_rounded, color: Colors.amber, size: 120,),
                      Text("BitCoin", style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("jjjjjjj jjjjjjjj jjjj", style: TextStyle(color: Colors.black, fontSize: 42),),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 300,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(userList.price, style: TextStyle(color: Colors.white, fontSize: 24),)),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              color: Colors.grey,
                              height: 30,
                              width: 1,
                            ),
                            Text("BTC", style: TextStyle(color: Colors.white, fontSize: 24),),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text("1", style: TextStyle(color: Colors.white, fontSize: 24),)),
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              color: Colors.grey,
                              height: 30,
                              width: 1,
                            ),
                            Text("USD", style: TextStyle(color: Colors.white, fontSize: 24),),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      IconButton(
                          onPressed: (){},
                        tooltip: "Copy BTC Price",
                          icon: Icon(Icons.copy_rounded, color: Colors.black,),
                      ),
                    ],
                  ),
                ),

              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}