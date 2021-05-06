import 'dart:async';

class Validator {
  final validateUserName =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {

    if (!value.contains(' ') && value.isNotEmpty) {
      if (value.length >= 3 && value.length <= 10) {
        sink.add(value);
      } else {
        sink.addError("username must be min 3 characters and max 10");
      }
    } else {
      sink.addError("username must be one word");
    }
  });


  final validatePassword =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
        if (!value.contains(' ') && value.isNotEmpty) {
          if (value.length >= 3 && value.length <= 10) {
            sink.add(value);
          } else {
            sink.addError("password must be min 3 characters and max 10");
          }
        } else {
          sink.addError("password must be one word");
        }
  });

}
