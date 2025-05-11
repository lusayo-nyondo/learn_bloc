class Singleton {
  static Singleton instance = Singleton._();
  Singleton._();

  factory Singleton() {
    return instance;
  }
}

void main() {
  Singleton mySingleton = Singleton();
  Singleton instance = Singleton.instance;
  print(identical(instance, mySingleton));
}
