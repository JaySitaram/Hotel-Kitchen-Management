import 'package:flutter/material.dart';
import 'package:hotel_kitchen_management_flutter/auth/bloc/authentication_cubit.dart';
import 'package:hotel_kitchen_management_flutter/dashboard/screens/dashboard_view.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin User'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // Validate fields before attempting login
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter both email and password'),
                      ),
                    );
                  } else {
                    // Trigger the login event
                    AuthenticationCubit().signUpUser(
                        context,
                        emailController.text,
                        passwordController.text,
                        'admin', () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminDashboard()));
                    });
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ));
  }
}
