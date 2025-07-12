import 'package:flutter/material.dart';
import 'dart:async';
import 'package:montelimart/user/user_detail_produk.dart';
import 'package:montelimart/user/user_kategori.dart';
import 'package:montelimart/user/user_payment.dart';
import 'package:montelimart/user/user_cart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:montelimart/supabase_services.dart';

class userscreen extends StatefulWidget {
  const userscreen({super.key});

  @override
  State<userscreen> createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;

  List<Map<String, dynamic>> _allProducts = [];
  late List<Map<String, dynamic>> _filteredProducts;
  bool _isLoading = true;
  final box = GetStorage();
  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    updateCartCount();
    box.listenKey('cart', (value) {
      updateCartCount();
    });
  }

  Future<void> fetchProducts() async {
    try {
      _allProducts = await SupabaseService().getAllProduk().timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw TimeoutException('Timeout mengambil data produk. Cek koneksi internet Anda.');
        },
      );
      _filterProductsByCategory();
    } on TimeoutException catch (e) {
      print('Timeout error fetch produk: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    } catch (e) {
      print('Error fetch produk: $e');
      if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil produk: $e')),
      );
    }
    } finally {
      if (mounted) {
    setState(() {
      _isLoading = false;
    });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCategoryChipTapped(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _filterProductsByCategory();
    });
  }

  void _filterProductsByCategory() {
    final List<String> categories = [
      'Drinks',
      'snacks',
      'bread & cakes',
      'toys',
      'toiletries',
      'stationery',
    ];
    String selectedCategoryName = categories[_selectedCategoryIndex];

    if (selectedCategoryName == 'All' || selectedCategoryName == 'Drinks') {
      _filteredProducts =
          _allProducts.where((product) => product['category'] == 'Drinks').toList();
    } else {
      _filteredProducts =
          _allProducts.where((product) => product['category'] == selectedCategoryName).toList();
    }
  }

  void addToCart(Map<String, dynamic> product) {
    final cart = List<Map<String, dynamic>>.from(box.read('cart') ?? []);
    cart.add({
      'id_barang': product['id_barang'] ?? '',
      'id_kategori': product['id_kategori'] ?? '',
      'user_id': 'dummy-user-uuid', // Ganti dengan UUID user login jika ada
      'nama_kategori': product['nama_kategori'] ?? '',
      'name': product['name'] ?? '',
      'image': product['image'] ?? '',
      'price': product['price'] ?? '',
      'qty': 1,
    });
    box.write('cart', cart);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart!')),
    );
  }

  void updateCartCount() {
    final cart = List<Map<String, dynamic>>.from(box.read('cart') ?? []);
    setState(() {
      cartCount = cart.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 20),
            _buildProductCategories(),
            const SizedBox(height: 20),
            _buildProductsGrid(),
          ],
        ),
      ),
      kategoriscreen(),
      userpayment(),
      const Center(
        child: Text('Profile Screen', style: TextStyle(fontSize: 24)),
      ),
    ];

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserCart()),
                  );
                },
              ),
              if (cartCount > 0)
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
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
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
                  Image.network('https://via.placeholder.com/150').image,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payment'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1D5A64), // Dark teal/green color
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    Image.network(
                      'https://via.placeholder.com/150', // Replace with actual user profile image
                    ).image,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MontelliMart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Discover our wide selection of products.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Customer Name',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const Text(
                      'Customer email',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Profile visit',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Number of orders',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF18E34), // Orange color
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Total spent',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            'RP 0.0',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }

  Widget _buildProductCategories() {
    final List<String> categories = [
      'Drinks',
      'snacks',
      'bread & cakes',
      'toys',
      'toiletries',
      'stationery',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const kategoriscreen()),
                  );
                },
                child: const Text(
                  'See all',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    // <-- Tambahkan GestureDetector
                    onTap: () {
                      _onCategoryChipTapped(
                        index,
                      ); // Panggil method untuk mengubah kategori
                    },
                    child: Chip(
                      label: Text(categories[index]),
                      backgroundColor:
                          _selectedCategoryIndex ==
                                  index // <-- Gunakan state untuk menentukan warna
                              ? Colors.blue.shade50
                              : Colors.grey.shade200,
                      labelStyle: TextStyle(
                        color:
                            _selectedCategoryIndex == index
                                ? Colors.blue.shade800
                                : Colors.black87,
                        fontWeight:
                            _selectedCategoryIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
    final List<Color?> cardColors = [
      Color(0xFFE6F7FF),
      Color(0xFFFFF9E6),
      Color(0xFFF3E6FF),
      Color(0xFFFFE6F0),
      Color(0xFFE6FFF2),
      Color(0xFFFFF3E6),
      Color(0xFFE6F0FF),
      Color(0xFFFFE6E6),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.68,
        ),
        itemCount: _filteredProducts.length,
        itemBuilder: (context, idx) {
          final product = _filteredProducts[idx];
          final color = cardColors[idx % cardColors.length] ?? Colors.white;
          final nama = product['name'] ?? '';
          final harga = product['price'] ?? '';
          final gambar = product['image'] ?? '';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => user_detail_produkscreen(product: product),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: gambar.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                gambar,
                                fit: BoxFit.contain,
                                errorBuilder: (c, e, s) => const Icon(Icons.image, size: 48, color: Colors.grey),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.image, size: 48, color: Colors.grey),
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      nama,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: Row(
                      children: [
                        Text(
                          harga,
                          style: const TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                            onPressed: () {
                              addToCart(product);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => user_detail_produkscreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: Image.network(
                  product['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['price']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Handle add to cart
                        },
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
