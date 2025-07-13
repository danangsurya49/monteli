import 'package:flutter/material.dart';
import 'dart:async';
import 'package:montelimart/user/user_detail_produk.dart';
import 'package:montelimart/user/user_kategori.dart'; // Pastikan ini mengacu ke kelas kategoriscreen
import 'package:montelimart/user/user_payment.dart'; // Pastikan ini mengacu ke kelas userpayment
import 'package:montelimart/user/user_cart.dart'; // Import ini jika user_cart digunakan secara langsung di sini
import 'package:montelimart/user/user_profil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:montelimart/supabase_services.dart';
import 'package:montelimart/auth/login_user.dart'; // Pastikan ini masih diperlukan

class userscreen extends StatefulWidget {
  const userscreen({super.key});

  @override
  State<userscreen> createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;

  List<Map<String, dynamic>> _allProducts = [];
  List<Map<String, dynamic>> _filteredProducts = []; // Inisialisasi awal
  bool _isLoading = true;
  final box = GetStorage();
  int cartCount = 0;
  int totalOrders = 0; // Tambahkan untuk jumlah pesanan
  double totalSpent = 0.0; // Tambahkan untuk total pengeluaran

  final List<String> productCategoriesChips = const [
    'Drinks',
    'snacks',
    'bread & cakes',
    'toys',
    'toiletries',
    'stationery',
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomeScreenContent(),
      const kategoriscreen(), // Pastikan ini bisa const
      const userpayment(), // Pastikan ini bisa const
      const UserProfil(),
    ];

