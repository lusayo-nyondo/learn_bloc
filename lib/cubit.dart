import 'package:bloc/bloc.dart';

void main() {
  withErrorHandling();
}

void withErrorHandling() {
  Bloc.observer = ErrorHandlingBlocObserver();
  final counterCubit = ErrorHandlingCounterCubit.empty();
  counterCubit.increment();
  counterCubit.increment();
  counterCubit.increment();
  counterCubit.increment();
  counterCubit.increment();
  counterCubit.testError();
  counterCubit.increment();
}

void usingBlocObserver() {
  Bloc.observer = SimpleBlocObserver();
  final counterCubit = CounterCubit.empty();
  counterCubit.increment();
  counterCubit.increment();
  counterCubit.increment();
  counterCubit.increment();
  counterCubit.increment();
  counterCubit.increment();
  counterCubit.decrement();
  counterCubit.close();
}

void usingCubitOnChange() {
  final counterCubit = ChangeObservingCounterCubit.empty();
  counterCubit.increment();
  counterCubit.increment();
  counterCubit.decrement();
  counterCubit.close();
  print("Closed");
}

void usingCubitStream() {
  final counterCubit = CounterCubit.empty();
  final streamSubscription = counterCubit.stream.listen((state) {
    print("State is: ${counterCubit.state}");
    print("State changed to: $state");
  });
  streamSubscription.onDone(() {
    print("Stream closed.");
  });

  counterCubit.increment();
  counterCubit.increment();
  counterCubit.increment();
  counterCubit.decrement();
  counterCubit.close();
}

void usingCubit() {
  final counterCubit = CounterCubit.empty();
  print(counterCubit.state);
  counterCubit.increment();
  print(counterCubit.state);
  counterCubit.decrement();
  counterCubit.decrement();
  print(counterCubit.state);
  counterCubit.close();
  print("Closed");
}

typedef CounterState = int;

class CounterCubit extends Cubit<CounterState> {
  CounterCubit(super.initialState);
  CounterCubit.empty() : this(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

class ChangeObservingCounterCubit extends CounterCubit {
  ChangeObservingCounterCubit(super.initialState);
  ChangeObservingCounterCubit.empty() : this(0);

  @override
  onChange(Change<CounterState> change) {
    super.onChange(change);
    print("State changed from ${change.currentState} to ${change.nextState}");
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(bloc.runtimeType);
    print("State changed from ${change.currentState} to ${change.nextState}");
  }
}

class ErrorHandlingBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print("Error within bloc: $error");
  }
}

class ErrorHandlingCounterCubit extends CounterCubit {
  ErrorHandlingCounterCubit(super.initialState);
  ErrorHandlingCounterCubit.empty() : this(0);

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print("Error within cubit: $error");
  }

  void testError() {
    addError("Testing the errors.");
  }
}
