import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: dangling_library_doc_comments, slash_for_doc_comments
/**
 * 
 * 1. BlocBuilder is used to build a UI representation of widgets based on bloc state.
 * 2. BlocSelector is used to selectively rebuild widgets but is similar to BlocBuilder.
 * 3. BlocProvider is used to provide a bloc to the widget tree.
 * 4. MultiBlocProvider is used to merge multiple BlocProvider widgets into one.
 * 5. BlocListener is used to react to state changes. It should be used for functionality that only
 *    occurs once per state change.
 * 6. MultiBlocListener is used to merge multiple bloc listeners.
 * 7. BlocConsumer is a combination of BlocListener and BlocBuilder.
 * 8. RepositoryProvider is a widget that provides repositories. It's used for dependency injection,
 *    so that a single instance of a repository can be provided to multiple widgets within the subtree.
 * 9. MultiRepositoryProvider is used to merge multiple repository providers.
 * 
 * */

void main() => runApp(CounterApp());

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

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterBloc.empty(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: BlocBuilder<CounterBloc, int>(
        builder:
            (context, count) =>
                Center(child: Text('$count', style: TextStyle(fontSize: 24))),
      ),
      floatingActionButton: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              onPressed:
                  () => context.read<CounterBloc>().add(
                    CounterIncrementPressed(),
                  ),
              child: Icon(Icons.add),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              onPressed:
                  () => context.read<CounterBloc>().add(
                    CounterDecrementPressed(),
                  ),
              child: Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
  }
}
