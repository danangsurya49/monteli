import 'package:flutter/material.dart';
import 'package:montelimart/user/user_edit_profil.dart';

class UserProfil extends StatefulWidget {
  const UserProfil({super.key});

  @override
  State<UserProfil> createState() => _UserProfilState();
}

class _UserProfilState extends State<UserProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(
              'assets/logo.png',
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/cat.jpg',
              ), // Ganti dengan foto profil user
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage(
                'assets/cat.jpg',
              ), // Ganti dengan foto profil user
            ),
            const SizedBox(height: 12),
            Text(
              'Username',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'youremail@gmail.com',
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(180, 40),
              ),
              child: const Text('Edit your account'),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.error_outline, color: Colors.red, size: 18),
                SizedBox(width: 4),
                Text(
                  'Please complete your profile',
                  style: TextStyle(color: Colors.red),
                ),
              ],
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
                        children: const [
                          Text(
                            'Number of orders',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '0',
                            style: TextStyle(
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
                        children: const [
                          Text(
                            'Sales figures',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Rp. 0.0',
                            style: TextStyle(
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
            ListTile(
              leading: Icon(Icons.language, color: Color(0xFF1A3C40)),
              title: Text('Application language'),
              trailing: Icon(Icons.check_circle, color: Color(0xFF1A3C40)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.brightness_6, color: Color(0xFF1A3C40)),
              title: Text('Change appearance'),
              trailing: Icon(Icons.check_circle, color: Color(0xFF1A3C40)),
              onTap: () {},
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFF1A3C40),
                  side: BorderSide(color: Color(0xFF1A3C40)),
                  minimumSize: Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Delete account'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      // Hapus BottomNavigationBar di sini agar tidak double jika parent sudah punya navigation
      // Jika ingin tetap ada, pastikan hanya satu yang aktif di seluruh aplikasi
      // Untuk web, biasanya navigation bar diatur di parent/home
      // Jadi, hapus baris berikut:
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 3,
      //   selectedItemColor: Color(0xFF1A3C40),
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.category),
      //       label: 'Category',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payment'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      //   ],
      // ),
    );
  }
}
