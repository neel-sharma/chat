import 'package:chat/model/services/auth.dart';
import 'package:chat/view/login/social_buttons.dart';

import 'package:chat/controller/navigation/shortcuts.dart';
import 'package:flutter/material.dart';

import 'package:chat/view/login/style.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool? _rememberMe = false;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String mail = '', pass = '', error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SKYE',
          style: skyeFont(context),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 600,
              height: 700,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      email(context),
                      password(context),
                      loginHelp(context),
                      loginButton(context),
                      orText(context),
                      signInWithText(context),
                      socialLogins(context),
                      dontHaveAnAccount(context),
                      Text(
                        error,
                        style: TextStyle(
                            color: Theme.of(context).accentColor, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget email(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: labelText(context),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: boxStyle(context),
            height: 60.0,
            child: TextFormField(
              validator: (String? val) =>
                  val!.isEmpty ? 'Enter an email' : null,
              onChanged: (val) {
                setState(() {
                  mail = val;
                });
              },
              keyboardType: TextInputType.emailAddress,
              style: valueText(context),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: iconColor(context),
                ),
                hintText: 'Enter your Email',
                hintStyle: hintText(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  password(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: labelText(context),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: boxStyle(context),
          height: 60.0,
          child: TextFormField(
            validator: (String? val) => val!.length < 8
                ? 'Password should be of minimum 8 characters'
                : null,
            onChanged: (val) {
              setState(() {
                pass = val;
              });
            },
            obscureText: true,
            style: valueText(context),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: iconColor(context),
              ),
              hintText: 'Enter your Password',
              hintStyle: hintText(context),
            ),
          ),
        ),
      ],
    );
  }

  loginHelp(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        rememberMe(context),
        forgotPassword(context),
      ],
    );
  }

  rememberMe(BuildContext context) {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data:
                ThemeData(unselectedWidgetColor: Theme.of(context).accentColor),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Theme.of(context).primaryColor,
              activeColor: Theme.of(context).accentColor,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: labelText(context),
          ),
        ],
      ),
    );
  }

  forgotPassword(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          _auth.resetPassword(mail);
        },
        child: Text(
          'Forgot Password?',
          style: labelText(context),
        ),
      ),
    );
  }

  loginButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              loading = true;
            });
            dynamic result = await _auth.signInWithEmailAndPassword(mail, pass);
            if (result == null) {
              setState(() {
                error = 'Invalid Credentials';
                loading = false;
              });
            } else {
              goToHome(context);
            }
          }
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade400.withOpacity(0.35),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Center(
            child: Text(
              'LOGIN',
              style: loginbuttonText(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget orText(BuildContext context) {
    return Text(
      'OR',
      style: labelText(context),
    );
  }

  Widget signInWithText(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Sign in with',
          style: labelText(context),
        ),
      ],
    );
  }
}

Widget socialLogins(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SocialButton(
        context: context,
        signInType: "google",
      ),
      SocialButton(
        context: context,
        signInType: "facebook",
      ),
    ],
  );
}

Widget dontHaveAnAccount(context) {
  return GestureDetector(
    onTap: () => goToSignUp(context),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          'Sign Up',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
