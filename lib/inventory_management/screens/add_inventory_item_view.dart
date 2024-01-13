import 'package:flutter/material.dart';
import 'package:hotel_kitchen_management_flutter/inventory_management/bloc/inventory_management_cubit.dart';

class AddInventoryItemView extends StatefulWidget {
  const AddInventoryItemView({super.key});

  @override
  State<AddInventoryItemView> createState() => _AddInventoryItemViewState();
}

class _AddInventoryItemViewState extends State<AddInventoryItemView> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemQtyController = TextEditingController();
  TextEditingController storageLocationController = TextEditingController();
  TextEditingController minStockLevelController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  List<String> categoryItems = ['vegetables', 'meats', 'spices', 'utensils'];
  List<String> measureItems = ['kilograms', 'liters', 'units'];
  String selectedCat = '';
  String selectedMeasure = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InventoryManagementCubit().getInventoryListItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Inventory Item'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(
                hintText: 'Enter Item Name',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              value: selectedCat.isNotEmpty ? selectedCat : null,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCat = newValue!;
                });
              },
              items:
                  categoryItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: itemQtyController,
              decoration: InputDecoration(
                hintText: 'Enter Item Quantity',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              value: selectedMeasure.isNotEmpty ? selectedMeasure : null,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMeasure = newValue!;
                });
              },
              items: measureItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: storageLocationController,
              decoration: InputDecoration(
                hintText: 'Enter Storage Location',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: minStockLevelController,
              decoration: InputDecoration(
                hintText: 'Enter Minimum Stock Level',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: notesController,
              decoration: InputDecoration(
                hintText: 'Enter Notes',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Trigger add item event
                  InventoryManagementCubit().addInventoryItem({
                    'Item Name': itemNameController.text,
                    'Category': selectedCat,
                    'Quantity': itemQtyController.text,
                    'Unit of Measurements': selectedMeasure,
                    'Storage Location': storageLocationController.text,
                    'Minimum Stock Location': storageLocationController.text,
                    'Notes': notesController.text
                  });
                  // context.read<MenuBloc>().add(MenuEvent.addItem);
                },
                child: Text('Add Item'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
