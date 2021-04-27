import 'package:chat/model/services/auth.dart';
import 'package:chat/view/login/style.dart';

import 'package:chat/controller/navigation/shortcuts.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  String mail = '',
      pass = '',
      pass2 = '',
      error = '',
      signInWith = 'skye-account';

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                width: 600,
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: iconColor(context)),
                              onPressed: () => goBack(context),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Create a new account',
                              style: headingFont(context),
                            ),
                          ],
                        ),
                        email(),
                        password(),
                        confirmPassword(),
                        SizedBox(
                          height: 5,
                        ),
                        submitButton(context),
                        Text(
                          error,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  email() {
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
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
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

  password() {
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
            validator: (val) => val!.length < 8
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

  confirmPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password',
          style: labelText(context),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: boxStyle(context),
          height: 60.0,
          child: TextFormField(
            validator: (val) => val!.length < 8
                ? 'Password should be of minimum 8 characters'
                : null,
            onChanged: (val) {
              setState(() {
                pass2 = val;
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

  Widget submitButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        submit(context);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade400.withOpacity(0.35),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Text(
            'SUBMIT',
            style: loginbuttonText(context),
          ),
        ),
      ),
    );
  }

  void submit(BuildContext context) async {
    AuthService _auth = AuthService();
    dynamic result =
        await _auth.signUpWithEmailAndPassword(context, mail, pass);
    if (result == null) {
      setState(() {
        error = 'Invalid Credentials';
        loading = false;
      });
    } else if (result == 'emailused') {
      setState(() {
        error = 'The account already exists for that email.';
        loading = false;
      });
    } else {
      goToConfirmationMail(context);
    }
  }
}
