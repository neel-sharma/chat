import 'package:chat/model/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:chat/view/login/style.dart';
import 'package:chat/model/user_id.dart';
import 'package:chat/controller/navigation/shortcuts.dart';

import 'package:chat/model/services/auth.dart';
import 'package:chat/model/services/database.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  PickedFile? file;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? error;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  bool isLoading = true;

  bool _agree = false,
      _userNameInvalid = false,
      _passInvalid = false,
      _confPassInvalid = false;

  String? currentDate, currentDay, currentMonth, currentYear;

  @override
  void initState() {
    currentDate = DateTime.now().toString();
    currentYear = currentDate!.substring(0, 4);
    currentMonth = currentDate!.substring(5, 7);
    currentDay = currentDate!.substring(8, 10);
    print(currentDate);
    print(currentDay! + " " + currentMonth! + " " + currentYear!);

    super.initState();
    isLoading = false;
  }

  void submit(BuildContext context, TextEditingController userName,
      TextEditingController mail, TextEditingController accountName) async {
    AuthService _auth = AuthService();
    String id = _auth.getCurrentUID();
    if (_formKey.currentState!.validate()) {
      await DatabaseService(uid: id).updateUserData(
        id,
        mail.text,
        userName.text,
        accountName.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserID? user = Provider.of<UserID?>(context);
    final usersRef = FirebaseFirestore.instance.collection('user-info');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).accentColor),
          onPressed: () => goToHome(context),
        ),
        title: Text(
          'Profile',
          style: headingFont(context),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
        future: usersRef.doc(user?.id).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          UserData? userInfo = UserData.fromDocument(snapshot.data);
          bool editing = false;
          TextEditingController userName = TextEditingController();
          TextEditingController mail = TextEditingController();
          TextEditingController accountName = TextEditingController();
          AuthService _auth = AuthService();
          mail.text = _auth.getCurrentEmail();
          if (userInfo.accountName != null) {
            print(userInfo.accountName);
            userName.text = userInfo.userName ?? '';
            mail.text = userInfo.mail ?? '';
            accountName.text = userInfo.accountName ?? '';
            editing = true;
          }
          return Container(
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Container(
                width: 600,
                height: 1100,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        userNameInput(context, userName),
                        SizedBox(
                          height: 20,
                        ),
                        if (editing) emailInput(context, mail),
                        if (editing)
                          SizedBox(
                            height: 20,
                          ),
                        accountNameInput(context, accountName),
                        SizedBox(
                          height: 30,
                        ),
                        submitButton(
                            context, userName, mail, accountName, editing),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          error ?? '',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  userNameInput(BuildContext context, TextEditingController userName) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Name',
            style: labelText(context),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: boxStyle(context),
            height: _userNameInvalid ? 60 : 60,
            child: TextFormField(
              controller: userName,
              validator: (val) {
                if (val!.length >= 20 && val.length != 0) {
                  _passInvalid = true;
                  return '  Max 20 characters allowed';
                } else if (val.isEmpty) {
                  _passInvalid = true;
                  return '  Enter your name';
                } else {
                  _passInvalid = false;
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              style: valueText(context),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.person,
                  color: iconColor(context),
                ),
                hintText: 'Enter your name',
                hintStyle: hintText(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailInput(BuildContext context, TextEditingController mail) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                'Email',
                style: labelText(context),
              ),
              SizedBox(width: 5.0),
              Icon(
                Icons.lock,
                size: 15,
                color: iconColor(context).withOpacity(0.7),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: boxStyle(context),
            height: 60.0,
            child: TextFormField(
              enabled: false,
              focusNode: FocusNode(),
              enableInteractiveSelection: false,
              controller: mail,
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              onChanged: (val) {
                setState(() {
                  mail.text = val;
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

  accountNameInput(BuildContext context, TextEditingController accountName) {
    bool _nameInvalid = true;
    bool _firstNameInvalid = true;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Account Name',
            style: labelText(context),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: boxStyle(context),
            height: _firstNameInvalid ? 60 : 60,
            child: TextFormField(
              controller: accountName,
              validator: (String? val) {
                if (val!.length >= 20 && val.length != 0) {
                  _nameInvalid = true;
                  return '  Max 20 characters allowed';
                } else if (val.isEmpty) {
                  _nameInvalid = true;
                  return '  Enter any name';
                } else {
                  _nameInvalid = false;
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              style: valueText(context),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.person,
                  color: iconColor(context),
                ),
                hintText: 'Enter your display name',
                hintStyle: hintText(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget submitButton(
    BuildContext context,
    TextEditingController userName,
    TextEditingController mail,
    TextEditingController accountName,
    bool editing,
  ) {
    String buttonText = 'CONFIRM';
    if (editing) buttonText = 'SAVE CHANGES';
    return GestureDetector(
      onTap: () {
        submit(context, userName, mail, accountName);
        goToHome(context);
      },
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade400.withOpacity(0.35),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
