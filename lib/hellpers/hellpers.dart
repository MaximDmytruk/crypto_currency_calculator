double isDouble(String string) {
  double number = -1;
  try {
    number = double.parse(string);
  } catch (e) {
    print(e);
  }

  return number;
}
