import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../utils/utils.dart';
import '../models/user.dart';

enum Errors {
  none,
  matchError,
  weakError,
  existsError,
  wrongError,
  noUserError,
  error,
}

class Auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Set up capability to convert Firebase data to a CustomUser
  final usersRef =
      FirebaseFirestore.instance.collection('users').withConverter<CustomUser>(
            fromFirestore: (snapshot, _) {
              return CustomUser.fromJson(
                snapshot.data() ?? {},
              );
            },
            toFirestore: (user, _) => user.toJson(),
          );

  String handleException(e) {
    // This should be Error type but can't get it working so casting all Errors to string
    String _status;
    switch (e.code) {
      case "weak-password":
        _status = Errors.weakError.toString();
        break;
      case "email-already-in-use":
        _status = Errors.existsError.toString();
        break;
      case "user-not-found":
        _status = Errors.noUserError.toString();
        break;
      case "wrong-password":
        _status = Errors.wrongError.toString();
        break;
      default:
        _status = Errors.error.toString();
        break;
    }
    return _status;
  }

  Future<String> attemptSignUp(String name, String email, String password,
      String passwordConfirmation) async {
    // Here is where Error _status does not work so require casting Errors to string
    String _status = '';
    // Manual check to make sure passwords match
    if (password != passwordConfirmation) {
      return Errors.matchError.toString();
    }
    try {
      // This adds user to Firebase Authentication
      UserCredential userCredentials =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? signedInUser = userCredentials.user;
      if (signedInUser != null) {
        // Setting default values for user
        Map<String, dynamic> userMap = {
          'key': const Uuid().v4(),
          'userID': signedInUser.uid,
          'email': signedInUser.email,
          'userName': name,
          'displayName': generateRandomString(8),
          'bio': 'No bio available',
          'location': 'No location available',
          'dateJoined': DateTime.now(),
          'imageUrl': 'https://picsum.photos/100/100',
          'coverImgUrl':
              'https://images.unsplash.com/photo-1519681393784-d120267933ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
          'isVerified': false,
          'followers': 0,
          'following': 0,
          'followersList': [],
          'followingList': [],
        };
        // This adds user to users collection
        await usersRef.doc(signedInUser.uid).set(CustomUser.fromJson(userMap));
        notifyListeners();
        return Errors.none.toString();
      }
    } on FirebaseAuthException catch (e) {
      _status = handleException(e);
    }
    return _status;
  }

  Future<String> attemptLogin(String email, String password) async {
    String _status = '';
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Errors.none.toString();
    } on FirebaseAuthException catch (e) {
      _status = (handleException(e));
    }
    return _status.toString();
  }

  void logout() {
    _auth.signOut();
    notifyListeners();
  }

  Future<CustomUser> getCurrentUserModel() async {
    // Get the user from Firebase users collection
    final snapshot = await Auth().usersRef.doc(_auth.currentUser!.uid).get();
    // Convert data to JSON format
    final user = snapshot.data()?.toJson();
    // Convert JSON to CustomUser - there is no way to convert from snapshot to CustomUser directly
    return CustomUser.fromJson(user!);
  }
}
