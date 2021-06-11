import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:province_cambodia/service/authService.dart';
import 'package:flutter/material.dart';

class AuthBloc with ChangeNotifier{
  final authService = AuthService();
  final fb = FacebookLogin();
  User _user;
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;
  final _auth = FirebaseAuth.instance;

  Stream<User> get currentUser => authService.currentUser;

  loginFacebook() async {
    final res = await fb.logIn(
        permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ]
    );
    switch(res.status){
      case FacebookLoginStatus.success:
        print('It worked');
        //Get Token
        final FacebookAccessToken fbToken = res.accessToken;
        //Convert to Auth Credential
        final AuthCredential credential = FacebookAuthProvider.credential(fbToken.token);
        //User Credential to Sign in with Firebase
        final result = await authService.signInWithCredentail(credential);
        //print('${result.user.displayName} is now logged in');

        break;
      case FacebookLoginStatus.cancel:
        print('The user canceled the login');
        break;
      case FacebookLoginStatus.error:
        print('There was an error');
        break;
    }
    notifyListeners();
  }

  logoutFacebook(){
    authService.logout();
    notifyListeners();
  }

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future loginGoogle() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      isSigningIn = false;
    }
  }

  void logoutGoogle() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

}

