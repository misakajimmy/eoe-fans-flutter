String SecondToDate(num seconds) {
  var h = seconds ~/ 3600;
  var m = seconds ~/ 60 % 60;
  var s = seconds % 60;
  var res = '';
  if (h != 0) {
    res += '$h:';
  }
  res += '$m:';
  res += s.toString();
  return res;
}
