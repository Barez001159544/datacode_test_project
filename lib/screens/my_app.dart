import 'package:datacode_interview/home_page.dart';
import 'package:datacode_interview/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/app_blocs.dart';
import 'exchange_page.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<ExchangeBloc>(
          create: (BuildContext c) => ExchangeBloc(ExchangeRepository(c)),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/exchange': (context) => ExchangePage(),
        },
      ),
    );
  }
}

