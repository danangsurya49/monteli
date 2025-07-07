import 'package:flutter/material.dart';
import 'package:montelimart/admin/admin_home.dart';
import 'package:montelimart/admin/admin_sales.dart';
import 'package:montelimart/admin/admin_stock2.dart';
import 'package:montelimart/supabase_services.dart';

class AdminStock1 extends StatefulWidget {
  const AdminStock1({super.key});

  @override
  State<AdminStock1> createState() => _AdminStockState();
}

class _AdminStockState extends State<AdminStock1> {
  List<Map<String, dynamic>> kategoriList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchKategori();
  }

  Future<void> fetchKategori() async {
    kategoriList = await SupabaseService().getAllKategori();
    setState(() {
      isLoading = false;
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 8),
              Center(
                child: Text(
                  'Stock Items',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 16),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: kategoriList.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final kategori = entry.value;
                        // Daftar warna berbeda untuk box
                        final boxColors = [
                          Colors.orange[100],
                          Colors.teal[100],
                          Colors.purple[100],
                          Colors.blue[100],
                          Colors.green[100],
                          Colors.red[100],
                          Colors.yellow[100],
                        ];
                        final color = boxColors[idx % boxColors.length];
                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: kategori['gambar_kategori'] != null
                                    ? Image.network(
                                        kategori['gambar_kategori'],
                                        fit: BoxFit.contain,
                                      )
                                    : Icon(Icons.image_not_supported, size: 32),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  kategori['nama_kategori'] ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward, color: Colors.teal),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminStock2(kategori: kategori),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}