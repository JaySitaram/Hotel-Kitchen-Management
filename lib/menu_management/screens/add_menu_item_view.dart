import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/inventory_management/bloc/inventory_management_cubit.dart';
import 'package:hotel_kitchen_management_flutter/menu_management/bloc/menu_management_cubit.dart';
import 'package:uuid/uuid.dart';

class AddMenuItemView extends StatefulWidget {
  const AddMenuItemView({Key? key});

  @override
  State<AddMenuItemView> createState() => _AddMenuItemViewState();
}

class _AddMenuItemViewState extends State<AddMenuItemView> {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController preparationController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController specialInstructionCon = TextEditingController();

  final List<String> categoryItems = [
    'vegetables',
    'meats',
    'spices',
    'utensils'
  ];
  final List<String> measureItems = ['kilograms', 'liters', 'units'];

  String selectedCat = '';
  String selectedMeasure = '';
  bool available = false;

  @override
  void initState() {
    super.initState();
    InventoryManagementCubit().getInventoryListItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add_menu_item'.tr),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(itemNameController, 'item_name_hint'.tr),
              _buildTextField(priceController, 'price_hint'.tr),
              _buildCategoryDropdown(),
              _buildTextField(descriptionController, 'des_hint'.tr),
              _buildTextField(caloriesController, 'Enter Calories'),
              _buildTextField(preparationController, 'Enter Preparation Time'),
              _buildTextField(ratingController, 'Enter Rating'),
              _buildTextField(
                  specialInstructionCon, 'Enter Special Instruction'),
              _buildAvailabilitySwitch(),
              SizedBox(height: 20),
              _buildElevatedButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: selectedCat.isNotEmpty ? selectedCat : null,
          onChanged: (String? newValue) {
            setState(() {
              selectedCat = newValue!;
            });
          },
          items: categoryItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildAvailabilitySwitch() {
    return Row(
      children: [
        Expanded(child: Text('Availability')),
        Switch(
          value: available,
          onChanged: (value) {
            available = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildElevatedButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _triggerAddMenuItemEvent();
        },
        child: Text('add_menu_item'.tr),
      ),
    );
  }

  void _triggerAddMenuItemEvent() {
    MenuManagementCubit().addMenuItem({
      'item_id': Uuid().v4(),
      'item_name': itemNameController.text,
      'category': selectedCat,
      'price': priceController.text,
      'calories': caloriesController.text,
      'preparationTime': preparationController.text,
      'vegan': false,
      'vegeratian': false,
      'specialInstructions': specialInstructionCon.text,
      'rating': ratingController.text,
      'availability': available
    });
  }
}
