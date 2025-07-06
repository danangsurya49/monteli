import 'package:flutter/material.dart';
import 'package:montelimart/admin/admin_stock1.dart';
import 'package:montelimart/admin/admin_home.dart';

class AdminSales extends StatefulWidget {
  const AdminSales({super.key});

  @override
  State<AdminSales> createState() => _AdminSalesState();
}

class _AdminSalesState extends State<AdminSales> {
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
                      rows: const [
                        DataRow(cells: [
                          DataCell(Text('Minuman', style: TextStyle(fontSize: 11))),
                          DataCell(Text('120', style: TextStyle(fontSize: 11))),
                          DataCell(Text('50', style: TextStyle(fontSize: 11))),
                          DataCell(Text('Rp 1.000.000', style: TextStyle(fontSize: 11))),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Makanan', style: TextStyle(fontSize: 11))),
                          DataCell(Text('80', style: TextStyle(fontSize: 11))),
                          DataCell(Text('30', style: TextStyle(fontSize: 11))),
                          DataCell(Text('Rp 500.000', style: TextStyle(fontSize: 11))),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Snack', style: TextStyle(fontSize: 11))),
                          DataCell(Text('200', style: TextStyle(fontSize: 11))),
                          DataCell(Text('75', style: TextStyle(fontSize: 11))),
                          DataCell(Text('Rp 750.000', style: TextStyle(fontSize: 11))),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
        ],
      ),
    );
  }
}