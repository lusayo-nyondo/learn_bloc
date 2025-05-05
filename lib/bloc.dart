import 'dart:async';

import 'package:bloc/bloc.dart';

void main() {
  usingBlocWithTransition();
}

void usingBlocWithTransition() {
  final counterBloc = CounterBlocWithTransition.empty();

  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterDecrementPressed());
  counterBloc.add(CounterDecrementPressed());
  counterBloc.add(CounterDecrementPressed());
}

void usingBlocStream() {
  final counterBloc = CounterBloc.empty();
  late StreamSubscription s;

  s = counterBloc.stream.listen((state) async {
    print("State changed to: $state");

    if (state == 5) {
      //await counterBloc.close();
      //print("Bloc closed.");
      //counterBloc.add(CounterIncrementPressed());
    }
  });

  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());

  counterBloc.add(CounterDecrementPressed());

  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
}

void usingBlocObserver() {
  Bloc.observer = SimpleBlocObserver();
  final counterBloc = CounterBloc.empty();
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());
  counterBloc.add(CounterIncrementPressed());

  counterBloc.add(CounterDecrementPressed());
}

sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

final class CounterDecrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc.empty() : this(0);
  CounterBloc(super.initialState) {
    on<CounterIncrementPressed>((event, emit) {
      emit(state + 1);
    });

    on<CounterDecrementPressed>((event, emit) {
      emit(state - 1);
    });
  }
}

class CounterBlocWithTransition extends CounterBloc {
  CounterBlocWithTransition.empty() : this(0);
  CounterBlocWithTransition(super.initialState);

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print(
      "Transition from ${transition.currentState} to ${transition.nextState} through event: ${transition.event.runtimeType}",
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print("State changed from ${change.currentState} to ${change.nextState}");
  }
}
