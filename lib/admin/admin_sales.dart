import 'package:flutter/material.dart';
import 'package:montelimart/admin/admin_stock1.dart';
import 'package:montelimart/admin/admin_home.dart';
import 'package:montelimart/supabase_services.dart';

class AdminSales extends StatefulWidget {
  const AdminSales({super.key});

  @override
  State<AdminSales> createState() => _AdminSalesState();
}

class _AdminSalesState extends State<AdminSales> {
  List<Map<String, dynamic>> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    data = await SupabaseService().getPenjualanPerKategori();
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.teal, // warna sama seperti box "Total Sales" di home
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Data Penjualan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            dataRowMinHeight: 28,
                            dataRowMaxHeight: 28,
                            columns: const [
                              DataColumn(label: Text('Kategori', style: TextStyle(fontSize: 11))),
                              DataColumn(label: Text('Stok', style: TextStyle(fontSize: 11)), numeric: true),
                              DataColumn(label: Text('Terjual', style: TextStyle(fontSize: 11)), numeric: true),
                              DataColumn(label: Text('Pendapatan', style: TextStyle(fontSize: 11)), numeric: true),
                            ],
                            rows: data
                                .map(
                                  (item) => DataRow(cells: [
                                    DataCell(Text(item['nama_kategori'] ?? '', style: TextStyle(fontSize: 11))),
                                    DataCell(Text(item['total_stok'].toString(), style: TextStyle(fontSize: 11))),
                                    DataCell(Text(item['total_terjual'].toString(), style: TextStyle(fontSize: 11))),
                                    DataCell(Text('Rp ${item['total_penghasilan']}', style: TextStyle(fontSize: 11))),
                                  ]),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),  
    );
  }
}