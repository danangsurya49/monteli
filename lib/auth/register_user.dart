import 'package:flutter/material.dart';
import 'package:montelimart/auth/login_user.dart';
import 'package:montelimart/supabase_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime? _selectedDate;
  bool _isLoading = false;

  Future<String?> registerUser({
    required String email,
    required String password,
    required String username,
    DateTime? tanggalLahir,
  }) async {
    try {
      // 1. Register ke Supabase Auth
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
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

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final error = await registerUser(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      username: _usernameController.text.trim(),
      tanggalLahir: _selectedDate,
    );
    if (error == null) {
      // Registrasi sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registrasi berhasil! Silakan login.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginUser()),
      );
    } else {
      // Tampilkan error ke user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registrasi gagal: $error')),
      );
    }
    setState(() => _isLoading = false);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 17, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 24),
                  Image.asset(
                    'assets/Montelli_Family_Logo.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'MontelliMart',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Create your account",
                    style: TextStyle(
                      color: Colors.blueGrey[300],
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 32),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Username wajib diisi' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (val) =>
                        val == null || !val.contains('@') ? 'Email tidak valid' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (val) =>
                        val == null || val.length < 6 ? 'Password minimal 6 karakter' : null,
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: _pickDate,
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: _selectedDate == null
                              ? 'Tanggal Lahir'
                              : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        validator: (val) =>
                            _selectedDate == null ? 'Tanggal lahir wajib diisi' : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _isLoading ? null : _register,
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Register',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginUser()),
                          );
                        },
                        child: Text(
                          'Login here',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}