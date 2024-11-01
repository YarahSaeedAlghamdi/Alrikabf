import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 255, 133, 51),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/about_us');
          },
          child: const Text(
            'من نحن',
            style: TextStyle(
              fontFamily: 'AvenirArabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/contact_us');
          },
          child: const Text(
            'تواصل معنا',
            style: TextStyle(
              fontFamily: 'AvenirArabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: const Text(
            'الصفحة الرئيسية',
            style: TextStyle(
              fontFamily: 'AvenirArabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
