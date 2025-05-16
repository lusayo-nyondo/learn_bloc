import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) => CounterBloc(0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Counter(), SizedBox(height: 8), CounterControls()],
            ),
          ),
        ),
      ),
    ),
  );
}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<CounterBloc>(),
      builder: (context, state) => Center(child: Text('Count: $state')),
    );
  }
}

class CounterControls extends StatelessWidget {
  const CounterControls({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CounterBloc>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => bloc.add(CounterIncrementEvent()),
        ),
        SizedBox(width: 4),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () => bloc.add(CounterDecrementEvent()),
        ),
      ],
    );
  }
}

class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterDecrementEvent extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc(super.initialState) {
    on<CounterIncrementEvent>((event, emit) => emit(state + 1));
    on<CounterDecrementEvent>((event, emit) => emit(state - 1));
  }
}
