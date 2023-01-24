bool haveNewVersion(String newVersion, String old) {
  if (newVersion == null || newVersion.isEmpty || old == null || old.isEmpty)
    return false;
  int newVersionInt, oldVersion;
  var newList = newVersion.split('.');
  var oldList = old.split('.');
  if (newList.length == 0 || oldList.length == 0) {
    return false;
  }
  for (int i = 0; i < newList.length; i++) {
    newVersionInt = int.parse(newList[i]);
    oldVersion = int.parse(oldList[i]);
    if (newVersionInt > oldVersion) {
      return true;
    } else if (newVersionInt < oldVersion) {
      return false;
    }
  }

  return false;
}
