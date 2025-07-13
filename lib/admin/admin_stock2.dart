import 'package:flutter/material.dart';
import 'package:montelimart/supabase_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
    try {
      for (final item in items) {
        switch (kategoriTable) {
          case 'minuman':
            if ((item['nama_minuman'] ?? '').toString().isEmpty) {
              throw Exception('Nama Minuman tidak boleh kosong');
            }
            if ((item['id_barang'] ?? '').toString().isEmpty) {
              // INSERT
              await SupabaseService().addMinuman(
                namaMinuman: item['nama_minuman'] ?? '',
                idKategori: item['id_kategori'] ?? '',
                deskripsiBarang: item['deskripsi_barang'] ?? '',
                gambarBarang: item['gambar_barang'] ?? '',
                stok: int.tryParse(item['stok'].toString()) ?? 0,
                barangTerjual: item['barang_terjual'] ?? 0,
                hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
                totalPenjualan: item['total_penjualan'] ?? 0,
              );
            } else {
              // UPDATE
              await SupabaseService().updateMinuman(
                idBarang: item['id_barang'] ?? '',
                namaMinuman: item['nama_minuman'] ?? '',
                idKategori: item['id_kategori'] ?? '',
                deskripsiBarang: item['deskripsi_barang'] ?? '',
                gambarBarang: item['gambar_barang'] ?? '',
                stok: int.tryParse(item['stok'].toString()) ?? 0,
                barangTerjual: item['barang_terjual'] ?? 0,
                hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
                totalPenjualan: item['total_penjualan'] ?? 0,
              );
            }
            break;
          case 'makanan':
            if ((item['nama_makanan'] ?? '').toString().isEmpty) {
              throw Exception('Nama Makanan tidak boleh kosong');
            }
            if ((item['id_barang'] ?? '').toString().isEmpty) {
              await SupabaseService().addMakanan(
                namaMakanan: item['nama_makanan'] ?? '',
                idKategori: item['id_kategori'] ?? '',
                deskripsiBarang: item['deskripsi_barang'] ?? '',
                gambarBarang: item['gambar_barang'] ?? '',
                stok: int.tryParse(item['stok'].toString()) ?? 0,
                barangTerjual: item['barang_terjual'] ?? 0,
                hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
                totalPenjualan: item['total_penjualan'] ?? 0,
              );
            } else {
              await SupabaseService().updateMakanan(
                idBarang: item['id_barang'] ?? '',
                namaMakanan: item['nama_makanan'] ?? '',
                idKategori: item['id_kategori'] ?? '',
                deskripsiBarang: item['deskripsi_barang'] ?? '',
                gambarBarang: item['gambar_barang'] ?? '',
                stok: int.tryParse(item['stok'].toString()) ?? 0,
                barangTerjual: item['barang_terjual'] ?? 0,
                hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
                totalPenjualan: item['total_penjualan'] ?? 0,
              );
            }
            break;
          case 'mainan':
            if ((item['nama_mainan'] ?? '').toString().isEmpty) {
              throw Exception('Nama Mainan tidak boleh kosong');
            }
            if ((item['id_barang'] ?? '').toString().isEmpty) {
              await SupabaseService().addMainan(
                namaMainan: item['nama_mainan'] ?? '',
                idKategori: item['id_kategori'] ?? '',
                deskripsiBarang: item['deskripsi_barang'] ?? '',
                gambarBarang: item['gambar_barang'] ?? '',
                stok: int.tryParse(item['stok'].toString()) ?? 0,
                barangTerjual: item['barang_terjual'] ?? 0,
                hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
                totalPenjualan: item['total_penjualan'] ?? 0,
              );
            } else {
              await SupabaseService().updateMainan(
                idBarang: item['id_barang'] ?? '',
                namaMainan: item['nama_mainan'] ?? '',
                idKategori: item['id_kategori'] ?? '',
                deskripsiBarang: item['deskripsi_barang'] ?? '',
                gambarBarang: item['gambar_barang'] ?? '',
                stok: int.tryParse(item['stok'].toString()) ?? 0,
                barangTerjual: item['barang_terjual'] ?? 0,
                hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
                totalPenjualan: item['total_penjualan'] ?? 0,
              );
            }
            break;
          case 'roti':
            if ((item['nama_roti'] ?? '').toString().isEmpty) {
              throw Exception('Nama Roti tidak boleh kosong');
            }
            if ((item['id_barang'] ?? '').toString().isEmpty) {
              await SupabaseService().addRoti(
                namaRoti: item['nama_roti'] ?? '',
                idKategori: item['id_kategori'] ?? '',
                deskripsiBarang: item['deskripsi_barang'] ?? '',
                gambarBarang: item['gambar_barang'] ?? '',
                stok: int.tryParse(item['stok'].toString()) ?? 0,
                barangTerjual: item['barang_terjual'] ?? 0,
                hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
                totalPenjualan: item['total_penjualan'] ?? 0,
              );
            } else {
              await SupabaseService().updateRoti(
                idBarang: item['id_barang'] ?? '',
                namaRoti: item['nama_roti'] ?? '',
                idKategori: item['id_kategori'] ?? '',
                deskripsiBarang: item['deskripsi_barang'] ?? '',
                gambarBarang: item['gambar_barang'] ?? '',
                stok: int.tryParse(item['stok'].toString()) ?? 0,
                barangTerjual: item['barang_terjual'] ?? 0,
                hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
                totalPenjualan: item['total_penjualan'] ?? 0,
              );
            }
            break;
          case 'rumahtangga':
            if ((item['nama_barang'] ?? '').toString().isEmpty) {
              throw Exception('Nama Barang tidak boleh kosong');
            }
            if ((item['id_barang'] ?? '').toString().isEmpty) {
              await SupabaseService().addRumahtangga(
                namaBarang: item['nama_barang'] ?? '',
                idKategori: item['id_kategori'] ?? '',
                deskripsiBarang: item['deskripsi_barang'] ?? '',
                gambarBarang: item['gambar_barang'] ?? '',
                stok: int.tryParse(item['stok'].toString()) ?? 0,
                barangTerjual: item['barang_terjual'] ?? 0,
                hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
                totalPenjualan: item['total_penjualan'] ?? 0,
              );
            } else {
              await SupabaseService().updateRumahtangga(
                idBarang: item['id_barang'] ?? '',
                namaBarang: item['nama_barang'] ?? '',
                idKategori: item['id_kategori'] ?? '',
                deskripsiBarang: item['deskripsi_barang'] ?? '',
                gambarBarang: item['gambar_barang'] ?? '',
                stok: int.tryParse(item['stok'].toString()) ?? 0,
                barangTerjual: item['barang_terjual'] ?? 0,
                hargaJual: num.tryParse(item['harga_jual'].toString()) ?? 0,
                totalPenjualan: item['total_penjualan'] ?? 0,
              );
            }
            break;
        }
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Perubahan berhasil disimpan!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _pickImage(Map<String, dynamic> item, String fieldName) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => isLoading = true); // Tampilkan loading selama upload
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${picked.name}';
      try {
        final url = await SupabaseService()
            .uploadImage(picked, 'gambar-barang', fileName)
            .timeout(const Duration(seconds: 30), onTimeout: () {
          throw Exception('Upload gambar timeout. Cek koneksi internet Anda.');
        });
        setState(() {
          item[fieldName] = '$url?v=${DateTime.now().millisecondsSinceEpoch}';
        });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal upload gambar: $e')),
          );
        }
      } finally {
        if (mounted) setState(() => isLoading = false);
      }
    }
  }

  void _addNewItem() {
    setState(() {
      // Struktur field sesuai kategori
      Map<String, dynamic> newItem;
      switch (kategoriTable) {
        case 'minuman':
          newItem = {
            'id_barang': null,
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
            'id_barang': null,
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
            'id_barang': null,
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
            'id_barang': null,
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
            'id_barang': null,
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
          // Tampilkan id_barang
          Text(
            'ID Barang:  ${item['id_barang'] ?? '-'}',
            style: TextStyle(fontSize: 12, color: Colors.blueGrey),
          ),
          SizedBox(height: 4),
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
                    switch (kategoriTable) {
                      case 'minuman':
                        item['nama_minuman'] = val;
                        break;
                      case 'makanan':
                        item['nama_makanan'] = val;
                        break;
                      case 'mainan':
                        item['nama_mainan'] = val;
                        break;
                      case 'roti':
                        item['nama_roti'] = val;
                        break;
                      case 'rumahtangga':
                        item['nama_barang'] = val;
                        break;
                    }
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