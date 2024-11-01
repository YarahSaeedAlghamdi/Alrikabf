import 'package:flutter/material.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/help_page');
      },
      child: Container(
        width: 70.0, // Adjust size as needed
        height: 70.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: const DecorationImage(
            image: AssetImage('lib/assets/images/help.jpg'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), 
              spreadRadius: 2,
              blurRadius: 20,
              offset: const Offset(0, 3), 
            ),
          ],
        ),
      ),
    );
  }
}
