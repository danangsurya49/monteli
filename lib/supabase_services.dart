import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart'; // Untuk akses `supabase` client

class SupabaseService {
  // --- KATEGORI ---

  // Ambil semua kategori
  Future<List<Map<String, dynamic>>> getAllKategori() async {
    final data = await supabase.from('kategori').select();
    return List<Map<String, dynamic>>.from(data);
  }

  // Tambah kategori baru
  Future<void> addKategori({
    required String kategori,
    String? gambarKategori,
  }) async {
    await supabase.from('kategori').insert({
      'kategori': kategori,
      'gambar_kategori': gambarKategori,
    });
  }

  // Update kategori
  Future<void> updateKategori({
    required int idKategori,
    required String kategori,
    String? gambarKategori,
  }) async {
    await supabase.from('kategori').update({
      'kategori': kategori,
      'gambar_kategori': gambarKategori,
    }).eq('id_kategori', idKategori);
  }

  // Hapus kategori
  Future<void> deleteKategori(int idKategori) async {
    await supabase.from('kategori').delete().eq('id_kategori', idKategori);
  }

  // --- KATEGORI MINUMAN ---

  // Ambil semua minuman (atau filter by kategori)
  Future<List<Map<String, dynamic>>> getAllMinuman({int? idKategori}) async {
    var query = supabase.from('kategori_minuman').select();
    if (idKategori != null) {
      query = query.eq('id_kategori', idKategori);
    }
    final data = await query;
    return List<Map<String, dynamic>>.from(data);
  }

  // Tambah minuman baru
  Future<void> addMinuman({
    required String namaMinuman,
    required int stok,
    required num harga,
    String? gambar,
    required int idKategori,
  }) async {
    await supabase.from('kategori_minuman').insert({
      'nama_minuman': namaMinuman,
      'stok': stok,
      'harga': harga,
      'gambar': gambar,
      'id_kategori': idKategori,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  // Update minuman
  Future<void> updateMinuman({
    required int idMinuman,
    required String namaMinuman,
    required int stok,
    required num harga,
    String? gambar,
    required int idKategori,
  }) async {
    await supabase.from('kategori_minuman').update({
      'nama_minuman': namaMinuman,
      'stok': stok,
      'harga': harga,
      'gambar': gambar,
      'id_kategori': idKategori,
    }).eq('id_minuman', idMinuman);
  }

  // Hapus minuman
  Future<void> deleteMinuman(int idMinuman) async {
    await supabase.from('kategori_minuman').delete().eq('id_minuman', idMinuman);
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
}