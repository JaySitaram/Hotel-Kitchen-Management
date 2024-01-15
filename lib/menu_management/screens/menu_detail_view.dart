import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: Text('Item #${widget.items['item_id']}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.items['imageUrl'] != null &&
                      widget.items['imageUrl'].isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(widget.items['imageUrl']),
                      radius: 30,
                    )
                  : Container(),
              buildDetailItem('category'),
              SizedBox(height: 16.0),
              buildDetailItem('description'),
              SizedBox(height: 16.0),
              buildDetailItem('item_name'),
              SizedBox(height: 16.0),
              buildDetailItem('price'),
              Row(
                children: [
                  Expanded(child: Text('Availability')),
                  Switch(
                      value: widget.items['availability'],
                      onChanged: (value) {
                        widget.items['availability'] = value;
                        setState(() {});
                      }),
                ],
              ),
              SizedBox(height: 16.0),
              buildDetailItem('calories'),
              // buildDetailItem('imageUrl'),
              SizedBox(height: 16.0),
              buildDetailItem('preparationTime'),
              SizedBox(height: 16.0),
              buildDetailItem('rating'),
              SizedBox(height: 16.0),
              buildDetailItem('specialInstructions'),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    MenuManagementCubit().updateMenuStatus(widget.documentId, {
                      'item_name': widget.items['item_name'],
                      'category': widget.items['category'],
                      'price': widget.items['price'],
                      'calories': widget.items['calories'],
                      'preparationTime': widget.items['preparationTime'],
                      'vegan': false,
                      'vegeratian': false,
                      'specialInstructions':
                          widget.items['specialInstructions'],
                      'rating': widget.items['rating'],
                      'availability': widget.items['availability']
                    });
                  },
                  child: Text('update_menu_item'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailItem(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.tr),
        TextFormField(
          controller:
              TextEditingController(text: widget.items[title].toString()),
          onChanged: (value) {
            widget.items[title] = value;
            // print('this is >> ${widget.items[title]} $title');
            setState(() {});
          },
        ),
      ],
    );
  }
}
