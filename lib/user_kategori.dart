import 'package:flutter/material.dart';

class kategoriscreen extends StatefulWidget {
  const kategoriscreen({super.key});

  @override
  State<kategoriscreen> createState() => _kategoriscreenState();
}

class _kategoriscreenState extends State<kategoriscreen> {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Beverages',
      'image': 'assets/kategori/Sparkling_Berry_Juice.jpg',
      'color': const Color(0xFFFDE7DF),
    },
    {
      'name': 'Snacks',
      'image': 'assets/kategori/burger.jpg',
      'color': const Color(0xFFD6F5F0),
    },
    {
      'name': 'Breads & Cakes',
      'image': 'assets/kategori/march_7th.jpg',
      'color': const Color(0xFFFFFAD6),
    },
    {
      'name': 'Toys',
      'image': 'assets/kategori/jellyfish_on_the_staircase.png',
      'color': const Color(0xFFF0E0D6),
    },
    {
      'name': 'Toiletries',
      'image': 'assets/kategori/Interastral_Big_Lotto.png',
      'color': const Color(0xFFD3E0E2),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // HAPUS SELURUH WIDGET AppBar DARI SINI!
      // appBar: AppBar(...) // Hapus atau jadikan komentar baris ini
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
      // bottomNavigationBar sudah dihapus sebelumnya
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        print('Kategori ${category['name']} ditekan!');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: category['color'],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Image.asset(
              category['image']!,
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
            const Icon(Icons.arrow_forward, color: Color(0xFF4CAF50), size: 30),
          ],
        ),
      ),
    );
  }
}
