// ignore_for_file: use_build_context_synchronously

import 'package:coding_with_mamun_community/screens/drawer.dart';
import 'package:coding_with_mamun_community/screens/messenger.dart';
import 'package:coding_with_mamun_community/screens/post_form.dart';
import 'package:coding_with_mamun_community/screens/posts.dart';
import 'package:coding_with_mamun_community/screens/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logo_white.png', height: 30),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Profile()),
                  (route) => true);
            },
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      body: currentIndex == 0 ? const Posts() : const Messenger(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PostForm(title: 'Create post')));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 8,
        elevation: 10,
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.whatshot),
              label: 'Messenger',
            ),
          ],
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
