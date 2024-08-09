String SplitNumbers(int number) {
  String numberStr = number.toString();
  StringBuffer result = StringBuffer();

  int counter = 0;
  for (int i = numberStr.length - 1; i >= 0; i--) {
    result.write(numberStr[i]);
    counter++;
    if (counter % 3 == 0 && i != 0) {
      result.write(',');
    }
  }

  return result.toString().split('').reversed.join('');
}
