import 'package:bloc/bloc.dart';

void main() {
  CounterBloc bloc = CounterBloc(0);

  bloc.add(CounterIncrementEvent());
  bloc.add(CounterIncrementEvent());
  bloc.add(CounterDecrementEvent());
}

class CounterBlocEvent {}

class CounterIncrementEvent extends CounterBlocEvent {}

class CounterDecrementEvent extends CounterBlocEvent {}

class CounterBloc<CounterBlocEvent, int> extends Bloc {
  CounterBloc(super.initialState) {
    on<CounterIncrementEvent>((event, emit) => emit(state + 1));
    on<CounterDecrementEvent>((event, emit) => emit(state - 1));
  }

  @override
  onChange(Change change) {
    super.onChange(change);
    print(change.nextState);
  }
}
