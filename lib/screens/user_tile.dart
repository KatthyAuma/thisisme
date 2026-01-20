import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final bool isTherapist;
  final bool isVerified;
  final void Function()? onTap;

  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
    this.isTherapist = false,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(isTherapist ? Icons.medical_services : Icons.person_2),
            const SizedBox(width: 20),
            Text(text),
            if (isVerified)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.verified, color: Colors.blue, size: 20),
              ),
          ],
        ),
      ),
    );
  }
}
