import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_kitchen_management_flutter/auth/screens/choose_options_page.dart';
import 'package:hotel_kitchen_management_flutter/const/localization/locale_constant.dart';
import 'package:hotel_kitchen_management_flutter/const/storage.dart';

class DrawerWidget extends StatefulWidget {
  final String? email;
  DrawerWidget({Key? key, this.email});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final List<String> languagesList = ['en', 'ar'];

  @override
  Widget build(BuildContext context) {
    final email = LocalStorage.readStorage(LocalStorage.email);
    return Drawer(
      child: Column(
        children: [
          _buildUserProfile(email),
          _buildListTile(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {
              // Handle notifications
            },
          ),
          _buildLanguageDropdown(),
          _buildLogoutTile(),
        ],
      ),
    );
  }

  Widget _buildUserProfile(String? email) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 10, bottom: 20),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              'https://cdn.pixabay.com/photo/2021/02/12/07/03/icon-6007530_640.png',
            ),
          ),
          const SizedBox(width: 10),
          Text(
            email ?? '',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildLanguageDropdown() {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text('Languages'),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (Locale? newValue) {
            Get.updateLocale(newValue!);
          },
          items: supportedLocales.map<DropdownMenuItem<Locale>>((locale) {
            return DropdownMenuItem<Locale>(
              value: locale,
              child: Text(locale.languageCode),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLogoutTile() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ListTile(
        leading: const Icon(Icons.logout),
        title: Text('Logout'),
        onTap: () {
          _signOut().then((value) {
            LocalStorage.eraseStorage();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => ChooseAuthOptionsPage(),
              ),
              (route) => false,
            );
          });
        },
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User logged out');
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
