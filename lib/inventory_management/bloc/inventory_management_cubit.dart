import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

part 'inventory_management_state.dart';

class InventoryManagementCubit extends Cubit<InventoryManagementState> {
  InventoryManagementCubit() : super(InventoryManagementInitial());

  Stream getInventoryListItems() {
    return FirebaseFirestore.instance.collection('inventory').snapshots();
  }

  addInventoryItem(Map<String, dynamic> mapItem) {
    FirebaseFirestore.instance.collection('inventory').add(mapItem);
  }

  deleteInventoryItem(String docId) {
    FirebaseFirestore.instance.collection('inventory').doc(docId).delete();
  }

  void updateInventoryStatus(documentId, Map<String, dynamic> map) {
    FirebaseFirestore.instance
        .collection('inventory')
        .doc(documentId)
        .update(map);
  }
}
