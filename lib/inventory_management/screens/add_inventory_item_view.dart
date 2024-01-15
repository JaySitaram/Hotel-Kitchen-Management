import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/inventory_management/bloc/inventory_management_cubit.dart';
import 'package:uuid/uuid.dart';

class AddInventoryItemView extends StatelessWidget {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController itemQtyController = TextEditingController();
  final TextEditingController storageLocationController =
      TextEditingController();
  final TextEditingController minStockLevelController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final List<String> categoryItems = [
    'vegetables',
    'meats',
    'spices',
    'utensils'
  ];
  final List<String> measureItems = ['kilograms', 'liters', 'units'];
  String selectedCat = '';
  String selectedMeasure = '';

  AddInventoryItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add_inventory_item'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              _buildTextField(itemNameController, 'item_name_hint'.tr),
              SizedBox(height: 10),
              _buildDropdown(
                selectedValue: selectedCat,
                onChanged: (String? newValue) {
                  selectedCat = newValue!;
                },
                items: categoryItems,
              ),
              SizedBox(height: 10),
              _buildTextField(itemQtyController, 'item_qty_hint'.tr),
              SizedBox(height: 10),
              _buildDropdown(
                selectedValue: selectedMeasure,
                onChanged: (String? newValue) {
                  selectedMeasure = newValue!;
                },
                items: measureItems,
              ),
              SizedBox(height: 10),
              _buildTextField(
                  storageLocationController, 'str_location_hint'.tr),
              SizedBox(height: 10),
              _buildTextField(minStockLevelController, 'stock_level_hint'.tr),
              SizedBox(height: 10),
              _buildTextField(notesController, 'note_hint'.tr),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _addItem(context),
                  child: Text('add_item'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }

  Widget _buildDropdown({
    required String? selectedValue,
    required Function(String?) onChanged,
    required List<String> items,
  }) {
    return DropdownButtonFormField<String>(
      value: selectedValue?.isNotEmpty ?? false ? selectedValue : null,
      onChanged: (String? newValue) {
        onChanged(newValue);
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _addItem(BuildContext context) {
    InventoryManagementCubit().addInventoryItem({
      'item_name': itemNameController.text,
      'item_id': Uuid().v4(),
      'category': selectedCat,
      'quantity': itemQtyController.text,
      'unit_measure': selectedMeasure,
      'str_location': storageLocationController.text,
      'min_stock_level': minStockLevelController.text,
      'notes': notesController.text,
    });
  }
}
