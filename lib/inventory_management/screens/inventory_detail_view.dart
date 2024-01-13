import 'package:flutter/material.dart';

class InventoryDetailView extends StatefulWidget {
  const InventoryDetailView({super.key});

  @override
  State<InventoryDetailView> createState() => _InventoryDetailViewState();
}

class _InventoryDetailViewState extends State<InventoryDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item #1'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Item Name'),
            trailing: Text('Item 1'),
          ),
          ListTile(
            title: Text('Category'),
            trailing: Text('Vegetables'),
          ),
          ListTile(
            title: Text('Quantity'),
            trailing: Text('1'),
          ),
          ListTile(
            title: Text('Unit of Measurement'),
            trailing: Text('kg'),
          ),
          ListTile(
            title: Text('Storage Location'),
            trailing: Text('Refrigerator'),
          ),
          ListTile(
            title: Text('Minimum Stock Level'),
            trailing: Text('2'),
          ),
          ListTile(
            title: Text('Notes'),
            trailing: Text(''),
          ),
          ElevatedButton(
            onPressed: () {
              // Trigger update item event
              // context.read<InventoryBloc>().add(InventoryEvent.updateItem);
            },
            child: Text('Update Item'),
          ),
        ],
      ),
    );
  }
}
