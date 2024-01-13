import 'package:flutter/material.dart';
import 'package:hotel_kitchen_management_flutter/auth/bloc/authentication_cubit.dart';
import 'package:hotel_kitchen_management_flutter/chef_view/screens/chef_list_view.dart';

class ChefLoginPage extends StatefulWidget {
  const ChefLoginPage({super.key});

  @override
  State<ChefLoginPage> createState() => _ChefLoginPageState();
}

class _ChefLoginPageState extends State<ChefLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chef User'),
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
                      AuthenticationCubit().signUpUser(
                          context,
                          emailController.text,
                          passwordController.text,
                          'chef', () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChefOrderManagementScreen()));
                      });
                      // Trigger the login event
                      // context.read<AuthenticationBloc>().add(AuthenticationEvent.login);
                    }
                  },
                  child: Text('Login'),
                ),
              ],
            )));
  }
}
