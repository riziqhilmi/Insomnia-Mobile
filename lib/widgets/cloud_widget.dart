import 'package:flutter/material.dart';

class CloudWidget extends StatelessWidget {
  final double width;
  
  const CloudWidget({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width * 0.6,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 185, 14, 14).withOpacity(0.8),
        borderRadius: BorderRadius.circular(width * 0.3),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 15, 15).withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }
}