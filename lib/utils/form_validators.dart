class FormValidators {
  static const String requiredFieldMessage = 'This field is required';

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return requiredFieldMessage;
    }
    return null;
  }

  static String? cannotContainSpaces(String value) {
    if (value.contains(' ')) {
      return 'Username cannot contain spaces';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return requiredFieldMessage;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? minLength(String? value, int minLength) {
    if (value == null || value.trim().length < minLength) {
      return 'Minimum length is $minLength characters';
    }
    return null;
  }

  static String? passwordMatch(String pass, String confirmPass) {
    if (pass != confirmPass) {
      return 'Passwords do not match';
    }
    return null;
  }
}
