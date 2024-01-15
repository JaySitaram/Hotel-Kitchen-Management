import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_kitchen_management_flutter/const/storage.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  signUpUser(BuildContext context, String email, String password, String role,
      Function successRes) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user?.email != null) {
        LocalStorage.writeStorage(LocalStorage.email, credential.user?.email);
        LocalStorage.writeStorage(LocalStorage.userRole, role);
        successRes();
        FirebaseFirestore.instance
            .collection(role)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({'email': email, 'password': password});
      }
    } on FirebaseAuthException catch (e) {
      print('this is >> ${e.code}');
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user.')));
      } else if (e.code == 'email-already-in-use') {
        await signInUser(context, email, password, role, successRes);
      }
    }
  }

  signInUser(BuildContext context, String email, String password, String role,
      Function successRes) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user?.email != null) {
        LocalStorage.writeStorage(LocalStorage.email, credential.user?.email);
        LocalStorage.writeStorage(LocalStorage.userRole, role);
        successRes();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user.')));
      }
    }
  }
}
