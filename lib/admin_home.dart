import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.point_of_sale), label: 'Cashier'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Stock'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              // Logo dan Avatar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/logo.png'), // Ganti dengan path logo
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/avatar.png'), // Ganti dengan foto admin
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Kartu Admin Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal[700],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/avatar.png'), // Ganti
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("MontelliMart", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("NIP: 123456789", style: TextStyle(color: Colors.white70)),
                          Text("admin@email.com", style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Total Sales This Month
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal[400],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Total Sales this Month", style: TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(height: 8),
                    Text("IDR0.0", style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Total Sales Today
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Total Sales Today", style: TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(height: 8),
                    Text("IDR0.0", style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Aksi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[800]),
                      onPressed: () {},
                      child: const Text("Cashier"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[800]),
                      onPressed: () {},
                      child: const Text("Stock"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[800], minimumSize: const Size.fromHeight(50)),
                onPressed: () {},
                child: const Text("Admin Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}