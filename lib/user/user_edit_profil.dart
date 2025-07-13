import 'package:flutter/material.dart';

class UserEditProfil extends StatefulWidget {
  const UserEditProfil({super.key});

  @override
  State<UserEditProfil> createState() => _UserEditProfilState();
}

class _UserEditProfilState extends State<UserEditProfil> {
  // Controllers for form fields
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController postcodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Edit account', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage('https://via.placeholder.com/100'),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Please complete your profile', style: TextStyle(color: Colors.grey, fontSize: 15)),
              const SizedBox(height: 24),
              TextField(
                controller: dobController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                  hintText: 'Date of birth',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: UnderlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    dobController.text = "${picked.day}/${picked.month}/${picked.year}";
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone, color: Colors.grey),
                  hintText: '+62 ID   Phone',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: address1Controller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on, color: Colors.grey),
                  hintText: 'Address 1',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: address2Controller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on, color: Colors.grey),
                  hintText: 'Address 2',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: postcodeController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.confirmation_number, color: Colors.grey),
                  hintText: 'Postcode',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_city, color: Colors.grey),
                  hintText: 'City',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: countryController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.public, color: Colors.grey),
                  hintText: 'Country',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22B89A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Handle confirm action
                  },
                  child: const Text('Confirm', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF22B89A),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'category'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Payment'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: 3,
        onTap: (index) {
          // Handle navigation if needed
        },
      ),
    );
  }
}