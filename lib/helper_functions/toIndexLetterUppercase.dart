String toIndexLetterUppercase(String srcStr, int index) {
  List<String> srcArr = srcStr.split("");
  return srcArr
      .asMap()
      .entries
      .map((src) => src.key == index ? src.value.toUpperCase() : src.value)
      .join("");
}
