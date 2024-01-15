import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/inventory_management/bloc/inventory_management_cubit.dart';
import 'package:hotel_kitchen_management_flutter/inventory_management/screens/add_inventory_item_view.dart';
import 'package:hotel_kitchen_management_flutter/inventory_management/screens/inventory_detail_view.dart';

class InventoryManagementScreen extends StatefulWidget {
  @override
  State<InventoryManagementScreen> createState() =>
      _InventoryManagementScreenState();
}

class _InventoryManagementScreenState extends State<InventoryManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('inventory_items'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_rounded),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddInventoryItemView()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<InventoryManagementCubit, InventoryManagementState>(
          bloc: InventoryManagementCubit(),
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildInventoryList(),
                SizedBox(height: 32.0),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInventoryList() {
    return StreamBuilder(
      stream: InventoryManagementCubit().getInventoryListItems(),
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
            return _buildInventoryListItem(docId, data);
          },
          itemCount: documents.length,
        );
      },
    );
  }

  Widget _buildInventoryListItem(String docId, Map<String, dynamic> data) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => InventoryDetailView(
              mapItem: data,
              docId: docId,
            ),
          ),
        );
      },
      title: Text('${'item_name'.tr} : ${data['item_name']}'),
      subtitle: Text('${'category'.tr} : ${data['category']}'),
      trailing: IconButton(
        onPressed: () {
          InventoryManagementCubit().deleteInventoryItem(docId);
        },
        icon: Icon(Icons.delete),
      ),
    );
  }
}
