import 'package:flutter/material.dart';

void main() {
  runApp(const MyFarmApp());
}

class MyFarmApp extends StatelessWidget {
  const MyFarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Farm App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  // Sahte veriler (ilerde API'den gelecek)
  final List<Map<String, dynamic>> _products = [
    {'name': 'Buğday', 'price': '12.5 TL/kg', 'change': '+2%'},
    {'name': 'Arpa', 'price': '10.8 TL/kg', 'change': '-1%'},
    {'name': 'Mısır', 'price': '8.9 TL/kg', 'change': '+3%'},
    {'name': 'Pamuk', 'price': '45.0 TL/kg', 'change': '+5%'},
  ];

  static const List<Widget> _pages = <Widget>[
    DashboardPage(),
    PricesPage(),
    WeatherPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Farm App 🌱'),
        backgroundColor: Colors.green[700],
        elevation: 2,
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Fiyatlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Hava Durumu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// Dashboard Sayfası
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Hoşgeldiniz Kartı
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hoş Geldiniz!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Tarım verileriniz ve pazar bilgileriniz burada.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    // Anket sayfasına yönlendirme (ilerde yapılacak)
                  },
                  icon: const Icon(Icons.assignment),
                  label: const Text('Ankete Katıl'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Hızlı İstatistikler
        const Text(
          'Hızlı İstatistikler',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        
        Row(
          children: [
            Expanded(
              child: _buildStatCard('Ürünler', '4', Icons.agriculture, Colors.blue),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildStatCard('Takipçi', '12', Icons.people, Colors.orange),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// Fiyatlar Sayfası
class PricesPage extends StatelessWidget {
  const PricesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Güncel Pazar Fiyatları',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          'Son güncelleme: Bugün 14:30',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        
        // Ürün listesi
        ...List.generate(4, (index) => _buildProductItem(
          '${['Buğday', 'Arpa', 'Mısır', 'Pamuk'][index]}',
          '${['12.5', '10.8', '8.9', '45.0'][index]} TL/kg',
          '${['+2%', '-1%', '+3%', '+5%'][index]}',
          Colors.green,
        )),
      ],
    );
  }
  
  Widget _buildProductItem(String name, String price, String change, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(Icons.agriculture, color: color),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(price),
        trailing: Chip(
          label: Text(change, style: const TextStyle(color: Colors.white)),
          backgroundColor: change.contains('+') ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}

// Hava Durumu Sayfası
class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud, size: 100, color: Colors.blue),
          const SizedBox(height: 20),
          const Text(
            'Hava Durumu',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'API entegrasyonu yakında...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Hava durumu API'si için
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('Konum Ekle'),
          ),
        ],
      ),
    );
  }
}

// Profil Sayfası
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.green,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            'Çiftçi Profili',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Anket sonuçlarına göre özelleştirilecek',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Anket sayfası
            },
            child: const Text('Anketi Doldur'),
          ),
        ],
      ),
    );
  }
}