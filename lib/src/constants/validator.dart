class Validator {
  
  Validator._();

    static String isEmptyValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'กรุณาระบุข้อมูล';
    } else {
      return null;
    }
  }

  static String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  static String phoneValidator(String value) {
    if (value.length != 10) {
      return 'Phone must be longer than 10 characters';
    } else {
      return null;
    }
  }

}