    fetchProducts();
    updateCartCount();
    // Anda mungkin perlu fungsi serupa untuk memperbarui totalOrders dan totalSpent
    // Misalnya, box.listenKey('orders', (value) { updateOrderStats(); });
    box.listenKey('cart', (value) {
      updateCartCount();
    });
  }

  // --- Data Fetching and Filtering ---

  Future<void> fetchProducts() async {
    setState(() {
      _isLoading = true; // Set loading to true when fetching starts
    });
    try {
      final fetchedData = await SupabaseService().getAllProduk().timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw TimeoutException('Timeout mengambil data produk. Cek koneksi internet Anda.');
            },
          );

      if (mounted) {
        setState(() {
          _allProducts = List<Map<String, dynamic>>.from(fetchedData);
          _filterProductsByCategory(); // Filter once data is fetched
        });
      }
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
          _isLoading = false; // Set loading to false when fetching ends
        });
      }
    }
  }

  void _filterProductsByCategory() {
    String selectedCategoryName = productCategoriesChips[_selectedCategoryIndex];

    if (_allProducts.isNotEmpty) {
      _filteredProducts = _allProducts
          .where((product) =>
              (product['category'] as String?)?.toLowerCase() ==
              selectedCategoryName.toLowerCase()) // Case-insensitive comparison
          .toList();
    } else {
      _filteredProducts = [];
    }
  }

  void addToCart(Map<String, dynamic> product) {
    final cart = List<Map<String, dynamic>>.from(box.read('cart') ?? []);

    // Coba temukan produk yang sudah ada di keranjang
    int existingProductIndex = cart.indexWhere((item) => item['id_barang'] == product['id']);

    if (existingProductIndex != -1) {
      // Jika produk sudah ada, tingkatkan kuantitas
      cart[existingProductIndex]['qty'] = (cart[existingProductIndex]['qty'] as int) + 1;
    } else {
      // Jika produk belum ada, tambahkan sebagai item baru
      cart.add({
        // Asumsi 'id' adalah kunci universal untuk ID produk dari Supabase
        'id_barang': product['id'] ?? '',
        'id_kategori': product['id_kategori'] ?? '',
        'user_id': box.read('user_id') ?? 'guest',
        'nama_kategori': product['category'] ?? '',
        'name': product['name'] ?? '',
        'image': product['image'] ?? '',
        'price': product['price'] ?? 0.0, // Pastikan ini double atau int
        'qty': 1,
      });
    }

    box.write('cart', cart);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ditambahkan ke keranjang!')),
      );
    }
  }

  void updateCartCount() {
    final cart = List<Map<String, dynamic>>.from(box.read('cart') ?? []);
    if (mounted) {
      setState(() {
        cartCount = cart.length;
      });
    }
  }

  // Fungsi untuk memperbarui statistik pesanan (Anda perlu mengimplementasikan logika pengambilan data ini)
  Future<void> updateOrderStats() async {
    // Implementasi pengambilan totalOrders dan totalSpent dari Supabase
    // Contoh placeholder:
    await Future.delayed(const Duration(milliseconds: 500)); // Simulasi fetch data
    if (mounted) {
      setState(() {
        totalOrders = 5; // Ganti dengan data aktual
        totalSpent = 150000.0; // Ganti dengan data aktual
      });
    }
  }

  // --- Bottom Navigation Bar Tap ---
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _selectedCategoryIndex = 0; // Kembali ke kategori pertama saat kembali ke Home
        _filterProductsByCategory();
      }
    });
  }

  // --- Category Chip Tap ---
  void _onCategoryChipTapped(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _filterProductsByCategory();
    });
  }

  // --- Widget Builders for Home Screen Content ---
  Widget _buildHomeScreenContent() {
    return SingleChildScrollView(
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
    );
  }

  Widget _buildHeaderCard() {
    final userName = box.read('user_name') ?? 'Pelanggan';
    final userEmail = box.read('user_email') ?? 'email@example.com'; // Bisa digunakan jika ingin ditampilkan

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1D5A64),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                // Ganti dengan URL gambar profil pengguna sebenarnya
                backgroundImage: Image.network(
                  'https://via.placeholder.com/150', // Ganti dengan URL gambar profil pengguna
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
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
                    'Temukan berbagai pilihan produk kami.',
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
                      'Nama Pelanggan',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Text(
                      userName,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          _onItemTapped(3); // Pindah ke tab profil
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Kunjungi Profil',
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
                      child: Column(
                        children: [
                          const Text(
                            'Jumlah pesanan',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            totalOrders.toString(), // Gunakan state totalOrders
                            style: const TextStyle(
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
                        color: const Color(0xFFF18E34),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Total pengeluaran',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            'RP ${totalSpent.toStringAsFixed(2)}', // Gunakan state totalSpent
                            style: const TextStyle(
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Produk',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  _onItemTapped(1); // Pindah ke tab kategori
                },
                child: const Text(
                  'Lihat semua',
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
              itemCount: productCategoriesChips.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      _onCategoryChipTapped(index);
                    },
                    child: Chip(
                      label: Text(productCategoriesChips[index]),
                      backgroundColor: _selectedCategoryIndex == index
                          ? Colors.blue.shade50
                          : Colors.grey.shade200,
                      labelStyle: TextStyle(
                        color: _selectedCategoryIndex == index
                            ? Colors.blue.shade800
                            : Colors.black87,
                        fontWeight: _selectedCategoryIndex == index
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
    final List<Color?> cardColors = const [
      // Menambahkan const
      Color(0xFFE6F7FF),
      Color(0xFFFFF9E6),
      Color(0xFFF3E6FF),
      Color(0xFFFFE6F0),
      Color(0xFFE6FFF2),
      Color(0xFFFFF3E6),
      Color(0xFFE6F0FF),
      Color(0xFFFFE6E6),
    ];

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_filteredProducts.isEmpty && !_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Tidak ada produk ditemukan untuk kategori ini.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

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
          final nama = product['name'] ?? 'Nama Produk';
          final harga =
              product['price'] != null ? 'Rp ${product['price'].toString()}' : 'Rp 0';
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
                                errorBuilder: (c, e, s) =>
                                    const Icon(Icons.image, size: 48, color: Colors.grey),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MontelliMart'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserCart()), // Arahkan ke UserCart
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
              child: Text(
                cartCount.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pembayaran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}