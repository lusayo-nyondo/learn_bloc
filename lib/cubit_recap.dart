import 'package:bloc/bloc.dart';

void main() async {
  final cubit = TodoItemsCubit([]);

  useBlocObserverOnCubit();

  cubit.addTodoItem('This is a todo item.');
  cubit.addTodoItem('This is another todo item.');
  cubit.addTodoItem('This is also another todo item.');
  cubit.removeLastTodoItem();
}

void useBlocObserverOnCubit() {
  Bloc.observer = TodoItemsBlocObserver();
  final cubit = TodoItemsCubit([]);

  cubit.addTodoItem('This is a todo item.');
  cubit.addTodoItem('This is another todo item.');
  cubit.addTodoItem('This is also another todo item.');
  cubit.removeLastTodoItem();
}

class TodoItemsBlocObserver extends BlocObserver {
  @override
  onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(bloc.runtimeType);
    print("Changing state from: ${change.currentState}to ${change.nextState}");
  }
}

void listenToCubitStream(Cubit cubit) {
  cubit.stream.listen((state) => print(state));
}

Future<void> subscribeToCubitStream(Cubit cubit) async {
  Stream todoItemsStream = cubit.stream;

  await for (final todoItem in todoItemsStream) {
    print(todoItem);
  }
}

typedef TodoItemsState = List<String>;

class TodoItemsCubit extends Cubit<TodoItemsState> {
  TodoItemsCubit(super.initialState);

  void addTodoItem(String todoItem) {
    super.state.add(todoItem);
    emit(super.state.toList());
  }

  void removeLastTodoItem() {
    super.state.removeLast();
    emit(super.state.toList());
  }

  /*
  @override
  onChange(Change<TodoItemsState> change) {
    super.onChange(change);

    print("Executing on change: ${change.currentState} to ${change.nextState}");
  }

  @override
  onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);

    print("Executing on error.");
  }*/
}
