// ignore_for_file: use_build_context_synchronously

import 'package:coding_with_mamun_community/screens/login.dart';
import 'package:coding_with_mamun_community/services/user_service.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(
            height: 90,
            child: DrawerHeader(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(5.0),
              child: ListTile(
                title: Text('Mamunur Rashid'),
                subtitle: Text('mrmamun@gmail.com'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/76045663?v=4'),
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home, color: Colors.deepOrange),
            onTap: () {},
          ),
          ListTile(
            title: const Text('About'),
            leading: const Icon(Icons.info, color: Colors.deepOrange),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Contact'),
            leading: const Icon(Icons.message, color: Colors.deepOrange),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(Icons.privacy_tip, color: Colors.deepOrange),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Terms & Conditions'),
            leading: const Icon(Icons.verified_user, color: Colors.deepOrange),
            onTap: () {},
          ),
          ListTile(
            title: const Text('FAQ'),
            leading:
                const Icon(Icons.question_answer, color: Colors.deepOrange),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout, color: Colors.deepOrange),
            onTap: () async {
              await logout();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Login()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
