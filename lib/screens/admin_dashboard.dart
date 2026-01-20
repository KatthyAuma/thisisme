import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  Future<void> approveRequest(String uid) async {
    await FirebaseFirestore.instance.collection('Users').doc(uid).update({
      'role': 'therapist',
      'verified': true,
    });
    await FirebaseFirestore.instance.collection('verification_requests').doc(uid).update({
      'status': 'approved',
    });
  }

  Future<void> rejectRequest(String uid) async {
    await FirebaseFirestore.instance.collection('verification_requests').doc(uid).update({
      'status': 'rejected',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('verification_requests').where('status', isEqualTo: 'pending').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final requests = snapshot.data!.docs;
          if (requests.isEmpty) return const Center(child: Text('No pending requests.'));
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final data = requests[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['email'] ?? ''),
                subtitle: Text('Requested at: ${data['timestamp']?.toDate() ?? ''}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => approveRequest(data['uid']),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => rejectRequest(data['uid']),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
