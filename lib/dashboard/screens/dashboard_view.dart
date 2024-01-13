import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_kitchen_management_flutter/dashboard/bloc/dashboard_bloc_cubit.dart';
import 'package:hotel_kitchen_management_flutter/inventory_management/screens/inventory_management_view.dart';
import 'package:hotel_kitchen_management_flutter/menu_management/screens/menu_management_view.dart';
import 'package:hotel_kitchen_management_flutter/order_management/screens/order_management_view.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBlocCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin Dashboard'),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                // Trigger logout event
                // context
                //     .read<AuthenticationBloc>()
                //     .add(AuthenticationEvent.logout);
                // Navigate back to the login screen (Replace with your actual login screen)
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<DashboardBlocCubit, DashboardBlocState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuManagementScreen()),
                      );
                    },
                    child: Text('Manage Menu'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger go to orders event
                      // context
                      //     .read<DashboardBlocCubit>()
                      //     .add(DashboardEvent.goToOrders);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OrderManagementScreen()));
                    },
                    child: Text('Order Management'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger go to inventory event
                      // context
                      //     .read<DashboardBloc>()
                      //     .add(DashboardEvent.goToInventory);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => InventoryManagementScreen()));
                    },
                    child: Text('Inventory Management'),
                  ),
                  SizedBox(height: 32.0),
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
      ),
    );
  }
}
