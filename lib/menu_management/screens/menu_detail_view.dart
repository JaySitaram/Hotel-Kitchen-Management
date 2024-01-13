import 'package:flutter/material.dart';
import 'package:hotel_kitchen_management_flutter/menu_management/bloc/menu_management_cubit.dart';

class MenuDetailView extends StatefulWidget {
  final Map<String, dynamic> items;
  final String documentId;
  const MenuDetailView(
      {Key? key, required this.items, required this.documentId})
      : super(key: key);

  @override
  _MenuDetailViewState createState() => _MenuDetailViewState();
}

class _MenuDetailViewState extends State<MenuDetailView> {
  String selectedCat = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item #${widget.items['Item ID']}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDetailItem('Category'),
              buildDetailItem('Description'),
              SizedBox(height: 16.0),
              buildDetailItem('Item Name'),
              buildDetailItem('Price'),
              buildDetailItem('availability'),
              SizedBox(height: 16.0),
              buildDetailItem('calories'),
              buildDetailItem('imageUrl'),
              SizedBox(height: 16.0),
              buildDetailItem('preparationTime'),
              buildDetailItem('rating'),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    MenuManagementCubit().updateMenuStatus(widget.documentId);
                  },
                  child: Text('Update Menu Item'),
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
}
