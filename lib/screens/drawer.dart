// ignore_for_file: use_build_context_synchronously

import 'package:coding_with_mamun_community/constant.dart';
import 'package:coding_with_mamun_community/models/api_response.dart';
import 'package:coding_with_mamun_community/models/user.dart';
import 'package:coding_with_mamun_community/screens/home.dart';
import 'package:coding_with_mamun_community/screens/login.dart';
import 'package:coding_with_mamun_community/services/user_service.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  User? user;
  bool loading = true;

  //__get user__
  void _getUserDetail() async {
    ApiResponse apiResponse = await getUserDetail();
    if (apiResponse.error == null) {
      setState(() {
        user = apiResponse.data as User;
        loading = false;
      });
    } else if (apiResponse.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(apiResponse.error!),
      ));
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    _getUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 90,
            child: !loading
                ? DrawerHeader(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ListTile(
                      title: Text(
                        '${user!.name}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        '${user!.email}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: user!.image != null
                            ? NetworkImage('${user!.image}')
                            : const NetworkImage(
                                'https://avatars.githubusercontent.com/u/76045663?v=4'),
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home, color: Colors.deepOrange),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false);
            },
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
