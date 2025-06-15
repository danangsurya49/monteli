import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Beverages',
      'image': 'assets/Sparkling_Berry_Juice.jpg',
      'color': const Color(0xFFFDE7DF),
    },
    {
      'name': 'Snacks',
      'image': 'assets/burger.webp',
      'color': const Color(0xFFD6F5F0),
    },
    {
      'name': 'Breads & Cakes',
      'image': 'assets/march_7th.jpg',
      'color': const Color(0xFFFFFAD6),
    },
    {
      'name': 'Toys',
      'image': 'assets/jellyfish_on_the_staircase.png',
      'color': const Color(0xFFF0E0D6),
    },
    {
      'name': 'Toiletries',
      'image': 'assets/Interastral_Big_Lotto.png',
      'color': const Color(0xFFD3E0E2),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.menu, color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: const Text(
                    '1', // Example: number of items in cart
                    style: TextStyle(color: Colors.white, fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage:
                  Image.network(
                    'https://via.placeholder.com/150', // Replace with actual user image
                  ).image,
            ),
          ),
        ],
      ),
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
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryCard(categories[index]);
                },
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation bar, similar to your main screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payment'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: 1, // Highlight the Category icon
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Ketika tombol di bottom nav bar diklik dari layar kategori:
          if (index == 0) {
            // Jika Home diklik, kembali ke Home Screen
            Navigator.popUntil(context, (route) => route.isFirst);
            // Atau jika main.dart Anda memiliki indeks tertentu untuk Home,
            // Anda bisa menggunakan _onItemTapped(0) jika CategoryScreen
            // tidak menutup dirinya sendiri.
          } else if (index == 1) {
            // Tetap di layar kategori
          } else {
            // Navigasi ke Payment/Profil
            // Anda perlu menentukan bagaimana navigasi antar tab bekerja di aplikasi Anda.
            // Misalnya: Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen()));
          }
        },
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        // TODO: Aksi ketika kartu kategori ditekan (misalnya, navigasi ke daftar produk dalam kategori ini)
        print('Kategori ${category['name']} ditekan!');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: category['color'], // Warna latar belakang dari data kategori
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Image.asset(
              category['image']!, // Menggunakan Image.asset untuk gambar lokal
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                category['name']!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              color: Color(0xFF4CAF50), // Warna hijau untuk panah
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
