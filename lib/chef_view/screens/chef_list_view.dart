import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/const/storage.dart';
import 'package:hotel_kitchen_management_flutter/const/widgets/drawer_widget.dart';
import 'package:hotel_kitchen_management_flutter/order_management/bloc/order_bloc_cubit.dart';
import 'package:hotel_kitchen_management_flutter/order_management/screens/order_detail_view.dart';

class ChefOrderManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('assigned_order'.tr),
        centerTitle: true,
      ),
      drawer: DrawerWidget(email: LocalStorage.readStorage(LocalStorage.email)),
      body: BlocBuilder<OrderBlocCubit, OrderBlocState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildOrderList(),
                SizedBox(height: 32.0),
                // if (state.isNotEmpty) Text(state, style: TextStyle(fontSize: 18.0)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderList() {
    return StreamBuilder(
      stream: OrderBlocCubit().getOrderFilterItems(),
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
            return ListTile(
              onTap: () {
                _navigateToOrderDetailView(context, data, docId);
              },
              title: Text("${('order_id'.tr)} : ${data['Order ID']}"),
              subtitle:
                  Text('${('order_status'.tr)} : ${data['Order Status']}'),
            );
          },
          itemCount: documents.length,
        );
      },
    );
  }

  void _navigateToOrderDetailView(
      BuildContext context, Map<String, dynamic> items, String documentId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            OrderDetailView(items: items, documentId: documentId),
      ),
    );
  }
}
