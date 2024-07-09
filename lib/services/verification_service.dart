import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodly/controllers/phone_verification_controller.dart';
import 'package:get/get.dart';

class VerificationService {
  final controller = Get.put(PhoneVerificationController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(
    String phoneNumber, {
    required Null Function(String verificationId, int? resendToken) codeSent,
  }) async {
    await _auth.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credentials) async {
        controller.verifyPhoneFunction();
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      phoneNumber: phoneNumber,
      // timeout: const Duration(seconds: 60),
    );
  }

  Future<void> verifySmsCode(String verificationId, String smsCode) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    await _auth
        .signInWithCredential(credential)
        .then((value) => controller.verifyPhoneFunction());
  }
}
