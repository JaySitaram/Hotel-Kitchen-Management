import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_kitchen_management_flutter/reporting/bloc/reporting_cubit.dart';

class ReportingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportingCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reporting'),
        ),
        body: Center(
          child: BlocBuilder<ReportingCubit, ReportingState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // if (state.isNotEmpty)
                  //   Container(
                  //     width: 200,
                  //     height: 200,
                  //     child: Image.memory(state),
                  //   ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger back event
                      Navigator.pop(context);
                    },
                    child: Text('Back'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
