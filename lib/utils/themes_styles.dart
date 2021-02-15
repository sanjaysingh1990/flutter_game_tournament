import 'package:flutter/material.dart';
import 'package:flutter_app_bluestack/utils/AppColors.dart';

import 'AssetStrings.dart';

class TextThemes {
  static final Color ndGold = Color.fromRGBO(220, 180, 57, 1.0);
  static final Color ndBlue = Color.fromRGBO(2, 43, 91, 1.0);

  static final TextStyle extraBold = TextStyle(
    fontFamily: AssetStrings.circulerBoldStyle,
    fontSize: 28,
    color: Colors.black,
  );

  static final TextStyle smallBold = TextStyle(
    fontFamily: AssetStrings.circulerBoldStyle,
    fontSize: 16,
    color: Colors.black,
  );

  static final TextStyle grayNormal = TextStyle(
    fontFamily: AssetStrings.circulerNormal,
    fontSize: 16,
    color: Color.fromRGBO(103, 99, 99, 1.0),
  );

  static final TextStyle grayNormalSmall = TextStyle(
    fontFamily: AssetStrings.circulerNormal,
    fontSize: 14,
    color: Color.fromRGBO(103, 99, 99, 1.0),
  );

  static final TextStyle blueMediumSmall = TextStyle(
    fontFamily: AssetStrings.circulerMedium,
    fontSize: 14,
    color: Color.fromRGBO(9, 165, 255, 1.0),
  );

  static final TextStyle blueMediumSmallNew = TextStyle(
    fontFamily: AssetStrings.circulerMedium,
    fontSize: 12,
    color: Color.fromRGBO(9, 165, 255, 1.0),
  );

  static final TextStyle blackTextSmallNormal = TextStyle(
    fontFamily: AssetStrings.circulerNormal,
    fontSize: 14,
    color: Colors.black,
  );

  static const TextStyle blackTextFieldNormal = TextStyle(
    fontFamily: AssetStrings.circulerNormal,
    fontSize: 16,
    color: Colors.black,
  );

  static const TextStyle greyTextNormal = TextStyle(
    fontFamily: AssetStrings.circulerNormal,
    fontSize: 14,
    color: Color.fromRGBO(183, 183, 183, 1.0),
  );

  static const TextStyle whiteMedium = TextStyle(
    fontFamily: AssetStrings.circulerMedium,
    fontSize: 22,
    color: Color.fromRGBO(255, 255, 255, 1.0),
  );

  static final TextStyle greyTextFieldHintNormal = TextStyle(
    fontFamily: AssetStrings.circulerNormal,
    fontSize: 16,
    color: Color.fromRGBO(183, 183, 183, 1.0),
  );

  static final TextStyle readAlert = TextStyle(
    fontFamily: AssetStrings.circulerNormal,
    fontSize: 16,
    color: Color.fromRGBO(255, 107, 102, 1.0),
  );

  static final TextStyle greyTextFieldHintNormalHeight = TextStyle(
    fontFamily: AssetStrings.circulerNormal,
    fontSize: 16,
    color: Color.fromRGBO(183, 183, 183, 1.0),
  );

  static final TextStyle blackTextSmallMedium = TextStyle(
    fontFamily: AssetStrings.circulerMedium,
    fontSize: 14,
    color: Colors.black,
  );
  static final TextStyle cyanTextSmallMedium = TextStyle(
      fontFamily: AssetStrings.circulerMedium,
      fontSize: 14,
      color: Color.fromRGBO(50, 197, 255, 1.0));
  static final TextStyle redTextSmallMedium = TextStyle(
      fontFamily: AssetStrings.circulerBoldStyle,
      fontSize: 12,
      color: Color.fromRGBO(255, 107, 102, 1.0));

  static final TextStyle greyTextFieldMedium = TextStyle(
    fontFamily: AssetStrings.circulerMedium,
    fontSize: 14,
    color: Color.fromRGBO(114, 117, 122, 1.0),
  );

  static final TextStyle blueTextFieldMedium = TextStyle(
    fontFamily: AssetStrings.circulerMedium,
    fontSize: 15,
    color: Color.fromRGBO(9, 165, 255, 1.0),
  );

  static final TextStyle greyTextFieldNormal = TextStyle(
    fontFamily: AssetStrings.circulerNormal,
    fontSize: 14,
    color: Color.fromRGBO(114, 117, 122, 1.0),
  );

  static final TextStyle greyDarkTextFieldMedium = TextStyle(
    fontFamily: AssetStrings.circulerMedium,
    fontSize: 14,
    color: Color.fromRGBO(103, 99, 99, 1.0),
  );

  static final TextStyle userNameStyle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.kBlack);

  static final TextStyle tournamentHistoryScoreTheme = TextStyle(
      fontSize: 21, fontWeight: FontWeight.w800, color: AppColors.kWhite);
  static final TextStyle tournamentHistoryScoreTitleTheme = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.kWhite, height: 1.5,);
}
