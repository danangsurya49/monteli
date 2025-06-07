import 'package:flutter/material.dart';

class userdetailprodukscreen extends StatefulWidget {
  final Map<String, dynamic> product; // Untuk menerima data produk

  const userdetailprodukscreen({super.key, required this.product});

  @override
  State<userdetailprodukscreen> createState() => _userdetailprodukscreenState();
}

class _userdetailprodukscreenState extends State<userdetailprodukscreen> {
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Ambil list deskripsi atau kosongkan jika tidak ada
    final List<String> descriptionPoints =
        (widget.product['description_points'] as List<dynamic>?)
                ?.map((item) => item.toString())
                .toList() ??
            [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {
              // Handle shopping cart action
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: Image.network(
                'https://via.placeholder.com/150', // Replace with actual user image
              ).image,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Section (for the product image)
          Positioned.fill(
            child: Container(
              color: Colors.white, // Or a light background color for the image area
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image.network(
                    widget.product['image']!,
                    height: MediaQuery.of(context).size.height * 0.35, // Adjust height as needed
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          // Content Section (product details)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6, // Adjust height as needed
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Color(0xFF282828), // Dark grey background
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product['name']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.product['sub_title'] ??
                                  'Minuman Susu Fermentasi', // Default if not provided
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 18),
                                const Icon(Icons.star, color: Colors.amber, size: 18),
                                const Icon(Icons.star, color: Colors.amber, size: 18),
                                const Icon(Icons.star, color: Colors.amber, size: 18),
                                Icon(Icons.star_half, color: Colors.amber, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  '(100 Reviews)',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          widget.product['price']!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700], // Darker grey for icon background
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                            onPressed: () {
                              // Handle add to cart
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700], // Darker grey for icon background
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.play_arrow, color: Colors.white),
                            onPressed: () {
                              // Handle play action
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle purchase
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF50), // Green for purchase button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),
                            child: const Text(
                              'Purchase',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Menampilkan deskripsi berdasarkan data produk
                    if (descriptionPoints.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: descriptionPoints.map((point) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              '- $point', // Tambahkan bullet point
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    else
                      Text(
                        'No description available for this product.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.white.withOpacity(0.3)),
                    // Bagian "Details Products" yang bisa diperluas
                    // Anda bisa memindahkan detail seperti volume, packaging, producer
                    // ke dalam description_points atau memiliki field terpisah jika lebih kompleks.
                    // Untuk kesederhanaan, saya membiarkan bagian ini statis atau Anda bisa
                    // menambahkan properti 'details_products' ke map produk Anda.
                    Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: const Text(
                          'Details Products',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          _isDescriptionExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        onExpansionChanged: (bool expanded) {
                          setState(() {
                            _isDescriptionExpanded = expanded;
                          });
                        },
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Contoh: Anda bisa menambahkan detail lain dari produk di sini jika ada field terpisah
                                Text(
                                  'Specific details for ${widget.product['name']}',
                                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                                ),
                                Text(
                                  'More information about this product.',
                                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                                ),
                                // ... Anda bisa menambahkan lebih banyak detail di sini
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
        currentIndex: 0, // This should be managed by the main navigation state
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // You might want to handle navigation here or pass it from parent
          // For now, it's just a placeholder
        },
      ),
    );
  }
}