// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/cupertino.dart';

class Validators {
  Validators._();

  static FormFieldValidator compare(
      TextEditingController? valueEC, String message) {
    return (value) {
      final valueCompare = valueEC?.text ?? '';
      if (value == null || (value != null && value != valueCompare)) {
        return message;
      }
    };
  }
}
