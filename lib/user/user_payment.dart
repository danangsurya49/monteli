import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:montelimart/supabase_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:montelimart/user/user.dart';

class userpayment extends StatefulWidget {
  const userpayment({super.key});

  @override
  State<userpayment> createState() => _userpaymentState();
}

class _userpaymentState extends State<userpayment> {
  // Service selection
  int _selectedService = 0; // 0: Astral Express, 1: J&T Express
  int _selectedPayment = 0; // 0: COD, 1: Transfer

  // User info controllers
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _consigneeController = TextEditingController();

  final box = GetStorage();
  List<Map<String, dynamic>> cartItems = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  void loadCart() {
    final stored = box.read('cart') ?? [];
    setState(() {
      cartItems = List<Map<String, dynamic>>.from(stored);
    });
  }

  num get cartTotalPrice {
    num total = 0;
    for (var item in cartItems) {
      final price = num.tryParse(item['price'].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
      final qty = item['qty'] ?? 1;
      total += price * qty;
    }
    return total;
  }

  int get serviceFee => _selectedService == 0 ? 7000 : 10000;
  num get totalPrice => cartTotalPrice + serviceFee;

  Future<void> submitTransaction() async {
    setState(() => _isLoading = true);
    try {
      print('=== CART ITEMS ===');
      for (var item in cartItems) {
        print(item);
      }
      // Validasi UUID
      final user = Supabase.instance.client.auth.currentUser;
      final userId = user?.id; // This is the real UUID
      if (userId == null || userId.isEmpty) {
        throw Exception('User belum login!');
      }
      for (var item in cartItems) {
        if (item['id_kategori'] == null || item['id_kategori'].toString().isEmpty ||
            item['id_barang'] == null || item['id_barang'].toString().isEmpty) {
          throw Exception('Cart contains item with missing ID. Please remove and add again.');
        }
      }
      await Future.wait(cartItems.map((item) =>
        SupabaseService().insertTransaksiPenjualan(
          userId: userId,
          email: item['email'] ?? 'dummy@email.com',
          idKategori: item['id_kategori'],
          namaKategori: item['nama_kategori'] ?? '',
          idBarang: item['id_barang'],
          namaBarang: item['name'] ?? '',
          alamat: _addressController.text,
          service: _selectedService == 0 ? 'Astral Express' : 'J&T Express',
          paymentMethod: _selectedPayment == 0 ? 'COD' : 'Transfer',
          jumlah: item['qty'] ?? 1,
          totalHarga: totalPrice,
          noTelp: _phoneController.text,
        )
      ));
      box.remove('cart');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transaction successful!')));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const userscreen()),
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _consigneeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Payment', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Check your information:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1D5A64),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ...cartItems.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(item['name'] ?? '', style: const TextStyle(fontSize: 14))),
                      Text('x${item['qty'] ?? 1}', style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                )),
              ],
            ),
            const SizedBox(height: 10),
            _buildTextField('Address', _addressController),
            const SizedBox(height: 10),
            _buildTextField('Phone', _phoneController, keyboardType: TextInputType.phone),
            const SizedBox(height: 10),
            _buildTextField('Consignee Name', _consigneeController),
            const SizedBox(height: 10),
            _buildServiceSection(),
            const SizedBox(height: 10),
            _buildPaymentSection(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Rp. ${totalPrice.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : submitTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF23B0A6),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                  ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text(
                      'Confirm',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please check your information before confirming.',
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            isDense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Choose a service',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildServiceCard(
              title: 'Astral Express',
              subtitle: 'The package will be sent as soon as possible',
              price: 'Rp. 7.000',
              color: const Color(0xFFE6F7F7),
              selected: _selectedService == 0,
              onTap: () => setState(() => _selectedService = 0),
              logo: Icons.local_shipping,
            ),
            const SizedBox(width: 12),
            _buildServiceCard(
              title: 'J&T Express',
              subtitle: 'The package will arrive in 5 to 7 days',
              price: 'Rp. 10.000',
              color: const Color(0xFFFFE6E0),
              selected: _selectedService == 1,
              onTap: () => setState(() => _selectedService = 1),
              logo: Icons.local_shipping_outlined,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String subtitle,
    required String price,
    required Color color,
    required bool selected,
    required VoidCallback onTap,
    required IconData logo,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? const Color(0xFF23B0A6) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(logo, size: 28, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Checkbox(
                    value: selected,
                    onChanged: (_) => onTap(),
                    activeColor: const Color(0xFF23B0A6),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Text(
                price,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Available payment methods:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildPaymentCard(
              title: 'COD\n(cash on delivery)',
              subtitle: '',
              color: const Color(0xFFF7F7E6),
              selected: _selectedPayment == 0,
              onTap: () => setState(() => _selectedPayment = 0),
              icon: Icons.payments_outlined,
            ),
            const SizedBox(width: 12),
            _buildPaymentCard(
              title: 'Transfer',
              subtitle: 'via e-wallet or bank',
              color: const Color(0xFFFFF3E6),
              selected: _selectedPayment == 1,
              onTap: () => setState(() => _selectedPayment = 1),
              icon: Icons.account_balance_wallet_outlined,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentCard({
    required String title,
    required String subtitle,
    required Color color,
    required bool selected,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? const Color(0xFF23B0A6) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 28, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Checkbox(
                    value: selected,
                    onChanged: (_) => onTap(),
                    activeColor: const Color(0xFF23B0A6),
                  ),
                ],
              ),
              if (subtitle.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}