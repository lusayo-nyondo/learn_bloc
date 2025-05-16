import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) => CounterCubit.empty(),
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
      bloc: context.read<CounterCubit>(),
      builder: (context, state) => Center(child: Text('Count: $state')),
    );
  }
}

class CounterControls extends StatelessWidget {
  const CounterControls({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CounterCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(Icons.add), onPressed: () => cubit.increment()),
        SizedBox(width: 4),
        IconButton(icon: Icon(Icons.remove), onPressed: cubit.decrement),
      ],
    );
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit(super.initialState);
  CounterCubit.empty() : this(0);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    emit(state - 1);
  }
}
