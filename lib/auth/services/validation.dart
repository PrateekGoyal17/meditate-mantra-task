class Validator {

static bool validateEmail({required String? email}) {
  if (email == null) {
    return true;
  }

  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  if (email.isEmpty) {
    return true;
  } else if (!emailRegExp.hasMatch(email)) {
    return true;
  }

  return false;
}

 static bool validatePassword({required String? password}) {
  if (password == null) {
    return true;
  }

  if (password.isEmpty) {
    return true;
  } else if (password.length < 6) {
    return true;
  }

  return false;
}
}

 