final RegExp _emailRegExp = RegExp(
  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
);
String? validateEmail(String email) {
  if (email.isEmpty) {
    return 'Introduce un correo';
  } else if (!_emailRegExp.hasMatch(email.trim())) {
    return 'Por favor introduce un correo válido';
  }

  return null;
}

String? validateText(String input) {
  if (input.isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    return null;
  }
}

String? validateName(String? input) {
  if ((input ?? "").isEmpty) {
    return 'Este campo es obligatorio';
  } else {
    String pattern =
        r'^[a-zA-ZÀ-ÿ\u00f1\u00d1]*(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]*$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch((input ?? ""))) {
      return 'Ingresa un nombre válido';
    }
    return null;
  }
}

String? validateMatchValue(String value, String match) =>
    value != match ? 'Los valores no coinciden' : null;

String? noValidate() => null;
