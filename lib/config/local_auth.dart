import 'package:diary/config/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    return await _auth.canCheckBiometrics;
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();

    if (!isAvailable) {
      EasyLoading.showError("Device doesn't support fingerprint");
      return false;
    }
    try {
      return await _auth.authenticate(
          localizedReason: "Scan Fingerprint",
          options: const AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: true, biometricOnly: true));
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      EasyLoading.showError("Please set a fingerprint first");
      Constants.isLockEnabled = false;
      Constants.setIsLockEnabled(false);
      return false;
    }
  }
}
