import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/order_management/bloc/order_bloc_cubit.dart';
import 'package:hotel_kitchen_management_flutter/reporting/screens/pdf_view.dart';

class ReportingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporting'),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<OrderBlocCubit, OrderBlocState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.0),
                buildOrderListView(),
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

  Widget buildOrderListView() {
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
          itemCount: documents.length,
          itemBuilder: (context, index) {
            String docId = documents[index].id;
            Map<String, dynamic> data =
                documents[index].data() as Map<String, dynamic>;
            return buildOrderListItem(context, docId, data);
          },
        );
      },
    );
  }

  Widget buildOrderListItem(
      BuildContext context, String docId, Map<String, dynamic> data) {
    return ListTile(
      title: Text('${'order_id'.tr} : ${data['order_id'.tr]}'),
      subtitle: Text('${'order_status'.tr} : ${data['order_status'.tr]}'),
      trailing: ElevatedButton(
        onPressed: () {
          generatePdf(data);
        },
        child: Text('Export as Pdf'),
      ),
    );
  }
}
