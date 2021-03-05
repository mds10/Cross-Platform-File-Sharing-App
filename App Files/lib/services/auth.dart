import 'package:ShareApp/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change stream
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  // sign in with anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await user.sendEmailVerification();
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // sign out
  Future signOut() async {
    try {
      if(await googleSignIn.isSignedIn()){
        return await googleSignIn.signOut();
      }
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    print("Signed in with goole");
    try {
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null){
        return null;
      }
      AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      if(res == null){
        return null;
      }
      print("user recieved");
      return res.user;
    } catch (e) {
      print(e);
    }
  }

}