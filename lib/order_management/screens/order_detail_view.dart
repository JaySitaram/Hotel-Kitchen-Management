import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/order_management/bloc/order_bloc_cubit.dart';

class OrderDetailView extends StatefulWidget {
  final Map<String, dynamic> items;
  final String documentId;
  const OrderDetailView(
      {Key? key, required this.items, required this.documentId})
      : super(key: key);

  @override
  _OrderDetailViewState createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  String selectedCat = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCat = widget.items['Assigned Orders'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${widget.items['Order ID']}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              buildDetailItem('order_date_time'.tr, 'Order Date and Time'),
              buildDetailItem('order_status'.tr, 'Order Status'),
              buildDetailItem('customer_id'.tr, 'Customer ID'),
              buildDetailItem('customer_name'.tr, 'Customer Name'),
              buildDetailItem('customer_contact'.tr, 'Customer Contact'),
              buildOrderItemsSection(),
              buildDetailItem('delivery_address'.tr, 'Delivery Address'),
              buildDetailItem('payment_method'.tr, 'Payment Method'),
              buildDetailItem('payment_status'.tr, 'Payment Status'),
              buildDetailItem('admin_notes'.tr, 'Admin Notes'),
              buildDetailItem('order_total'.tr, 'Order Total'),
              buildChefDropdown(),
              buildUpdateOrderButton(widget.items['Order ID']),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChefDropdown() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: StreamBuilder(
          stream: OrderBlocCubit().getAssignedChefs(),
          builder: (context, snapshots) {
            if (snapshots.hasError) {
              return Center(child: Text('Error: ${snapshots.error}'));
            }

            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<String> chefEmails = snapshots.data!.docs
                .map((doc) => doc['email'].toString())
                .toList()
                .cast<String>();

            return DropdownButtonFormField<String>(
              value: selectedCat.isNotEmpty ? selectedCat : null,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCat = newValue!;
                });
              },
              items: chefEmails.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            );
          }),
    );
  }

  Widget buildDetailItem(String title, String value) {
    return ListTile(
      minVerticalPadding: 0,
      title:
          Text(title, style: TextStyle(fontSize: 16, fontFamily: 'SemiBold')),
      subtitle: Text(widget.items[value].toString(),
          style: TextStyle(fontSize: 15, fontFamily: 'Medium')),
    );
  }

  Widget buildOrderItemsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Items in the Order:',
              style: TextStyle(fontSize: 18, fontFamily: 'Bold'),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: ListTile(
                    title: Text(
                        '${'item_name'.tr}: ${widget.items['items'][index]['Item Name']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${'category'.tr}: ${widget.items['items'][index]['Category']}'),
                        Text(
                            '${'quantity'.tr}: ${widget.items['items'][index]['Quantity']}'),
                        Text(
                            '${'special_instructor'.tr}: ${widget.items['items'][index]['Special Instructions']}'),
                      ],
                    ),
                  ));
            },
            itemCount: widget.items['items'].length,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildOrderItem(String itemName, String category, String quantity,
      String unit, String specialInstructions) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(0))),
        child: ListTile(
          title: Text('${'item_name'.tr}: $itemName'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${'category'.tr}: $category'),
              Text('${'quantity'.tr}: $quantity $unit'),
              Text('${'special_instructor'.tr}: $specialInstructions'),
            ],
          ),
        ));
  }

  Widget buildUpdateOrderButton(id) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          OrderBlocCubit()
              .updateOrderStatus(widget.documentId, selectedCat, id);
        },
        child: Text('update_order'.tr),
      ),
    );
  }
}
