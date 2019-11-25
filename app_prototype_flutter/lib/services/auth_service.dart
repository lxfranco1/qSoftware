import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  //check the login state
  // when the user loging in or out the state will change
  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
      (FirebaseUser user) => user?.uid,
  );

  // GET UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }
  
  //Email & Password Signup
  Future<String> createUserWithEmailAndPassword(String email, String password,
      String name) async{
    print(name);
    print(email);
    print(password);
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
    );

    //Update the username
    // Update the username
    await updateUserName(name, authResult.user);
    return authResult.user.uid;
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

//Email & Password Sign IndexError

  Future<String> signInWithEmailAndPassword(String email, String password) async{
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user.uid;
  }

// Sign out
  signOut(){
    return _firebaseAuth.signOut();
  }

  //Reset Password
  Future sendPasswordResetEmail(String email){
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Sign in Anonymously
  Future signInAnonymously(){
    return _firebaseAuth.signInAnonymously();
  }

  //Google Sign In
  Future<String> signInWithGoogle() async{
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: _googleAuth.idToken, 
        accessToken: _googleAuth.accessToken
    );
    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }

}

class NameValidator {
  static String validate(String value){
    if(value.isEmpty){
      return "Name can't be empty";
    }
    if(value.length < 2){
      return "Name must be at least 2 characters long";
    }
    if(value.length > 50){
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}

class EmailValidator {
  static String validate(String value){
    if(value.isEmpty){
      return "Email can't be empty";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value){
    if(value.isEmpty){
      return "Password can't be empty";
    }
    return null;
  }
}

