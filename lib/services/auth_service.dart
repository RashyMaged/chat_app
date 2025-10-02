import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  User? getCurrentUser(){
    return _auth.currentUser;
  }

  Future<UserCredential> signInwithEmail(String email,String password)async{
    try{
      UserCredential userCredential=await _auth.signInWithEmailAndPassword(email: email, password: password);
      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid':userCredential.user!.uid,
        'email':email

      });
      return userCredential;
    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }

  }
    Future<UserCredential> signUpwithEmail(String email,String password)async{
    try{
      UserCredential userCred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _firestore.collection('Users').doc(userCred.user!.uid).set({
        'uid':userCred.user!.uid,
        'email':email

      });
      return userCred;
    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
    
    }

  }
}