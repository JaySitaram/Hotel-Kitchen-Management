import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/inventory_management/bloc/inventory_management_cubit.dart';

class InventoryDetailView extends StatefulWidget {
  final Map<String, dynamic> mapItem;
  final String docId;
  const InventoryDetailView(
      {Key? key, required this.mapItem, required this.docId})
      : super(key: key);

  @override
  State<InventoryDetailView> createState() => _InventoryDetailViewState();
}

class _InventoryDetailViewState extends State<InventoryDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Item #${widget.mapItem['item_id']}'), // Replace with a dynamic title if needed
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              _buildListTile('item_name'),
              SizedBox(
                height: 10,
              ),
              _buildListTile('category'),
              SizedBox(
                height: 10,
              ),
              _buildListTile('quantity'),
              SizedBox(
                height: 10,
              ),
              _buildListTile('unit_measure'),
              SizedBox(
                height: 10,
              ),
              _buildListTile('str_location'),
              SizedBox(
                height: 10,
              ),
              _buildListTile('min_stock_level'),
              SizedBox(
                height: 10,
              ),
              _buildListTile('notes'),
              SizedBox(
                height: 20,
              ),
              _buildElevatedButton('update_item'.tr, () {
                // Trigger update item event
                // context.read<InventoryBloc>().add(InventoryEvent.updateItem);
                InventoryManagementCubit().updateInventoryStatus(widget.docId, {
                  'item_name': widget.mapItem['item_name'],
                  'category': widget.mapItem['category'],
                  'quantity': widget.mapItem['quantity'],
                  'unit_measure': widget.mapItem['unit_measure'],
                  'str_location': widget.mapItem['str_location'],
                  'min_stock_level': widget.mapItem['min_stock_level'],
                  'notes': widget.mapItem['notes'],
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.tr),
        TextFormField(
          controller:
              TextEditingController(text: widget.mapItem[title].toString()),
          onChanged: (value) {
            widget.mapItem[title] = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildElevatedButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
