import 'dart:async';

Stream<int> countStream() async* {
  for (int i = 0; i < 10; i++) {
    await Future.delayed(const Duration(seconds: 2));
    print("Not yielding just printing $i");
    //yield i;
  }
}

void main() async {
  late StreamSubscription s;
  s = countStream().listen(
    (value) {
      print("From listen: $value");
      if (value == 5) {
        s.cancel();
        print("Cancelled");
      }
    },
    onDone: () {
      print("Done");
    },
    onError: (error) {
      print("Error: $error");
    },
    cancelOnError: false,
  );

  print("After listen.");
  await for (int i in countStream()) {
    print("From for: $i");
  }
  print("After for.");
}
