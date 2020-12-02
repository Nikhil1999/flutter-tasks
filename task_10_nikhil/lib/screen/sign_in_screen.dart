import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../model/user_model.dart';
import '../screen/dashboard_screen.dart';
import '../util/constants.dart';
import '../util/string_assets.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<ScaffoldState> _scafflodKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  AutovalidateMode _signInFormValidateMode = AutovalidateMode.disabled;
  bool _visiblePassword = false;

  String _email, _password;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width, _height = _size.height;

    Future<void> _signIn() async {
      _signInFormValidateMode = AutovalidateMode.onUserInteraction;
      if (_signInFormKey.currentState.validate()) {
        _signInFormKey.currentState.save();

        List<UserModel> userList = await UserModel.getUserList(context);
        for (UserModel i in userList) {
          if (i.email == _email && _password == StringAssets.test123) {
            await i.set();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardScreen(),
              ),
            );
            return;
          }
        }
        _scafflodKey.currentState.showSnackBar(
          SnackBar(
            content: Text(StringAssets.incorrectEmailOrPassword),
          ),
        );
      }
    }

    void _tooglePasswordVisibility() {
      setState(() {
        _visiblePassword = !_visiblePassword;
      });
    }

    void _forgotPassword() {}

    void _createNewAccount() {}

    return Scaffold(
      key: _scafflodKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: _width * 0.05, vertical: _height * 0.02),
            height: _height - AppBar().preferredSize.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: _height * 0.06),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(Constants.hashImageURL),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Form(
                    autovalidateMode: _signInFormValidateMode,
                    key: _signInFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringAssets.signIn,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold, letterSpacing: 0.5),
                        ),
                        Theme(
                          data: ThemeData(primaryColor: Color(0xFF3C6DEE)),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (newValue) => _email = newValue,
                            textAlignVertical: TextAlignVertical.bottom,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (!isLength(value, 1)) {
                                return StringAssets.emailRequired;
                              }
                              if (!isEmail(value)) {
                                return StringAssets.emailInvalid;
                              }
                              return null;
                            },
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 16.0),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 7.5),
                                hintText: StringAssets.yourEmailAddress),
                          ),
                        ),
                        Theme(
                          data: ThemeData(primaryColor: Color(0xFF3C6DEE)),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) => _password = newValue,
                            textAlignVertical: TextAlignVertical.bottom,
                            obscureText: !_visiblePassword,
                            onFieldSubmitted: (value) => _signIn(),
                            validator: (value) {
                              if (!isLength(value, 1)) {
                                return StringAssets.passwordRequired;
                              }
                              return null;
                            },
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 16.0),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 4),
                              hintText: StringAssets.password,
                              suffixIcon: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () => _tooglePasswordVisibility(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 22),
                                  height: 50,
                                  child: (!_visiblePassword)
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: _height * 0.04, bottom: _height * 0.01),
                          child: InkWell(
                            onTap: () => _forgotPassword(),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Text(
                              StringAssets.forgotPassword,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontSize: 16.0,
                                    color: Color(0xFF3C6DEE),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: RaisedButton(
                                onPressed: () => _signIn(),
                                color: Color(0xFF3C6DEE),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: _height * 0.015),
                                  child: Text(
                                    StringAssets.signIn.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(
                                            fontSize: 16.0,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: _height * 0.01),
                          child: Center(
                            child: InkWell(
                              onTap: () => _createNewAccount(),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Text(
                                StringAssets.createNewAccount,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
