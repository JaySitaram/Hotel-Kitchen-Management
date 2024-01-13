import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_kitchen_management_flutter/order_management/bloc/order_bloc_cubit.dart';
import 'package:hotel_kitchen_management_flutter/order_management/screens/order_detail_view.dart';

class ChefOrderManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assigned Orders'),
        actions: [
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
      body: BlocBuilder<OrderBlocCubit, OrderBlocState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   'Assigned Orders',
                //   style:
                //       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                // Replace this with your logic to fetch and display assigned orders
                // For simplicity, displaying a placeholder list of orders
                StreamBuilder(
                    stream: OrderBlocCubit().getOrderFilterItems(),
                    builder: (context, snapshots) {
                      if (snapshots.hasError) {
                        return Center(child: Text('Error: ${snapshots.error}'));
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
                                  builder: (context) => OrderDetailView(
                                      items: data, documentId: docId)));
                            },
                            title: Text('Order ID : ${data['Order ID']}'),
                            subtitle:
                                Text('Order Status : ${data['Order Status']}'),
                          );
                        },
                        itemCount: documents.length,
                      );
                    }),
                SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Trigger update status event
                        // context.read<ChefOrderBloc>().add(ChefOrderEvent.updateStatus);
                      },
                      child: Text('Update Status'),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                // if (state.isNotEmpty) Text(state, style: TextStyle(fontSize: 18.0)),
              ],
            ),
          );
        },
      ),
    );
  }
}
