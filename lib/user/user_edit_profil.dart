import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:montelimart/supabase_services.dart';

class UserEditProfil extends StatefulWidget {
  const UserEditProfil({super.key});

  @override
  State<UserEditProfil> createState() => _UserEditProfilState();
}

class _UserEditProfilState extends State<UserEditProfil> {
  final TextEditingController noTelpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  DateTime? tanggalLahir;
  String? username;
  String? email;
  String? avatarUrl;
  File? avatarFile;
  bool isLoading = true;
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() { isLoading = true; });
    final user = await getUserProfile();
    if (user != null) {
      setState(() {
        userId = user['user_id'];
        username = user['username'];
        email = user['email'];
        avatarUrl = user['avatar'];
        noTelpController.text = user['no_telp'] ?? '';
        alamatController.text = user['alamat'] ?? '';
        tanggalLahir = user['tanggal_lahir'] != null && user['tanggal_lahir'].toString().isNotEmpty
          ? DateTime.tryParse(user['tanggal_lahir'])
          : null;
        isLoading = false;
      });
    } else {
      setState(() { isLoading = false; });
    }
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() { avatarFile = File(picked.path); });
    }
  }

  Future<void> _save() async {
    setState(() { isLoading = true; });
    String? uploadedUrl = avatarUrl;
    if (avatarFile != null) {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${avatarFile!.path.split('/').last}';
      uploadedUrl = await SupabaseService().uploadImage(
        avatarFile!,
        'avatars',
        fileName,
      );
    }
    await updateUserRegistrasi(
      userId: userId!,
      avatar: uploadedUrl,
      noTelp: noTelpController.text,
      tanggalLahir: tanggalLahir,
      alamat: alamatController.text,
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Edit account', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: GestureDetector(
                        onTap: _pickAvatar,
                        child: CircleAvatar(
                          radius: 48,
                          backgroundImage: avatarFile != null
                              ? FileImage(avatarFile!)
                              : (avatarUrl != null && avatarUrl!.isNotEmpty)
                                  ? NetworkImage(avatarUrl!)
                                  : const AssetImage('assets/Montelli_Family_Logo.png') as ImageProvider,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(Icons.edit, size: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      controller: TextEditingController(text: username ?? ''),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.email),
                      ),
                      controller: TextEditingController(text: email ?? ''),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: noTelpController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'No. Telp',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: tanggalLahir ?? DateTime(2000, 1, 1),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() { tanggalLahir = picked; });
                        }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          controller: TextEditingController(
                            text: tanggalLahir != null
                                ? "${tanggalLahir!.day}/${tanggalLahir!.month}/${tanggalLahir!.year}"
                                : '',
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Tanggal Lahir',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: alamatController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Alamat',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF22B89A),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: isLoading ? null : _save,
                        child: const Text('Simpan', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}