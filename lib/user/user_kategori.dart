import 'package:flutter/material.dart';
import 'package:montelimart/supabase_services.dart';
import 'package:montelimart/user/user_kategori2.dart';

class kategoriscreen extends StatefulWidget {
  const kategoriscreen({super.key});

  @override
  State<kategoriscreen> createState() => _kategoriscreenState();
}

class _kategoriscreenState extends State<kategoriscreen> {
  List<Map<String, dynamic>> kategoriList = [];
  bool isLoading = true;
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        // Already on Category
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/payment');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

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
    final boxColors = [
      Colors.orange[100],
      Colors.teal[100],
      Colors.purple[100],
      Colors.blue[100],
      Colors.green[100],
      Colors.red[100],
      Colors.yellow[100],
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please select one ...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: kategoriList.length,
                      itemBuilder: (context, idx) {
                        final kategori = kategoriList[idx];
                        final color = boxColors[idx % boxColors.length];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
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
                                child: kategori['gambar_kategori'] != null &&
                                        kategori['gambar_kategori'].toString().isNotEmpty
                                    ? Image.network(
                                        kategori['gambar_kategori'],
                                        fit: BoxFit.contain,
                                      )
                                    : const Icon(Icons.image_not_supported, size: 32),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  kategori['nama_kategori'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward, color: Colors.teal),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserKategori2(kategori: kategori),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar removed
    );
  }
}
