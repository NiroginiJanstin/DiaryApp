class Validator {
  static String validateField({String value}) {
    if (value.isEmpty) {
      return 'Field can\'t be empty';
    }

    return null;
  }
}
