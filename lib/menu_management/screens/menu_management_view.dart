import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/menu_management/bloc/menu_management_cubit.dart';
import 'package:hotel_kitchen_management_flutter/menu_management/screens/add_menu_item_view.dart';
import 'package:hotel_kitchen_management_flutter/menu_management/screens/menu_detail_view.dart';

class MenuManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MenuManagementCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('menu_items'.tr),
          actions: [
            IconButton(
              icon: Icon(Icons.add_box_rounded),
              onPressed: () => _navigateToAddMenuItemView(context),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.0),
              _buildMenuItemsList(context),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItemsList(BuildContext context) {
    return StreamBuilder(
      stream: MenuManagementCubit().getMenuItems(),
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
            return _buildMenuItemTile(context, docId, data);
          },
          itemCount: documents.length,
        );
      },
    );
  }

  Widget _buildMenuItemTile(
      BuildContext context, String docId, Map<String, dynamic> data) {
    return ListTile(
      onTap: () => _navigateToMenuDetailView(context, data, docId),
      title: Text('${'item_id'.tr} : ${data['item_id']}'),
      subtitle: Text('${'item_name'.tr} : ${data['item_name']}'),
      trailing: IconButton(
        onPressed: () => MenuManagementCubit().deleteMenuItem(docId),
        icon: Icon(Icons.delete),
      ),
    );
  }

  void _navigateToAddMenuItemView(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddMenuItemView()));
  }

  void _navigateToMenuDetailView(
      BuildContext context, Map<String, dynamic> data, String docId) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MenuDetailView(items: data, documentId: docId)));
  }
}
