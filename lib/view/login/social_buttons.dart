import 'package:flutter/material.dart';
import 'package:chat/controller/navigation/shortcuts.dart';
import 'package:chat/model/services/auth.dart';

class SocialButton extends StatefulWidget {
  final BuildContext? context;
  final String? signInType;

  SocialButton({Key? key, this.context, this.signInType}) : super(key: key);

  @override
  _SocialButtonState createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    switch (widget.signInType) {
      case "google":
        return InkWell(
          onTap: () async {
            await _auth.signInWithGoogle();
            bool isUserLoggedIn = false;
            var user = _auth.getCurrentUID();
            if (user != '') isUserLoggedIn = true;
            if (isUserLoggedIn) {
              goToHome(context);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).accentColor,
              ),
            ),
            child: ImageIcon(
              AssetImage('assets/social_logos/google.png'),
              color: Theme.of(context).accentColor,
            ),
          ),
        );

      case "facebook":
        return InkWell(
          onTap: () {
            _auth.signInWithFacebook();
            bool isUserLoggedIn = false;
            var user = _auth.getCurrentUID();
            if (user != '') isUserLoggedIn = true;
            if (isUserLoggedIn) {
              goToHome(context);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).accentColor,
              ),
            ),
            child: ImageIcon(
              AssetImage('assets/social_logos/facebook.png'),
              color: Theme.of(context).accentColor,
            ),
          ),
        );

      default:
        return const Text("error");
    }
  }
}
