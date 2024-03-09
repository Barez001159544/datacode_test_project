import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/repositories.dart';
import 'app_events.dart';
import 'app_states.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  final ExchangeRepository _exchangeRepository;

  ExchangeBloc(this._exchangeRepository) : super(ExchangeLoadingState()) {
    on<LoadExchangeEvent>((event, emit) async {
      emit(ExchangeLoadingState());
      try {
        final exchange= await _exchangeRepository.getExchange();
        emit(ExchangeLoadedState(exchange));
      } catch (e) {
        emit(ExchangeErrorState(e.toString()));
      }
    });
  }
}