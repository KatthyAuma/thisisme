import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerificationRequestScreen extends StatelessWidget {
  const VerificationRequestScreen({super.key});

  Future<void> requestVerification(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await FirebaseFirestore.instance.collection('verification_requests').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'timestamp': FieldValue.serverTimestamp(),
      'status': 'pending',
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verification request sent!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Verification')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => requestVerification(context),
          child: const Text('Request Therapist Verification'),
        ),
      ),
    );
  }
}
