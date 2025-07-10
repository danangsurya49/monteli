import 'package:flutter/material.dart';

class user_detail_produkscreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const user_detail_produkscreen({super.key, required this.product});

  @override
  State<user_detail_produkscreen> createState() => _user_detail_produkscreenState();
}

class _user_detail_produkscreenState extends State<user_detail_produkscreen> {
  bool _isDetailsProductsExpanded = false; // Mengubah nama state untuk menghindari kebingungan

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
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {},
          ),
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
      body: SingleChildScrollView( // <--- Bungkus seluruh body dengan SingleChildScrollView
        child: Column( // <--- Gunakan Column utama
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Gambar Produk
            Container(
              color: Colors.white, // Background untuk area gambar
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.network(
                widget.product['image']!,
                height: MediaQuery.of(context).size.height * 0.35, // Sesuaikan tinggi gambar
                fit: BoxFit.contain,
              ),
            ),
            // Bagian Detail Produk (latar belakang gelap)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Color(0xFF282828), // Dark grey background
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
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
                            widget.product['sub_title'] ?? 'Minuman Susu Fermentasi',
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
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.play_arrow, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
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
                  const SizedBox(height: 20),
                  Divider(color: Colors.white.withOpacity(0.3)),
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
                        _isDetailsProductsExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          _isDetailsProductsExpanded = expanded;
                        });
                      },
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'This section can contain more technical or specific details for ${widget.product['name']}.',
                                style: TextStyle(color: Colors.white.withOpacity(0.7)),
                              ),
                              Text(
                                'For example: Ingredients, Nutritional Information, Usage Instructions, etc.',
                                style: TextStyle(color: Colors.white.withOpacity(0.7)),
                              ),
                            ],
                          ),
                        ),
                      ],
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