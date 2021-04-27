/*
Warning!!! 
The authentication of this application is set to my own SHA-1 and SHA-2 values. Which basically means you that sign in/up  
won't work after being compiled on a different environment till its android/app/google-services.json is replaced with the new
configurations.
*/

import 'package:chat/model/services/auth.dart';
import 'package:chat/model/user_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/model/user_id.dart';

import 'package:chat/model/services/database.dart';
import 'package:chat/controller/navigation/navigator.dart';
import 'package:chat/controller/theme/base_theme_service.dart';
import 'package:chat/controller/theme/prod_theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppTheme? appTheme = ProdAppTheme();
  final UserData? userData = UserData();
  final UserID? userID = UserID();

  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => appTheme),
        StreamProvider<UserData?>.value(
          initialData: userData,
          value: DatabaseService().info,
        ),
        StreamProvider<UserID?>.value(
          initialData: userID,
          value: AuthService().user,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
        builder: (BuildContext context, AppTheme appTheme, Widget? child) {
      return MaterialApp(
        title: 'Chat',
        theme: appTheme.getLightTheme(),
        darkTheme: appTheme.getDarkTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: 'Home',
        onGenerateRoute: Path.getPath,
      );
    });
  }
}
