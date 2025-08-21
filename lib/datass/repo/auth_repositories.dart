import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notifications/datass/repo/user_repo.dart';
import 'package:notifications/views/home_screeen.dart';
import 'package:notifications/views/login_screen.dart';
import 'package:notifications/widgets/exceptions/firebase_auth_exceptions.dart';
import 'package:notifications/widgets/exceptions/firebase_exceptions.dart';
import 'package:notifications/widgets/exceptions/format_exceptions.dart';
import 'package:notifications/widgets/exceptions/platform_exceptions.dart';

class AuthenticationProvider with ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static AuthenticationProvider? _instance;
  final UserRepository userRepo = UserRepository();
  final _auth = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;

  factory AuthenticationProvider() {
    _instance ??= AuthenticationProvider._internal();
    return _instance!;
  }

  AuthenticationProvider._internal();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    _isInitialized = true;

    // Remove splash screen once initialization is complete
    FlutterNativeSplash.remove();

    // Redirect to appropriate screen
    screenRedirect();
  }

  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      Future.microtask(() {
        navigateTo(const HomeScreeen());
      });
    } else {
      Future.microtask(() {
        navigateTo(LoginScreen());
      });
    }
  }

  // Navigation without context using navigatorKey (alternative approach)
  void navigateTo(Widget page) {
    if (navigatorKey.currentContext != null) {
      Navigator.of(
        navigatorKey.currentContext!,
      ).pushReplacement(MaterialPageRoute(builder: (_) => page));
    }
  }

  // }

  //**********************Email & Password Sign in Using Firebase*******************//

  //Email and Password Auth ---> Registered Users...

  Future<UserCredential> registerWithEmailandPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  // Email & Password Auth ---> Sign-in

  Future<UserCredential> loginWithEmailandPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  // --- Logout User

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Future.microtask(() {
        navigateTo(const LoginScreen());
      });
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "something went wrong, Please try again";
    }
  }

  //***-------------Federated identity & Social sign In -----------***/

  // [Google Sign in Authentications]
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Authentication flow...
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      // Obtain the auth details from the request...
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
      // Create New Crendentials...

      final userCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // signIn to firebase and Return the Credentials...
      return await _auth.signInWithCredential(userCredential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print("Something went Wrong $e");
      return null;
    }
  }

  //****------- Delete User Account -------****/

  Future<void> deleteUserAccount() async {
    try {
      await userRepo.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "something went wrong, Please try again";
    }
  }
}
