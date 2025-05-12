void main() {
  final val = syncYield();
  print(val);
  print(val.runtimeType);
}

Iterable<int> syncYield() sync* {
  yield 1;
  yield 2;
}
