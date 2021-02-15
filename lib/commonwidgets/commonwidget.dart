// Checks Internet connection
import 'dart:io';

import 'package:flutter/cupertino.dart';

Future<bool> hasInternetConnection({
  bool mounted,
  @required Function onSuccess,
  @required Function onFail,
  bool canShowAlert = true,
}) async {
  try {
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 5));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      onSuccess();
      return true;
    } else {
      if (canShowAlert) {
        onFail();
      }
    }
  } catch (_) {
    onFail();
  }
  return false;
}
