import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, 
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 255, 133, 51),
      
      actions: [

         _buildNavButton(
          context,
          label: 'من نحن',
          routeName: '/about_us',
        ),
        
         VerticalDivider(color: Colors.white.withOpacity(0.5), thickness: 1),

        _buildNavButton(
          context,
          label: 'تواصل معنا',
          routeName: '/contact_us',
        ),
         VerticalDivider(color: Colors.white.withOpacity(0.5), thickness: 1),


        _buildNavButton(
          context,
          label: 'الصفحة الرئيسية',
          routeName: '/home',
        ),
       
      ],
    );
  }

  Widget _buildNavButton(BuildContext context, {required String label, required String routeName}) {
    return Padding(
       padding: const EdgeInsets.symmetric(horizontal:  3),
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, routeName);
        },
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'AvenirArabic',
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
