import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDetailItem('Order Date and Time'),
              buildDetailItem('Order Status'),
              SizedBox(height: 16.0),
              buildDetailItem('Customer ID'),
              buildDetailItem('Customer Name'),
              buildDetailItem('Customer Contact'),
              SizedBox(height: 16.0),
              Text(
                'Items in the Order:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              buildOrderItem('Item 1', 'Vegetables', '2', 'kg',
                  'Special instructions for Item 1'),
              buildOrderItem(
                  'Item 2', 'Fruits', '3', 'units', 'No special instructions'),
              SizedBox(height: 16.0),
              buildDetailItem('Delivery Address'),
              buildDetailItem('Delivery Time'),
              SizedBox(height: 16.0),
              buildDetailItem('Payment Status'),
              buildDetailItem('Payment Method'),
              SizedBox(height: 16.0),
              buildDetailItem('Admin Notes'),
              SizedBox(height: 16.0),
              buildDetailItem('Order Total'),
              SizedBox(height: 16.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: StreamBuilder(
                    stream: OrderBlocCubit().getAssignedChefs(),
                    builder: (context, snapshots) {
                      if (snapshots.hasError) {
                        return Center(child: Text('Error: ${snapshots.error}'));
                      }

                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
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
                        items: chefEmails
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    }),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    OrderBlocCubit()
                        .updateOrderStatus(widget.documentId, selectedCat);
                  },
                  child: Text('Update Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailItem(String title) {
    return ListTile(
      title: Text(title),
      subtitle: Text(widget.items[title].toString()),
    );
  }

  Widget buildOrderItem(String itemName, String category, String quantity,
      String unit, String specialInstructions) {
    return ListTile(
      title: Text('Item Name: $itemName'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Category: $category'),
          Text('Quantity: $quantity $unit'),
          Text('Special Instructions: $specialInstructions'),
        ],
      ),
    );
  }
}
