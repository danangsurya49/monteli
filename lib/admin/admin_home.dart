import 'package:flutter/material.dart';
import 'package:montelimart/admin/admin_sales.dart';
import 'package:montelimart/admin/admin_stock1.dart';
import 'package:montelimart/supabase_services.dart';
import 'package:montelimart/auth/login_user.dart'; // Impor layar LoginUser

class AdminHome extends StatefulWidget {
  AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  num totalSales = 0;
  bool isLoadingSales = true;

  @override
  void initState() {
    super.initState();
    fetchTotalSales();
  }

  Future<void> fetchTotalSales() async {
    totalSales = await SupabaseService().getTotalPenjualanKeseluruhan();
    setState(() {
      isLoadingSales = false;
    });
  }

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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Kartu Profil Admin
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Ganti profil dengan logo
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/Montelli_Family_Logo.png'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Montelli Admin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'montelli123@gmail.com',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text('Total Penjualan', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: isLoadingSales
                            ? CircularProgressIndicator()
                            : Text(
                                'IDR${totalSales.toStringAsFixed(0)}',
                                style: TextStyle(color: Colors.red, fontSize: 24),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminSales()),
                        );
                      },
                      child: Text('Penjualan',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminStock1()),
                        );
                      },
                      child: Text('Stok',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () {},
                child: Text('Beranda',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 12), // Menambahkan spasi untuk tombol baru
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Mengubah warna untuk tombol logout
                ),
                onPressed: () {
                  // Navigasi kembali ke layar LoginUser
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginUser()),
                  );
                },
                child: Text(
                  'Keluar', // Teks tombol Logout
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
