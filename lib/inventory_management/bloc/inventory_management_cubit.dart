import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'inventory_management_state.dart';

class InventoryManagementCubit extends Cubit<InventoryManagementState> {
  InventoryManagementCubit() : super(InventoryManagementInitial());

  Stream getInventoryListItems() {
    return FirebaseFirestore.instance
        .collection('admin')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('inventory')
        .snapshots();
  }

  addInventoryItem(Map<String, dynamic> mapItem) {
    FirebaseFirestore.instance
        .collection('admin')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('inventory')
        .add(mapItem);
  }

  deleteInventoryItem(String docId) {
    FirebaseFirestore.instance
        .collection('admin')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('inventory')
        .doc(docId)
        .delete();
  }
}
