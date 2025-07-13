import 'package:flutter/material.dart';
import 'package:montelimart/user/user_edit_profil.dart';
import 'package:montelimart/supabase_services.dart';
import 'package:get_storage/get_storage.dart';

class UserProfil extends StatefulWidget {
  const UserProfil({super.key});

  @override
  State<UserProfil> createState() => _UserProfilState();
}

class _UserProfilState extends State<UserProfil> {
  Map<String, dynamic>? userData;
  String? avatarUrl;
  int cartItemCount = 0;
  num cartTotalPrice = 0;
  final box = GetStorage();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    setState(() { isLoading = true; });
    final user = await getUserProfile();
    final cart = getCartSummary(box);
    setState(() {
      userData = user;
      avatarUrl = user?['avatar'];
      cartItemCount = cart['totalItems'] ?? 0;
      cartTotalPrice = cart['totalPrice'] ?? 0;
      isLoading = false;
    });
  }

  void _logout() async {
    await logoutUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Image.asset('assets/Montelli_Family_Logo.png'),
        // ),
      ),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                CircleAvatar(
                  radius: 48,
                  backgroundImage: (avatarUrl != null && avatarUrl!.isNotEmpty)
                    ? NetworkImage(avatarUrl!)
                    : const AssetImage('assets/Montelli_Family_Logo.png') as ImageProvider,
                ),
                const SizedBox(height: 12),
                Text(
                  userData?['username'] ?? 'Username',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  userData?['email'] ?? 'youremail@gmail.com',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserEditProfil(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2CB9B0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(180, 40),
                  ),
                  child: const Text('Edit your account'),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFF2CB9B0),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Number of orders',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$cartItemCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFA96B),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Total item',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Rp ${cartTotalPrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: OutlinedButton(
                    onPressed: _logout,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color(0xFF1A3C40),
                      side: BorderSide(color: Color(0xFF1A3C40)),
                      minimumSize: Size(double.infinity, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Ganti akun'),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
    );
  }
}