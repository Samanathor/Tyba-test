bool isEmailValid(value) {
  if (value.isEmpty) return false;
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
}

bool isPasswordValid(String? value) {
  if (value!.isEmpty) return false;
  return value.length > 5;
}
