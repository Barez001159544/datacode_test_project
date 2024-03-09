import 'package:datacode_interview/services/repositories.dart';
import 'package:datacode_interview/model/currency_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/app_blocs.dart';
import '../blocs/app_events.dart';
import '../blocs/app_states.dart';

class ExchangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ExchangeBloc(ExchangeRepository(context),)..add(LoadExchangeEvent()),
        child: BlocBuilder<ExchangeBloc, ExchangeState>(
          builder: (context, state) {
            double wid = MediaQuery.of(context).size.width;
            if (state is ExchangeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ExchangeErrorState) {
              return Center(child: Text("Error${state.error}"));
            }
            if (state is ExchangeLoadedState) {
              CurrencyModel exchangeData = state.exchange;
              return Flex(
                direction: wid > 700 ? Axis.horizontal : Axis.vertical,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: wid > 700 ? 300 : wid,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.black87,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.currency_bitcoin_rounded,
                          color: Colors.amber,
                          size: 120,
                        ),
                        Text(
                          "BitCoin",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: SizedBox()),
                        Text(
                          "Showing BitCoint Price Compared to US Dollar:",
                          style: TextStyle(color: Colors.black, fontSize: 34),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        showPriceWidget("High Price", exchangeData.h[0],
                            Icons.arrow_drop_up_rounded, Colors.green),
                        SizedBox(
                          height: 20,
                        ),
                        showPriceWidget("Current Price", exchangeData.a[0],
                            Icons.remove_rounded, Colors.white),
                        SizedBox(
                          height: 10,
                        ),
                        showPriceWidget("Low Price", exchangeData.l[0],
                            Icons.arrow_drop_down_rounded, Colors.red),
                        SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: Center(
                              child:
                                  Text("Developed by: Barez Azad and DataCode")),
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
      ),
    );
  }
}

Widget showPriceWidget(
    String message, String price, IconData iconData, Color iconColor) {
  return Tooltip(
    message: message,
    child: Container(
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            price,
            style: TextStyle(color: Colors.white, fontSize: 24),
          )),
          Container(
            margin: EdgeInsets.only(right: 20),
            color: Colors.grey,
            height: 30,
            width: 1,
          ),
          Icon(
            iconData,
            color: iconColor,
          ),
        ],
      ),
    ),
  );
}
