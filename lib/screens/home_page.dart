import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thisismeapp/screens/Aboutus.dart';
import 'package:thisismeapp/screens/Contactus.dart';
import 'package:thisismeapp/screens/Friends.dart';
import 'package:thisismeapp/services/auth/auth_service.dart';

class HomePage extends StatelessWidget {
    Future<Map<String, dynamic>?> _getCurrentUserData() async {
      final user = AuthService().getCurrentUser();
      if (user == null) return null;
      final doc = await AuthService()._firestore.collection('Users').doc(user.uid).get();
      return doc.data();
    }
  HomePage({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  final List<Map<String, String>> carouselItems = [
    {
      'image': 'assets/images/white.jpg',
      'text': 'Your Mental Health Matters',
    },
    {
      'image': 'assets/images/woman.jpg',
      'text': 'We value you',
    },
    {
      'image': 'assets/images/clouds.jpg',
      'text': 'You are more than enough',
    },
    {
      'image': 'assets/images/bridge.jpg',
      'text': 'You are more than enough',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _getCurrentUserData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final userData = snapshot.data!;
        if (userData['role'] == 'therapist') {
          // Show therapist dashboard
          return TherapistDashboard();
        }
        // Regular user home page
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'This Is Me',
              style: TextStyle(fontSize: 34),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.orange.shade800,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                    ],
                  ),
                ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.family_restroom),
              title: const Text("Friends"),
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => Friends(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_page),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Contactus(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Aboutus(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 40,
            ),
            const Divider(thickness: 1),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: logout,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sunset.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 150,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height +
                      MediaQuery.of(context).padding.top,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Hey There",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  "Glad you decided to start your healing Journey",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  "We have a team of experts lined up ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  "Just for you ;)",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              const Text(
                  "When an email concludes with the domain 'thisisme.org,'  ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  "It signifies that the sender is a recognized expert in the ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                 const Text(
                  "Field",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                 const Text(
                  "Feel free to also interact with other users",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                 const Text(
                  "XOXO Thisisme Team",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // Carousel removed due to package conflict. You can add a replacement widget here if needed.
                // Example placeholder widget:
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/white.jpg',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Your Mental Health Matters',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
      extendBodyBehindAppBar: true,
    );
  }
}
