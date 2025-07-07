import 'package:flutter/material.dart';
import 'package:montelimart/supabase_services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminStock2 extends StatefulWidget {
  final Map<String, dynamic>? kategori;
  const AdminStock2({super.key, this.kategori});

  @override
  State<AdminStock2> createState() => _AdminStock2State();
}

class _AdminStock2State extends State<AdminStock2> {
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;
  String kategoriTable = '';
  String kategoriId = '';
  String kategoriNama = '';

  @override
  void initState() {
    super.initState();
    kategoriId = widget.kategori?['id_kategori'] ?? '';
    kategoriNama = widget.kategori?['nama_kategori'] ?? '';
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

  Future<void> saveAll() async {
    setState(() => isLoading = true);
    for (final item in items) {
      switch (kategoriTable) {
        case 'minuman':
          await SupabaseService().updateMinuman(
            idMinuman: item['id_minuman'],
            namaMinuman: item['nama_minuman'],
            idKategori: item['id_kategori'],
            deskripsiBarang: item['deskripsi_barang'],
            gambarBarang: item['gambar_barang'],
            stok: int.tryParse(item['stok'].toString()) ?? 0,
            barangTerjual: item['barang_terjual'] ?? 0,
            hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
            totalPenjualan: item['total_penjualan'] ?? 0,
          );
          break;
        case 'makanan':
          await SupabaseService().updateMakanan(
            idMakanan: item['id_makanan'],
            namaMakanan: item['nama_makanan'],
            idKategori: item['id_kategori'],
            deskripsiBarang: item['deskripsi_barang'],
            gambarBarang: item['gambar_barang'],
            stok: int.tryParse(item['stok'].toString()) ?? 0,
            barangTerjual: item['barang_terjual'] ?? 0,
            hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
            totalPenjualan: item['total_penjualan'] ?? 0,
          );
          break;
        case 'mainan':
          await SupabaseService().updateMainan(
            idMainan: item['id_mainan'],
            namaMainan: item['nama_mainan'],
            idKategori: item['id_kategori'],
            deskripsiBarang: item['deskripsi_barang'],
            gambarBarang: item['gambar_barang'],
            stok: int.tryParse(item['stok'].toString()) ?? 0,
            barangTerjual: item['barang_terjual'] ?? 0,
            hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
            totalPenjualan: item['total_penjualan'] ?? 0,
          );
          break;
        case 'roti':
          await SupabaseService().updateRoti(
            idRoti: item['id_roti'],
            namaRoti: item['nama_roti'],
            idKategori: item['id_kategori'],
            deskripsiBarang: item['deskripsi_barang'],
            gambarBarang: item['gambar_barang'],
            stok: int.tryParse(item['stok'].toString()) ?? 0,
            barangTerjual: item['barang_terjual'] ?? 0,
            hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
            totalPenjualan: item['total_penjualan'] ?? 0,
          );
          break;
        case 'rumahtangga':
          await SupabaseService().updateRumahtangga(
            idRumahtangga: item['id_rumahtangga'],
            namaBarang: item['nama_barang'],
            idKategori: item['id_kategori'],
            deskripsiBarang: item['deskripsi_barang'],
            gambarBarang: item['gambar_barang'],
            stok: int.tryParse(item['stok'].toString()) ?? 0,
            barangTerjual: item['barang_terjual'] ?? 0,
            hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
            totalPenjualan: item['total_penjualan'] ?? 0,
          );
          break;
      }
    }
    setState(() => isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Perubahan berhasil disimpan!')),
    );
    Navigator.pop(context);
  }

  Future<void> _pickImage(Map<String, dynamic> item, String fieldName) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${picked.name}';
      final url = await SupabaseService().uploadImage(
        file,
        'gambar-barang', // nama bucket storage di Supabase
        fileName,
      );
      setState(() {
        item[fieldName] = url;
      });
    }
  }

  void _addNewItem() {
    setState(() {
      // Struktur field sesuai kategori
      Map<String, dynamic> newItem;
      switch (kategoriTable) {
        case 'minuman':
          newItem = {
            'id_minuman': null,
            'id_kategori': kategoriId,
            'nama_minuman': '',
            'deskripsi_barang': '',
            'gambar_barang': '',
            'stok': 0,
            'barang_terjual': 0,
            'harga_jual': 0,
            'total_penjualan': 0,
          };
          break;
        case 'makanan':
          newItem = {
            'id_makanan': null,
            'id_kategori': kategoriId,
            'nama_makanan': '',
            'deskripsi_barang': '',
            'gambar_barang': '',
            'stok': 0,
            'barang_terjual': 0,
            'harga_jual': 0,
            'total_penjualan': 0,
          };
          break;
        case 'mainan':
          newItem = {
            'id_mainan': null,
            'id_kategori': kategoriId,
            'nama_mainan': '',
            'deskripsi_barang': '',
            'gambar_barang': '',
            'stok': 0,
            'barang_terjual': 0,
            'harga_jual': 0,
            'total_penjualan': 0,
          };
          break;
        case 'roti':
          newItem = {
            'id_roti': null,
            'id_kategori': kategoriId,
            'nama_roti': '',
            'deskripsi_barang': '',
            'gambar_barang': '',
            'stok': 0,
            'barang_terjual': 0,
            'harga_jual': 0,
            'total_penjualan': 0,
          };
          break;
        case 'rumahtangga':
          newItem = {
            'id_rumahtangga': null,
            'id_kategori': kategoriId,
            'nama_barang': '',
            'deskripsi_barang': '',
            'gambar_barang': '',
            'stok': 0,
            'barang_terjual': 0,
            'harga_jual': 0,
            'total_penjualan': 0,
          };
          break;
        default:
          newItem = {};
      }
      items.insert(0, newItem);
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
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    kategoriNama,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, idx) {
                      final item = items[idx];
                      return _buildEditableItem(item, idx);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: saveAll,
                      child: Text(
                        'Save Changes',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        backgroundColor: Colors.teal,
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Tambah Barang Baru',
      ),
    );
  }

  Widget _buildEditableItem(Map<String, dynamic> item, int idx) {
    final namaController = TextEditingController(
        text: item['nama_minuman'] ??
            item['nama_makanan'] ??
            item['nama_mainan'] ??
            item['nama_roti'] ??
            item['nama_barang'] ??
            '');
    final deskripsiController =
        TextEditingController(text: item['deskripsi_barang'] ?? '');
    final stokController =
        TextEditingController(text: item['stok']?.toString() ?? '0');
    final hargaController =
        TextEditingController(text: item['harga_jual']?.toString() ?? '0');

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey.shade100),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar di atas button
          Center(
            child: Column(
              children: [
                item['gambar_barang'] != null && item['gambar_barang'].toString().isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(item['gambar_barang'], height: 80, width: 80, fit: BoxFit.cover),
                      )
                    : Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.image, size: 40, color: Colors.grey),
                      ),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  icon: Icon(Icons.photo_library),
                  label: Text('Pilih Gambar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[100],
                    foregroundColor: Colors.blueGrey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _pickImage(item, 'gambar_barang'),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onChanged: (val) {
                    item['nama_minuman'] = val;
                    item['nama_makanan'] = val;
                    item['nama_mainan'] = val;
                    item['nama_roti'] = val;
                    item['nama_barang'] = val;
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: stokController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Stok',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onChanged: (val) =>
                      item['stok'] = int.tryParse(val) ?? 0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: deskripsiController,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onChanged: (val) => item['deskripsi_barang'] = val,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Harga Jual',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onChanged: (val) =>
                      item['harga_jual'] = num.tryParse(val) ?? 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}