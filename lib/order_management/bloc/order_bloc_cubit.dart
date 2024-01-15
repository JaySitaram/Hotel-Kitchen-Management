import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hotel_kitchen_management_flutter/const/storage.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'order_bloc_state.dart';

class OrderBlocCubit extends Cubit<OrderBlocState> {
  OrderBlocCubit() : super(OrderBlocInitial());

  Stream getOrderItems() {
    return FirebaseFirestore.instance.collection('order').snapshots();
  }

  Stream getOrderFilterItems() {
    String email = LocalStorage.readStorage(LocalStorage.email);
    return FirebaseFirestore.instance
        .collection('order')
        .where('Assigned Orders', isEqualTo: email)
        .snapshots();
  }

  Stream getAssignedChefs() {
    return FirebaseFirestore.instance.collection('chef').snapshots();
  }

  updateOrderStatus(String documentId, String selectedCat, String id) {
    FirebaseFirestore.instance
        .collection('order')
        .doc(documentId)
        .update({'Assigned Orders': selectedCat}).then((value) {
      //  FirebaseMessaging.instance.()
      sendPushMessage(id);
    });
  }

  Future<void> sendPushMessage(orderId) async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(token, orderId),
      );
      print('FCM request for device sent! >> $token');
    } catch (e) {
      print(e);
    }
  }

  String constructFCMPayload(String? token, String orderId) {
    return jsonEncode({
      'token': token,
      'notification': {
        'title': 'Order #$orderId',
        'body': 'Order has been assigned to chef',
      },
    });
  }
}
