import 'package:flutter/material.dart';
import 'package:montelimart/admin/admin_home.dart';
import 'package:montelimart/admin/admin_sales.dart';
import 'package:montelimart/admin/admin_stock1.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AdminHome(),
    AdminSales(),
    AdminStock1(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Sales'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Stock'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}