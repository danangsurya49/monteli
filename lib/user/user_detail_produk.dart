import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class user_detail_produkscreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const user_detail_produkscreen({super.key, required this.product});

  @override
  State<user_detail_produkscreen> createState() => _user_detail_produkscreenState();
}

class _user_detail_produkscreenState extends State<user_detail_produkscreen> {
  final box = GetStorage();

  void addToCart() {
    final cart = List<Map<String, dynamic>>.from(box.read('cart') ?? []);
    cart.add({
      'id_barang': widget.product['id_minuman'] ?? widget.product['id_makanan'] ?? widget.product['id_mainan'] ?? widget.product['id_roti'] ?? widget.product['id_rumahtangga'] ?? '',
      'id_kategori': widget.product['id_kategori'] ?? '',
      'user_id': 'dummy-user-uuid', // Ganti dengan UUID user login jika ada
      'nama_kategori': widget.product['nama_kategori'] ?? '',
      'name': widget.product['name'] ?? '',
      'image': widget.product['image'] ?? '',
      'price': widget.product['price'] ?? '',
      'qty': 1,
    });
    box.write('cart', cart);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                Navigator.pop(context);
              },
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: Image.network(
                'https://via.placeholder.com/150',
              ).image,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.network(
                widget.product['image'] ?? '',
                height: MediaQuery.of(context).size.height * 0.35,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) => const Icon(Icons.image, size: 80, color: Colors.grey),
              ),
            ),
            // Detail Produk
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Color(0xFF282828),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product['name'] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.product['sub_title'] ?? '',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.product['price'] ?? '',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
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
                  if (descriptionPoints.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: descriptionPoints.map((point) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            '- $point',
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
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: addToCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 