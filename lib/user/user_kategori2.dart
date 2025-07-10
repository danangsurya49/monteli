import 'package:flutter/material.dart';
import 'package:montelimart/supabase_services.dart';
import 'package:montelimart/user/user_detail_produk.dart';

class UserKategori2 extends StatefulWidget {
  final Map<String, dynamic> kategori;
  const UserKategori2({super.key, required this.kategori});

  @override
  State<UserKategori2> createState() => _UserKategori2State();
}

class _UserKategori2State extends State<UserKategori2> {
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;
  String kategoriTable = '';
  String kategoriId = '';
  String kategoriNama = '';
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    kategoriId = widget.kategori['id_kategori'] ?? '';
    kategoriNama = widget.kategori['nama_kategori'] ?? '';
    kategoriTable = _getTableName(kategoriNama);
    fetchItems();
  }

  String _getTableName(String namaKategori) {
    final lower = namaKategori.toLowerCase();
    if (lower.contains('minuman')) return 'minuman';
    if (lower.contains('makanan')) return 'makanan';
    if (lower.contains('mainan')) return 'mainan';
    if (lower.contains('roti')) return 'roti';
    if (lower.contains('rumah')) return 'rumahtangga';
    return 'minuman';
  }

  Future<void> fetchItems() async {
    setState(() => isLoading = true);
    switch (kategoriTable) {
      case 'minuman':
        items = await SupabaseService().getAllMinuman(idKategori: kategoriId);
        break;
      case 'makanan':
        items = await SupabaseService().getAllMakanan(idKategori: kategoriId);
        break;
      case 'mainan':
        items = await SupabaseService().getAllMainan(idKategori: kategoriId);
        break;
      case 'roti':
        items = await SupabaseService().getAllRoti(idKategori: kategoriId);
        break;
      case 'rumahtangga':
        items = await SupabaseService().getAllRumahtangga(idKategori: kategoriId);
        break;
      default:
        items = [];
    }
    setState(() => isLoading = false);
  }

  final List<Color?> cardColors = [
    Color(0xFFE6F7FF),
    Color(0xFFFFF9E6),
    Color(0xFFF3E6FF),
    Color(0xFFFFE6F0),
    Color(0xFFE6FFF2),
    Color(0xFFFFF3E6),
    Color(0xFFE6F0FF),
    Color(0xFFFFE6E6),
  ];

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          kategoriNama,
          style: const TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.blueGrey),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : items.isEmpty
              ? const Center(child: Text('Tidak ada produk pada kategori ini.'))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, idx) {
                    final item = items[idx];
                    final color = cardColors[idx % cardColors.length] ?? Colors.white;
                    final nama = item['nama_minuman'] ??
                        item['nama_makanan'] ??
                        item['nama_mainan'] ??
                        item['nama_roti'] ??
                        item['nama_barang'] ??
                        '';
                    final harga = item['harga_jual'] ?? 0;
                    final gambar = item['gambar_barang'];

                    return GestureDetector(
                      onTap: () {
                        final mapped = {
                          'name': item['nama_minuman'] ?? item['nama_makanan'] ?? item['nama_mainan'] ?? item['nama_roti'] ?? item['nama_barang'] ?? '',
                          'image': item['gambar_barang'] ?? '',
                          'price': 'Rp ${item['harga_jual'] ?? 0}',
                          'description_points': (item['deskripsi_barang'] != null) ? [item['deskripsi_barang']] : [],
                          'sub_title': '', // bisa diisi jika ada field lain
                        };
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => user_detail_produkscreen(product: mapped),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: gambar != null && gambar.toString().isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          gambar,
                                          fit: BoxFit.contain,
                                          errorBuilder: (c, e, s) => const Icon(Icons.image, size: 48, color: Colors.grey),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Icon(Icons.image, size: 48, color: Colors.grey),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                nama,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                              child: Row(
                                children: [
                                  Text(
                                    'Rp ${harga.toString()}',
                                    style: const TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                                      onPressed: () {
                                        // TODO: Tambahkan ke keranjang
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      // bottomNavigationBar removed
    );
  }
}