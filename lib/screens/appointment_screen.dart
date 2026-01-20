import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  DateTime? _selectedDateTime;

  Future<void> _createAppointment() async {
    final therapist = FirebaseAuth.instance.currentUser;
    if (therapist == null || _userEmailController.text.isEmpty || _selectedDateTime == null) return;
    // Find user by email
    final userQuery = await FirebaseFirestore.instance.collection('Users').where('email', isEqualTo: _userEmailController.text).get();
    if (userQuery.docs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not found.')));
      return;
    }
    final userId = userQuery.docs.first.id;
    await FirebaseFirestore.instance.collection('appointments').add({
      'therapistId': therapist.uid,
      'userId': userId,
      'dateTime': _selectedDateTime,
      'details': _detailsController.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Appointment created!')));
    _userEmailController.clear();
    _detailsController.clear();
    setState(() { _selectedDateTime = null; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userEmailController,
              decoration: const InputDecoration(labelText: 'User Email'),
            ),
            TextField(
              controller: _detailsController,
              decoration: const InputDecoration(labelText: 'Details'),
            ),
            Row(
              children: [
                Text(_selectedDateTime == null ? 'No date selected' : _selectedDateTime.toString()),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          _selectedDateTime = DateTime(picked.year, picked.month, picked.day, time.hour, time.minute);
                        });
                      }
                    }
                  },
                  child: const Text('Pick Date & Time'),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _createAppointment,
              child: const Text('Create Appointment'),
            ),
            const SizedBox(height: 24),
            const Text('Your Appointments:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('appointments').where('therapistId', isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final appointments = snapshot.data!.docs;
                  if (appointments.isEmpty) return const Center(child: Text('No appointments.'));
                  return ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      final data = appointments[index].data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text('User: ${data['userId']}'),
                        subtitle: Text('At: ${data['dateTime']?.toDate() ?? ''}\n${data['details'] ?? ''}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
