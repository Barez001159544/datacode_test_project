import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/repositories.dart';
import 'app_events.dart';
import 'app_states.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  final ExchangeRepository _exchangeRepository;

  ExchangeBloc(this._exchangeRepository) : super(ExchangeLoadingState()) {
    on<LoadExchangeEvent>((event, emit) async {
      emit(ExchangeLoadingState());
      await for (final exchange in _exchangeRepository.getExchangeStream()) {
        emit(ExchangeLoadedState(exchange));
      }
    });
  }
}
