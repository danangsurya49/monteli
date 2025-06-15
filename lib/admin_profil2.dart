import 'package:flutter/material.dart';
import 'package:montelimart/admin_home.dart';
import 'package:montelimart/admin_sales.dart';
import 'package:montelimart/admin_stock1.dart';
import 'package:montelimart/admin_profil1.dart';

class AdminProfil2 extends StatefulWidget {
  const AdminProfil2({super.key});

  @override
  State<AdminProfil2> createState() => _AdminProfil2State();
}

class _AdminProfil2State extends State<AdminProfil2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/Montelli_Family_Logo.png'),
          ),
        ),
        centerTitle: true,
        title: Text(
          'MontelliMart',
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Icon(Icons.person, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Text(
                'Please complete your profile',
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 24),
              // Date of birth
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today, color: Colors.blueGrey),
                  hintText: 'Date of birth',
                  hintStyle: TextStyle(color: Colors.blueGrey[200]),
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Phone
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixText: '+62 ',
                        prefixStyle: TextStyle(color: Colors.blueGrey),
                        border: UnderlineInputBorder(),
                        hintText: 'ID',
                        hintStyle: TextStyle(color: Colors.blueGrey[200]),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone, color: Colors.blueGrey),
                        hintText: 'Phone',
                        hintStyle: TextStyle(color: Colors.blueGrey[200]),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // NIP
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.tag, color: Colors.blueGrey),
                  hintText: 'NIP',
                  hintStyle: TextStyle(color: Colors.blueGrey[200]),
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Address 2
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on, color: Colors.blueGrey),
                  hintText: 'Address 2',
                  hintStyle: TextStyle(color: Colors.blueGrey[200]),
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Postcode
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.local_post_office, color: Colors.blueGrey),
                  hintText: 'Postcode',
                  hintStyle: TextStyle(color: Colors.blueGrey[200]),
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // City
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.home, color: Colors.blueGrey),
                  hintText: 'City',
                  hintStyle: TextStyle(color: Colors.blueGrey[200]),
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Country
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.check_circle, color: Colors.blueGrey),
                  hintText: 'Country',
                  hintStyle: TextStyle(color: Colors.blueGrey[200]),
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AdminProfil1()),
                  );
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.blueGrey,
        currentIndex: 2, // Halaman Stock
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminHome()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminSales()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminStock1()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminProfil1()),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Sales',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}