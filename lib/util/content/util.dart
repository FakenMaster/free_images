extension StringCapitalizeExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  // 16873 => 16.873
  String delimiter3CharReverse() {
    if (this.length <= 3) {
      return this;
    }
    String result = this.substring(this.length - 3);
    int i;
    for (i = this.length - 6; i >= 0; i -= 3) {
      result = this.substring(i, i + 3) + '.' + result;
    }
    if (i > -3) {
      result = this.substring(0, i + 3) + '.' + result;
    }
    return result;
  }

  bool isNullOrEmpty() {
    return this == null || this.trim() == '';
  }
}
