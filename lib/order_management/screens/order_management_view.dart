import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/order_management/bloc/order_bloc_cubit.dart';
import 'package:hotel_kitchen_management_flutter/order_management/screens/order_detail_view.dart';

class OrderManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('incoming_orders'.tr),
      ),
      body: Center(
        child: BlocBuilder<OrderBlocCubit, OrderBlocState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.0),
                buildOrderList(),
                SizedBox(height: 32.0),
                // if (state.isNotEmpty)
                //   Text(state, style: TextStyle(fontSize: 18.0)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildOrderList() {
    return StreamBuilder(
      stream: OrderBlocCubit().getOrderItems(),
      builder: (context, snapshots) {
        if (snapshots.hasError) {
          return Center(child: Text('Error: ${snapshots.error}'));
        }

        if (snapshots.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<DocumentSnapshot> documents = snapshots.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            String docId = documents[index].id;
            Map<String, dynamic> data =
                documents[index].data() as Map<String, dynamic>;
            return buildOrderListItem(context, docId, data);
          },
          itemCount: documents.length,
        );
      },
    );
  }

  Widget buildOrderListItem(
      BuildContext context, String docId, Map<String, dynamic> data) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                OrderDetailView(items: data, documentId: docId),
          ),
        );
      },
      title: Text('${'order_id'.tr} : ${data['order_id'.tr]}'),
      subtitle: Text('${'order_status'.tr} : ${data['order_status'.tr]}'),
    );
  }
}
