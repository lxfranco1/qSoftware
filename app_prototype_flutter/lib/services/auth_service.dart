import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //check the login state
  // when the user loging in or out the state will change
  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
      (FirebaseUser user) => user?.uid,
  );
  
  //Email & Password Signup
  Future<String> createUserWithEmailAndPassword(String email, String password, String name) async{
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );

    //Update the username
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
    return currentUser.uid;
  }

//Email & Password Sign IndexError

  Future<String> signInWithEmailAndPassword(String email, String password) async{
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).uid;
  }

// Sign out
  signOut(){
    return _firebaseAuth.signOut();
  }
}

