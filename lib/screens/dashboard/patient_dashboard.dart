import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'home_tab.dart';
import '../profile/profile_screen.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const Center(
      child: Text('My Health', style: TextStyle(color: Colors.white)),
    ),
    const Center(
      child: Text('Community', style: TextStyle(color: Colors.white)),
    ),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.activity),
              label: 'Health',
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.users),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(FeatherIcons.user),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
