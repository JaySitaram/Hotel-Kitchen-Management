import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/const/storage.dart';
import 'package:hotel_kitchen_management_flutter/const/widgets/drawer_widget.dart';
import 'package:hotel_kitchen_management_flutter/dashboard/bloc/dashboard_bloc_cubit.dart';
import 'package:hotel_kitchen_management_flutter/inventory_management/screens/inventory_management_view.dart';
import 'package:hotel_kitchen_management_flutter/menu_management/screens/menu_management_view.dart';
import 'package:hotel_kitchen_management_flutter/order_management/screens/order_management_view.dart';
import 'package:hotel_kitchen_management_flutter/reporting/screens/reporting_view.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(email: LocalStorage.readStorage(LocalStorage.email)),
      appBar: AppBar(
        title: Text('admin_dashboard'.tr),
        actions: [],
      ),
      body: Center(
        child: BlocBuilder<DashboardBlocCubit, DashboardBlocState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildElevatedButton(
                  onPressed: () => _navigateTo(context, ReportingScreen()),
                  label: 'Reporting',
                ),
                _buildSizedBox(16.0),
                _buildElevatedButton(
                  onPressed: () => _navigateTo(context, MenuManagementScreen()),
                  label: 'manage_menu'.tr,
                ),
                _buildSizedBox(16.0),
                _buildElevatedButton(
                  onPressed: () =>
                      _navigateTo(context, OrderManagementScreen()),
                  label: 'order_management'.tr,
                ),
                _buildSizedBox(16.0),
                _buildElevatedButton(
                  onPressed: () =>
                      _navigateTo(context, InventoryManagementScreen()),
                  label: 'inventory_management'.tr,
                ),
                _buildSizedBox(32.0),
                // if (state.isNotEmpty)
                //   Text(
                //     'Redirecting to ${state == 'orders' ? 'Order' : 'Inventory'} Management...',
                //     style: TextStyle(fontSize: 18.0),
                //   ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildElevatedButton({
    required VoidCallback onPressed,
    required String label,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }

  Widget _buildSizedBox(double height) {
    return SizedBox(height: height);
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
