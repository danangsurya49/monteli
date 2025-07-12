import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart'; // akses global supabase client

class SupabaseService {
  // --- KATEGORI ---
  Future<List<Map<String, dynamic>>> getAllKategori() async {
    final data = await supabase.from('kategori').select();
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> addKategori({
    required String namaKategori,
    String? gambarKategori,
  }) async {
    await supabase.from('kategori').insert({
      'nama_kategori': namaKategori,
      'gambar_kategori': gambarKategori,
    });
  }

  Future<void> updateKategori({
    required String idKategori,
    required String namaKategori,
    String? gambarKategori,
  }) async {
    await supabase.from('kategori').update({
      'nama_kategori': namaKategori,
      'gambar_kategori': gambarKategori,
    }).eq('id_kategori', idKategori);
  }

  Future<void> deleteKategori(String idKategori) async {
    await supabase.from('kategori').delete().eq('id_kategori', idKategori);
  }

  // --- MINUMAN ---
  Future<List<Map<String, dynamic>>> getAllMinuman({String? idKategori}) async {
    var query = supabase.from('minuman').select();
    if (idKategori != null) {
      query = query.eq('id_kategori', idKategori);
    }
    final data = await query;
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> addMinuman({
    required String namaMinuman,
    required String idKategori,
    String? deskripsiBarang,
    String? gambarBarang,
    required int stok,
    required int barangTerjual,
    required num hargaJual,
    required num totalPenjualan,
  }) async {
    await supabase.from('minuman').insert({
      'nama_minuman': namaMinuman,
      'id_kategori': idKategori,
      'deskripsi_barang': deskripsiBarang,
      'gambar_barang': gambarBarang,
      'stok': stok,
      'barang_terjual': barangTerjual,
      'harga_jual': hargaJual,
      'total_penjualan': totalPenjualan,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateMinuman({
    required String idMinuman,
    required String namaMinuman,
    required String idKategori,
    String? deskripsiBarang,
    String? gambarBarang,
    required int stok,
    required int barangTerjual,
    required num hargaJual,
    required num totalPenjualan,
  }) async {
    await supabase.from('minuman').update({
      'nama_minuman': namaMinuman,
      'id_kategori': idKategori,
      'deskripsi_barang': deskripsiBarang,
      'gambar_barang': gambarBarang,
      'stok': stok,
      'barang_terjual': barangTerjual,
      'harga_jual': hargaJual,
      'total_penjualan': totalPenjualan,
    }).eq('id_minuman', idMinuman);
  }

  Future<void> deleteMinuman(String idMinuman) async {
    await supabase.from('minuman').delete().eq('id_minuman', idMinuman);
  }

  // --- MAKANAN ---
  Future<List<Map<String, dynamic>>> getAllMakanan({String? idKategori}) async {
    var query = supabase.from('makanan').select();
    if (idKategori != null) {
      query = query.eq('id_kategori', idKategori);
    }
    final data = await query;
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> addMakanan({
    required String namaMakanan,
    required String idKategori,
    String? deskripsiBarang,
    String? gambarBarang,
    required int stok,
    required int barangTerjual,
    required num hargaJual,
    required num totalPenjualan,
  }) async {
    await supabase.from('makanan').insert({
      'nama_makanan': namaMakanan,
      'id_kategori': idKategori,
      'deskripsi_barang': deskripsiBarang,
      'gambar_barang': gambarBarang,
      'stok': stok,
      'barang_terjual': barangTerjual,
      'harga_jual': hargaJual,
      'total_penjualan': totalPenjualan,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateMakanan({
    required String idMakanan,
    required String namaMakanan,
    required String idKategori,
    String? deskripsiBarang,
    String? gambarBarang,
    required int stok,
    required int barangTerjual,
    required num hargaJual,
    required num totalPenjualan,
  }) async {
    await supabase.from('makanan').update({
      'nama_makanan': namaMakanan,
      'id_kategori': idKategori,
      'deskripsi_barang': deskripsiBarang,
      'gambar_barang': gambarBarang,
      'stok': stok,
      'barang_terjual': barangTerjual,
      'harga_jual': hargaJual,
      'total_penjualan': totalPenjualan,
    }).eq('id_makanan', idMakanan);
  }

  Future<void> deleteMakanan(String idMakanan) async {
    await supabase.from('makanan').delete().eq('id_makanan', idMakanan);
  }

  // --- ROTI ---
  Future<List<Map<String, dynamic>>> getAllRoti({String? idKategori}) async {
    var query = supabase.from('roti').select();
    if (idKategori != null) {
      query = query.eq('id_kategori', idKategori);
    }
    final data = await query;
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> addRoti({
    required String namaRoti,
    required String idKategori,
    String? deskripsiBarang,
    String? gambarBarang,
    required int stok,
    required int barangTerjual,
    required num hargaJual,
    required num totalPenjualan,
  }) async {
    await supabase.from('roti').insert({
      'nama_roti': namaRoti,
      'id_kategori': idKategori,
      'deskripsi_barang': deskripsiBarang,
      'gambar_barang': gambarBarang,
      'stok': stok,
      'barang_terjual': barangTerjual,
      'harga_jual': hargaJual,
      'total_penjualan': totalPenjualan,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateRoti({
    required String idRoti,
    required String namaRoti,
    required String idKategori,
    String? deskripsiBarang,
    String? gambarBarang,
    required int stok,
    required int barangTerjual,
    required num hargaJual,
    required num totalPenjualan,
  }) async {
    await supabase.from('roti').update({
      'nama_roti': namaRoti,
      'id_kategori': idKategori,
      'deskripsi_barang': deskripsiBarang,
      'gambar_barang': gambarBarang,
      'stok': stok,
      'barang_terjual': barangTerjual,
      'harga_jual': hargaJual,
      'total_penjualan': totalPenjualan,
    }).eq('id_roti', idRoti);
  }

  Future<void> deleteRoti(String idRoti) async {
    await supabase.from('roti').delete().eq('id_roti', idRoti);
  }

  // --- MAINAN ---
  Future<List<Map<String, dynamic>>> getAllMainan({String? idKategori}) async {
    var query = supabase.from('mainan').select();
    if (idKategori != null) {
      query = query.eq('id_kategori', idKategori);
    }
    final data = await query;
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> addMainan({
    required String namaMainan,
    required String idKategori,
    String? deskripsiBarang,
    String? gambarBarang,
    required int stok,
    required int barangTerjual,
    required num hargaJual,
    required num totalPenjualan,
  }) async {
    await supabase.from('mainan').insert({
      'nama_mainan': namaMainan,
      'id_kategori': idKategori,
      'deskripsi_barang': deskripsiBarang,
      'gambar_barang': gambarBarang,
      'stok': stok,
      'barang_terjual': barangTerjual,
      'harga_jual': hargaJual,
      'total_penjualan': totalPenjualan,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateMainan({
    required String idMainan,
    required String namaMainan,
    required String idKategori,
    String? deskripsiBarang,
    String? gambarBarang,
    required int stok,
    required int barangTerjual,
    required num hargaJual,
    required num totalPenjualan,
  }) async {
    await supabase.from('mainan').update({
      'nama_mainan': namaMainan,
      'id_kategori': idKategori,
      'deskripsi_barang': deskripsiBarang,
      'gambar_barang': gambarBarang,
      'stok': stok,
      'barang_terjual': barangTerjual,
      'harga_jual': hargaJual,
      'total_penjualan': totalPenjualan,
    }).eq('id_mainan', idMainan);
  }

  Future<void> deleteMainan(String idMainan) async {
    await supabase.from('mainan').delete().eq('id_mainan', idMainan);
  }

  // --- RUMAH TANGGA ---
  Future<List<Map<String, dynamic>>> getAllRumahtangga({String? idKategori}) async {
    var query = supabase.from('rumahtangga').select();
    if (idKategori != null) {
      query = query.eq('id_kategori', idKategori);
    }
    final data = await query;
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> addRumahtangga({
    required String namaBarang,
    required String idKategori,
    String? deskripsiBarang,
    String? gambarBarang,
    required int stok,
    required int barangTerjual,
    required num hargaJual,
    required num totalPenjualan,
  }) async {
    await supabase.from('rumahtangga').insert({
      'nama_barang': namaBarang,
      'id_kategori': idKategori,
      'deskripsi_barang': deskripsiBarang,
      'gambar_barang': gambarBarang,
      'stok': stok,
      'barang_terjual': barangTerjual,
      'harga_jual': hargaJual,
      'total_penjualan': totalPenjualan,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateRumahtangga({
    required String idRumahtangga,
    required String namaBarang,
    required String idKategori,
    String? deskripsiBarang,
    String? gambarBarang,
    required int stok,
    required int barangTerjual,
    required num hargaJual,
    required num totalPenjualan,
  }) async {
    await supabase.from('rumahtangga').update({
      'nama_barang': namaBarang,
      'id_kategori': idKategori,
      'deskripsi_barang': deskripsiBarang,
      'gambar_barang': gambarBarang,
      'stok': stok,
      'barang_terjual': barangTerjual,
      'harga_jual': hargaJual,
      'total_penjualan': totalPenjualan,
    }).eq('id_rumahtangga', idRumahtangga);
  }

  Future<void> deleteRumahtangga(String idRumahtangga) async {
    await supabase.from('rumahtangga').delete().eq('id_rumahtangga', idRumahtangga);
  }

  // --- TRANSAKSI PENJUALAN ---
  Future<List<Map<String, dynamic>>> getAllTransaksiPenjualan() async {
    final data = await supabase.from('transaksi_penjualan').select();
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> addTransaksiPenjualan({
    required String idKategori,
    required String namaTabel,
    required String idProduk,
    required int jumlahTerjual,
    DateTime? waktuTransaksi,
  }) async {
    await supabase.from('transaksi_penjualan').insert({
      'id_kategori': idKategori,
      'nama_tabel': namaTabel,
      'id_produk': idProduk,
      'jumlah_terjual': jumlahTerjual,
      'waktu_transaksi': (waktuTransaksi ?? DateTime.now()).toIso8601String(),
    });
  }

  Future<void> insertTransaksiPenjualan({
    required String userId,
    required String email,
    required String idKategori,
    required String namaKategori,
    required String idBarang,
    required String namaBarang,
    required String alamat,
    required String service,
    required String paymentMethod,
    required int jumlah,
    required num totalHarga,
    required String noTelp,
  }) async {
    await supabase.from('transaksi_penjualan').insert({
      'user_id': userId,
      'email': email,
      'id_kategori': idKategori,
      'nama_kategori': namaKategori,
      'id_barang': idBarang,
      'nama_barang': namaBarang,
      'alamat': alamat,
      'service': service,
      'payment_method': paymentMethod,
      'jumlah': jumlah,
      'total harga': totalHarga,
      'no_telp': noTelp,
    });
  }

  // --- VIEW PENJUALAN PER KATEGORI ---
  Future<List<Map<String, dynamic>>> getPenjualanPerKategori() async {
    final data = await supabase.from('penjualan_per_kategori').select();
    return List<Map<String, dynamic>>.from(data);
  }

  // --- UPLOAD GAMBAR (opsional, jika pakai Supabase Storage) ---
  Future<String> uploadImage(
      File file, String bucketName, String fileName) async {
    final bytes = await file.readAsBytes();
    await supabase.storage.from(bucketName).uploadBinary(
          fileName,
          bytes,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
    final String publicUrl =
        supabase.storage.from(bucketName).getPublicUrl(fileName);
    return publicUrl;
  }

  Future<String> uploadImageBytes(
      Uint8List bytes, String bucketName, String fileName) async {
    await supabase.storage.from(bucketName).uploadBinary(
          fileName,
          bytes,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
    final String publicUrl =
        supabase.storage.from(bucketName).getPublicUrl(fileName);
    return publicUrl;
  }

  Future<num> getTotalPenjualanKeseluruhan() async {
    final data = await supabase.from('total_penjualan_keseluruhan').select().single();
    return data['total_penghasilan'] ?? 0;
  }

  Future<String?> registerUser({
    required String email,
    required String password,
    required String username,
    DateTime? tanggalLahir,
  }) async {
    try {
      // 1. Register ke Supabase Auth dengan auto-confirm
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: null, // Tidak ada redirect
        data: {
          'username': username,
          'tanggal_lahir': tanggalLahir?.toIso8601String(),
        },
      );
      
      final user = response.user;
      if (user == null) {
        return 'Registrasi gagal: user null';
      }

      // 2. Insert data tambahan ke tabel user_registrasi
      await Supabase.instance.client.from('user_registrasi').insert({
        'user_id': user.id, // gunakan id dari Supabase Auth
        'email': email,
        'username': username,
        'tanggal_lahir': tanggalLahir?.toIso8601String(),
      });

      return null; // sukses
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        // Duplicate key (username/email sudah ada)
        return 'Username atau email sudah digunakan!';
      }
      return 'Registrasi gagal: ${e.message}';
    } catch (e) {
      return 'Registrasi gagal: $e';
    }
  }

  // Fungsi baru untuk auto-login setelah registrasi
  Future<Map<String, dynamic>?> registerAndLogin({
    required String email,
    required String password,
    required String username,
    DateTime? tanggalLahir,
  }) async {
    try {
      // 1. Register ke Supabase Auth dengan auto-confirm
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: null, // Tidak ada redirect
        data: {
          'username': username,
          'tanggal_lahir': tanggalLahir?.toIso8601String(),
        },
      );
      
      final user = response.user;
      if (user == null) {
        return null; // registrasi gagal
      }

      // 2. Insert data tambahan ke tabel user_registrasi
      await Supabase.instance.client.from('user_registrasi').insert({
        'user_id': user.id,
        'email': email,
        'username': username,
        'tanggal_lahir': tanggalLahir?.toIso8601String(),
      });

      // 3. Langsung login setelah registrasi
      final loginResponse = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (loginResponse.user != null) {
        // Ambil data user tambahan
        final userData = await Supabase.instance.client
            .from('user_registrasi')
            .select()
            .eq('email', email)
            .maybeSingle();

        return userData;
      }

      return null;
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        // Duplicate key (username/email sudah ada)
        return null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Login ke Supabase Auth
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        return null; // login gagal
      }

      // 2. Ambil data user tambahan dari tabel user_registrasi
      final userData = await Supabase.instance.client
          .from('user_registrasi')
          .select()
          .eq('email', email)
          .maybeSingle();

      return userData; // bisa null jika tidak ada
    } catch (e) {
      // Tangani error login
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllProduk() async {
    try {
      // Tambahkan timeout untuk mencegah hang
      final minuman = await supabase.from('minuman').select().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Timeout mengambil data minuman');
        },
      );
      
      final makanan = await supabase.from('makanan').select().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Timeout mengambil data makanan');
        },
      );
      
      final mainan = await supabase.from('mainan').select().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Timeout mengambil data mainan');
        },
      );
      
      final roti = await supabase.from('roti').select().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Timeout mengambil data roti');
        },
      );
      
      final rumahtangga = await supabase.from('rumahtangga').select().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Timeout mengambil data rumahtangga');
        },
      );

      List<Map<String, dynamic>> produk = [];

      produk.addAll(List<Map<String, dynamic>>.from(minuman).map((e) => {
        'id_minuman': e['id_minuman'],
        'id_kategori': e['id_kategori'],
        'nama_kategori': e['nama_kategori'],
        'name': e['nama_minuman'],
        'sub_title': '',
        'price': 'Rp ${e['harga_jual'] ?? 0}',
        'image': e['gambar_barang'] ?? '',
        'category': 'Drinks',
        'description_points': [e['deskripsi_barang'] ?? ''],
      }));

      produk.addAll(List<Map<String, dynamic>>.from(makanan).map((e) => {
        'id_makanan': e['id_makanan'],
        'id_kategori': e['id_kategori'],
        'nama_kategori': e['nama_kategori'],
        'name': e['nama_makanan'],
        'sub_title': '',
        'price': 'Rp ${e['harga_jual'] ?? 0}',
        'image': e['gambar_barang'] ?? '',
        'category': 'snacks', // Pastikan ini 'snacks' jika ingin tampil di tab snack
        'description_points': [e['deskripsi_barang'] ?? ''],
      }));

      produk.addAll(List<Map<String, dynamic>>.from(mainan).map((e) => {
        'id_mainan': e['id_mainan'],
        'id_kategori': e['id_kategori'],
        'nama_kategori': e['nama_kategori'],
        'name': e['nama_mainan'],
        'sub_title': '',
        'price': 'Rp ${e['harga_jual'] ?? 0}',
        'image': e['gambar_barang'] ?? '',
        'category': 'toys',
        'description_points': [e['deskripsi_barang'] ?? ''],
      }));

      produk.addAll(List<Map<String, dynamic>>.from(roti).map((e) => {
        'id_roti': e['id_roti'],
        'id_kategori': e['id_kategori'],
        'nama_kategori': e['nama_kategori'],
        'name': e['nama_roti'],
        'sub_title': '',
        'price': 'Rp ${e['harga_jual'] ?? 0}',
        'image': e['gambar_barang'] ?? '',
        'category': 'bread & cakes',
        'description_points': [e['deskripsi_barang'] ?? ''],
      }));

      produk.addAll(List<Map<String, dynamic>>.from(rumahtangga).map((e) => {
        'id_rumahtangga': e['id_rumahtangga'],
        'id_kategori': e['id_kategori'],
        'nama_kategori': e['nama_kategori'],
        'name': e['nama_barang'],
        'sub_title': '',
        'price': 'Rp ${e['harga_jual'] ?? 0}',
        'image': e['gambar_barang'] ?? '',
        'category': 'toiletries',
        'description_points': [e['deskripsi_barang'] ?? ''],
      }));

      return produk;
    } on TimeoutException catch (e) {
      print('Timeout error in getAllProduk: $e');
      rethrow;
    } catch (e) {
      print('Error in getAllProduk: $e');
      rethrow;
    }
  }
}