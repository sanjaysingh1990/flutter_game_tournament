import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_bluestack/model/apierror.dart';
import 'package:flutter_app_bluestack/model/tournamentresponse.dart';
import 'package:flutter_app_bluestack/networkmodel/APIHandler.dart';
import 'package:flutter_app_bluestack/networkmodel/APIs.dart';
import 'package:flutter_app_bluestack/utils/constants.dart';

class HomeProvider with ChangeNotifier {
  var _isLoading = false;

  getLoading() => _isLoading;

  Future<dynamic> getTournamentData(int pageNo, String cursor,BuildContext context) async {
    Completer<dynamic> completer = new Completer<dynamic>();
    var url = "${APIs.tournamentListUrl}?limit=${Constants.limit}&status=all&cursor$cursor";
    var response = await APIHandler.get(
      context: context,
      url: url,
    );
      hideLoader();

    if (response is APIError) {
      completer.complete(response);
      notifyListeners();
      return completer.future;
    } else {
      TournamentResponse tournamentResponse =
          new TournamentResponse.fromJson(response);
      completer.complete(tournamentResponse);
      notifyListeners();
      return completer.future;
    }
  }

  void hideLoader() {
    _isLoading = false;
    notifyListeners();
  }

  void setLoading() {
    _isLoading = true;
    notifyListeners();
  }
}
