import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_bluestack/commonwidgets/ActionButton.dart';
import 'package:flutter_app_bluestack/commonwidgets/verticalspace.dart';
import 'package:flutter_app_bluestack/resources/class%20ResString.dart';
import 'package:flutter_app_bluestack/utils/AppColors.dart';
import 'package:flutter_app_bluestack/utils/AssetStrings.dart';
import 'package:flutter_app_bluestack/utils/constants.dart';
import 'package:flutter_app_bluestack/utils/memory_management.dart';
import 'package:flutter_app_bluestack/utils/themes_styles.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _PasswordController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKeys = new GlobalKey<ScaffoldState>();

  FocusNode _EmailField = new FocusNode();
  FocusNode _PasswordField = new FocusNode();

  IconData icon = Icons.visibility_off;
  bool obsecureText = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKeys,
      body: Container(
        color: Colors.white,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            topViewWidget,
            VerticalSpace(
              value: 24.0,
            ),
            getTextField(
                ResString().get('user_name'),
                _userNameController,
                _EmailField,
                _PasswordField,
                TextInputType.emailAddress,
                Icons.email,
                obsectextType: false),
            VerticalSpace(
              value: 18.0,
            ),
            getTextField(ResString().get('password'), _PasswordController,
                _PasswordField, _PasswordField, TextInputType.text, Icons.lock,
                obsectextType: true),
            VerticalSpace(
              value: 51.0,
            ),
            ActionButton(
              callback: callback,
              label: ResString().get('login'),
              margin: 20,
              buttonColor: AppColors.kPrimaryBlue,
            ),
          ],
        ),
      ),
    );
  }

  Widget getLogo(String path) => ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Container(
        child: Image.asset(
          path,
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.width * 0.25,
        ),
      ));

  Widget getTextField(
      String labelText,
      TextEditingController controller,
      FocusNode focusNodeCurrent,
      FocusNode focusNodeNext,
      TextInputType textInputType,
      IconData icon,
      {bool obsectextType}) {
    return Container(
      margin: new EdgeInsets.only(left: 20.0, right: 20.0),
      height: 60,
      child: new TextField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obsectextType ? obsecureText : false,
        focusNode: focusNodeCurrent,
        onSubmitted: (String value) {
          if (focusNodeCurrent == _PasswordField) {
            _PasswordField.unfocus();
          } else {
            FocusScope.of(context).autofocus(focusNodeNext);
          }
        },
        decoration: new InputDecoration(
          enabledBorder: new OutlineInputBorder(
              borderSide: new BorderSide(
                color: Colors.grey.withOpacity(0.5),
              ),
              borderRadius: new BorderRadius.circular(8)),
          focusedBorder: new OutlineInputBorder(
              borderSide: new BorderSide(
                color: AppColors.colorCyanPrimary,
              ),
              borderRadius: new BorderRadius.circular(8)),
          contentPadding: new EdgeInsets.only(top: 10.0),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
                left: 14.0, right: 14.0, bottom: 14, top: 14.0),
            child: Icon(
              icon,
              color: Colors.grey,
              size: 26.0,
            ),
          ),
          suffixIcon: obsectextType
              ? passwordHideShowWidget(obsectextType)
              : Container(
                  width: 1.0,
                ),
          hintText: labelText,
          hintStyle: TextThemes.greyTextFieldHintNormal,
        ),
      ),
    );
  }

  Widget passwordHideShowWidget(bool obsectextType) => Offstage(
        offstage: !obsectextType,
        child: InkWell(
          onTap: () {
            obsecureText = !obsecureText;
            setState(() {});
          },
          child: Container(
            width: 30.0,
            margin: new EdgeInsets.only(right: 10.0, bottom: 4),
            alignment: Alignment.centerRight,
            child: new Text(
              obsecureText ? "show" : "hide",
              style: TextThemes.blackTextSmallNormal,
            ),
          ),
        ),
      );

  void showInSnackBar(String value) {
    _scaffoldKeys.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  get topViewWidget => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getLogo(AssetStrings.tvlogo),
          Text(
            "+",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          getLogo(AssetStrings.gamelogo),
        ],
      );

  get forgotPassWidget => new Container(
        alignment: Alignment.centerRight,
        margin: new EdgeInsets.only(left: 20.0, right: 20.0),
        child: InkWell(
          onTap: () {},
          child: new Text(
            ResString().get('forgot_pass'),
            style: TextThemes.redTextSmallMedium,
          ),
        ),
      );

  get signupWidget => Container(
        alignment: Alignment.center,
        child: new RichText(
            textAlign: TextAlign.center,
            text: new TextSpan(
              text: ResString().get('dont_have_account'),
              style: TextThemes.greyDarkTextFieldMedium,
              children: <TextSpan>[
                new TextSpan(
                  text: ResString().get('signup_cap_button'),
                  style: TextThemes.redTextSmallMedium,
                  recognizer: new TapGestureRecognizer()..onTap = () {},
                ),
              ],
            )),
      );

  void callback() async {
    var userName = _userNameController.text.trim();
    var password = _PasswordController.text;
    if (userName.isEmpty) {
      showInSnackBar(ResString().get('enter_user_name'));
      return;
    } else if (!(userName.length >= 3 && userName.length <= 10)) {
      showInSnackBar(ResString().get('enter_valid_user_name'));
      return;
    } else if (password.isEmpty) {
      showInSnackBar(ResString().get('enter_password'));
      return;
    } else if (!(password.length >= 3 && password.length <= 10)) {
      showInSnackBar(ResString().get('enter_valid_password'));
      return;
    }
    //check user credentails
    var loginStatus = await _checkLogin(userName, password);
    if (loginStatus) {
      MemoryManagement.setLoginStatus(status: true);
      Navigator.pushNamedAndRemoveUntil(
          context, "/home", (Route<dynamic> route) => false);
    } else {
      showInSnackBar("Invalid credentials");
    }
  }

  Future<bool> _checkLogin(String userName, String password) async {
    if ((userName == Constants.user1) && (password == Constants.password1)) {
      return true;
    } else if ((userName == Constants.user2) &&
        (password == Constants.password2)) {
      return true;
    } else
      return false;
  }
}
