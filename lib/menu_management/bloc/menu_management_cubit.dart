import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'menu_management_state.dart';

class MenuManagementCubit extends Cubit<MenuManagementState> {
  MenuManagementCubit() : super(MenuManagementInitial());

  Stream getMenuItems() {
    return FirebaseFirestore.instance.collection('menu').snapshots();
  }

  void updateMenuStatus(String documentId, Map<String, dynamic> mapItem) {
    FirebaseFirestore.instance
        .collection('menu')
        .doc(documentId)
        .update(mapItem);
  }

  void addMenuItem(Map<String, Object> map) {
    FirebaseFirestore.instance.collection('menu').add(map);
  }

  void deleteMenuItem(String docId) {
    FirebaseFirestore.instance.collection('menu').doc(docId).delete();
  }
}
