import 'package:flutter/material.dart';

class TherapistDashboard extends StatelessWidget {
  const TherapistDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Therapist Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome, Therapist!'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AppointmentScreen(),
                  ),
                );
              },
              child: const Text('Set/View Appointments'),
            ),
            // Add more therapist/admin features here
          ],
        ),
      ),
    );
  }
}
