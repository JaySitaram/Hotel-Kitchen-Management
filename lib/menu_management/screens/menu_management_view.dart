import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          title: Text('Menu Items'),
          actions: [
            IconButton(
              icon: Icon(Icons.add_box_rounded),
              onPressed: () {
                // Trigger logout event
                // context.read<AuthenticationBloc>().add(AuthenticationEvent.logout);
                // Navigate back to the login screen (Replace with your actual login screen)
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddMenuItemView()));
              },
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                // Trigger logout event
                // context.read<AuthenticationBloc>().add(AuthenticationEvent.logout);
                // Navigate back to the login screen (Replace with your actual login screen)
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.0),
              // Replace this with your logic to fetch and display menu items
              // For simplicity, displaying a placeholder list of items
              StreamBuilder(
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
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MenuDetailView(
                                    items: data, documentId: docId)));
                          },
                          title: Text('Item ID : ${data['Item ID']}'),
                          subtitle: Text('Item Name : ${data['Item Name']}'),
                        );
                      },
                      itemCount: documents.length,
                    );
                  }),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
