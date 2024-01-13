import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      create: (_) => InventoryManagementCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inventory Items'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddInventoryItemView()));
              },
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                // Trigger logout event
                //  context.read<AuthenticationBloc>().add(AuthenticationEvent.logout);
                // Navigate back to the login screen (Replace with your actual login screen)
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Center(
          child:
              BlocBuilder<InventoryManagementCubit, InventoryManagementState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder(
                      stream:
                          InventoryManagementCubit().getInventoryListItems(),
                      builder: (context, snapshots) {
                        if (snapshots.hasError) {
                          return Center(
                              child: Text('Error: ${snapshots.error}'));
                        }

                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
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
                                    builder: (context) =>
                                        InventoryDetailView()));
                              },
                              title: Text('Item Name : ${data['Item Name']}'),
                              subtitle: Text('Category : ${data['Category']}'),
                              trailing: IconButton(
                                onPressed: () {
                                  InventoryManagementCubit()
                                      .deleteInventoryItem(docId);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            );
                          },
                          itemCount: documents.length,
                        );
                      }),
                  SizedBox(height: 32.0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
