import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'order_bloc_state.dart';

class OrderBlocCubit extends Cubit<OrderBlocState> {
  OrderBlocCubit() : super(OrderBlocInitial());

  Stream getOrderItems() {
    return FirebaseFirestore.instance.collection('order').snapshots();
  }

  Stream getOrderFilterItems() {
    return FirebaseFirestore.instance
        .collection('order')
        .where('Assigned Orders', isEqualTo: 'chef@gmail.com')
        .snapshots();
  }

  Stream getAssignedChefs() {
    return FirebaseFirestore.instance.collection('chef').snapshots();
  }

  updateOrderStatus(String documentId, String selectedCat) {
    FirebaseFirestore.instance
        .collection('order')
        .doc(documentId)
        .update({'Assigned Orders': selectedCat}).then((value) {
      //  FirebaseMessaging.instance.()
      sendPushMessage();
    });
  }

  Future<void> sendPushMessage() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(token),
      );
      print('FCM request for device sent! >> $token');
    } catch (e) {
      print(e);
    }
  }

  String constructFCMPayload(String? token) {
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification was created via FCM!',
      },
    });
  }
}
