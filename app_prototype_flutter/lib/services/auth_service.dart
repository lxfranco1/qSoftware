import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:app_prototype_flutter/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = Firestore.instance;

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
    final uid = await getCurrentUID();

    //name, userName, email, following, followers
    List<String> followers = new List();
    List<String> following = new List();
//    List<String> followers = [];
//    List<String> following = [];
    final user = new User (name, null, email, followers, following, uid);
    db.collection("users").document(uid).collection("userData").add(user.toJson());
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

  //Converst anonymous user to a email and PW user
  Future convertUserWithEmail(String email, String password, String name) async{
    final currentUser = await _firebaseAuth.currentUser();

    final credential = EmailAuthProvider.getCredential(email: email, password: password);
    await currentUser.linkWithCredential(credential);
    await updateUserName(name, currentUser);

  }

  //Converst anonymous user to a google user
  Future convertWithGoogle() async{
    final currentUser = await _firebaseAuth.currentUser();
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: _googleAuth.idToken,
        accessToken: _googleAuth.accessToken
    );
    await currentUser.linkWithCredential(credential);
    await updateUserName(_googleSignIn.currentUser.displayName, currentUser);
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

