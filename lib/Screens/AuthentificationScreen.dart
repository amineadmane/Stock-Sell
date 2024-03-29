import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stocknsell/Screens/color_utils.dart';
import 'package:stocknsell/Screens/common_styles.dart';
import 'package:stocknsell/Screens/raised_gradient_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

bool showSpinner = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(gradient: ColorUtils.appBarGradient),
                ),
                Align(
                  alignment: Alignment.topCenter,
                ),
                Positioned(
                  top: 150,
                  left: 10,
                  right: 10,
                  child: LoginFormWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginFormWidgetState();
  }
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  var _userEmailController = TextEditingController(text: "");
  var _userPasswordController = TextEditingController(text: "");
  var _emailFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = true;
  bool _autoValidate = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          Card(
            elevation: 8,
            child: Column(
              children: <Widget>[
                _buildLogo(),
                _buildIntroText(),
                _buildEmailField(context),
                _buildPasswordField(context),
                _buildForgotPasswordWidget(context),
                _buildSignUpButton(context, showSpinner),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroText() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Text(
            "Stock & Sales",
            style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Image.asset(
        "assets/images/Logo.jpg",
        height: 100,
        width: 100,
      ),
    );
  }

  String _userNameValidation(String value) {
    if (value.isEmpty) {
      return "Veuillez entrer un mot de passe valide";
    } else {
      return null;
    }
  }

  Widget _buildEmailField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        controller: _userEmailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          email = value;
        },
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
        validator: (value) => _emailValidation(value),
        decoration: CommonStyles.textFormFieldStyle("Adresse mail", ""),
      ),
    );
  }

  String _emailValidation(String value) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if (!emailValid) {
      return "Veuillez entrez une adresse mail valide";
    } else {
      return null;
    }
  }

  Widget _buildPasswordField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextFormField(
        controller: _userPasswordController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_emailFocusNode);
        },
        onChanged: (value) {
          password = value;
        },
        validator: (value) => _userNameValidation(value),
        obscureText: _isPasswordVisible,
        decoration: InputDecoration(
          labelText: "Mot de passe",
          labelStyle: TextStyle(color: Colors.black),
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              }),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
            onPressed: () {},
            child: Text(
              'Mot de passe oublié ?',
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
            )),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context, bool showSpinner) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: double.infinity,
        child: RaisedGradientButton(
          child: Text(
            "Connexion",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          onPressed: () async {
            setState(() {
              showSpinner = true;
            });
            var validate = _formKey.currentState.validate();
            try {
              final user = await _auth.signInWithEmailAndPassword(
                  email: email, password: password);
              if ((validate) && (user != null)) {
                Navigator.pushNamed(context, '/home');
              } else {
                setState(() {
                  _autoValidate = true;
                  _clearAllFields();
                });
                setState(() {
                  showSpinner = false;
                });
              }
            } catch (e) {
              print(e);
            }
          },
        ),
      ),
    );
  }

  void _clearAllFields() {
    setState(() {
      _userEmailController = TextEditingController(text: "");
      _userPasswordController = TextEditingController(text: "");
    });
  }
}
