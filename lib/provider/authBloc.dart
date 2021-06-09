import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:province_cambodia/model/userProfile.dart';
import 'package:province_cambodia/service/authService.dart';
import 'package:flutter/material.dart';

class AuthBloc with ChangeNotifier{
  final authService = AuthService();
  final fb = FacebookLogin();
  final user = UserData();
  User _user;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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

  Future<User> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential authResult = await _auth.signInWithCredential(credential);
    _user = authResult.user;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    User currentUser = _auth.currentUser;
    assert(_user.uid == currentUser.uid);
    print("User Name: ${_user.displayName}");
    print("User Email ${_user.email}");
  }
}

