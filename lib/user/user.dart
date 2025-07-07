import 'package:flutter/material.dart';
import 'package:montelimart/user/user_detail_produk.dart';
import 'package:montelimart/user/user_kategori.dart';

class userscreen extends StatefulWidget {
  const userscreen({super.key});

  @override
  State<userscreen> createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> _allProducts = [
    {
      'name': 'Yakult',
      'sub_title': 'Minuman Susu Fermentasi S⁺ 65 ml',
      'price': 'Rp 10.500',
      'image': 'assets/minuman/yakult.png',
      'category': 'Drinks',
      'description_points': [
        'Contains good bacteria L. casei Shirota',
        'Helps maintain good digestion',
        'Does not contain fat and cholesterol',
        'Without added preservatives or artificial colors',
        'Volume: 65 ml per bottle',
        'Packaging: 5 bottles per pack',
        'Producer: Yakult Indonesia Persada',
      ],
    },
    {
      'name': 'Ultra Milk',
      'sub_title': 'Susu UHT Full Cream',
      'price': 'Rp 7.900',
      'image': 'assets/minuman/ultramilk.png',
      'category': 'Drinks',
      'description_points': [
        'Full cream UHT milk',
        'High in calcium and vitamins',
        'Suitable for daily consumption',
        'Shelf-stable and convenient',
        'Volume: 250 ml',
        'Producer: Ultrajaya Milk Industry',
      ],
    },
    {
      'name': 'Marjan Boudouin Syrup',
      'sub_title': 'Melon',
      'price': 'Rp 26.900',
      'image': 'assets/minuman/marjan.png',
      'category': 'Drinks',
      'description_points': [
        'Melon flavored syrup',
        'Refreshing and sweet',
        'Great for drinks and desserts',
        'Volume: 460 ml',
        'Producer: PT. Lasallefood Indonesia',
      ],
    },
    {
      'name': 'Teh Pucuk Harum',
      'sub_title': 'Melati',
      'price': 'Rp 3.200',
      'image': 'assets/minuman/pucuk.png',
      'category': 'Drinks',
      'description_points': [
        'Jasmine tea ready to drink',
        'Authentic tea flavor',
        'No artificial sweeteners',
        'Volume: 250 ml',
        'Producer: PT. Mayora Indah Tbk',
      ],
    },
    {
      'name': 'Aqua',
      'sub_title': 'Air Mineral',
      'price': 'Rp 6.900',
      'image': 'assets/minuman/aqua.png',
      'category': 'Drinks',
      'description_points': [
        'Pure mineral water',
        'Hydrating and refreshing',
        'Sourced from natural springs',
        'Volume: 600 ml',
        'Producer: Danone AQUA',
      ],
    },
    {
      'name': 'Chitato',
      'sub_title': 'Potato Chips',
      'price': 'Rp 8.000',
      'image': 'assets/makanan ringan/CHITATO.png',
      'category': 'snacks',
      'description_points': [
        'Crispy potato chips',
        'Various flavors available',
        'Perfect for snacking',
      ],
    },
    {
      'name': 'good day',
      'sub_title': 'coffee',
      'price': 'Rp 5.000',
      'image': 'assets/minuman/gooday.png',
      'category': 'Drinks',
      'description_point': [
        'Coffee ready to drink',
        'Authentic coffee flavor',
        'No artificial sweeteners',
      ],
    },
    {},
  ];

  late List<Map<String, dynamic>> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _filterProductsByCategory();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Method untuk mengubah kategori yang dipilih dan memperbarui produk
  void _onCategoryChipTapped(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _filterProductsByCategory(); // Filter ulang produk
    });
  }

  // Method untuk memfilter produk berdasarkan kategori yang dipilih
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
      // 'All' atau 'Drinks' akan menampilkan semua minuman dulu
      _filteredProducts =
          _allProducts
              .where((product) => product['category'] == 'Drinks')
              .toList();
    } else {
      _filteredProducts =
          _allProducts
              .where((product) => product['category'] == selectedCategoryName)
              .toList();
    }
    // Jika tidak ada produk di kategori tersebut, bisa tampilkan pesan atau list kosong.
    // Untuk pengembangan, penting untuk memiliki produk di setiap kategori.
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
            _buildProductCategories(), // Kini akan memanggil method non-static
            const SizedBox(height: 20),
            _buildProductsGrid(), // Kini akan memanggil method non-static
          ],
        ),
      ),
      const userscreen(),
      const Center(
        child: Text('Payment Screen', style: TextStyle(fontSize: 24)),
      ),
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
                    '1',
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
                  Image.network('https://via.placeholder.com/150').image,
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
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
                onPressed: () {},
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
    // Gunakan _filteredProducts, bukan _allProducts
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.7,
        ),
        itemCount:
            _filteredProducts.length, // <-- Gunakan _filteredProducts.length
        itemBuilder: (context, index) {
          return _buildProductCard(
            _filteredProducts[index],
          ); // <-- Gunakan _filteredProducts[index]
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
