import 'package:flutter/material.dart';
import 'package:alrikabf/Components/background.dart';
import 'package:flutter/services.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: <Widget>[
                    // Logo with responsive height and shadow
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(
                          'lib/assets/images/alrikab_logoWhite.png',
                          height: 400,
                          width: 400,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Sign In Button
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 255, 133, 51), // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Rounded edges
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 50,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: const Text(
                          'خطوتك الأولى نحو التواصل',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'AvenirArabic',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Cards with enhanced icons on the right
                    _buildCard(
                      title: 'عن الرّكاب',
                      content:
                          'رؤيتنا في الرّكاب: بناء مجتمع متكامل يسهل التواصل بين الصم والمجتمع بتكافؤ وبدون عوائق',
                      iconData: Icons.group,
                    ),
                    _buildCard(
                      title: 'رسالتنا',
                      content:
                          'تمكين الصم من التفاعل بحرية والاستقلاليه، ومساعدتهم لتعزيز تواصلهم اليومي',
                      iconData: Icons.hearing,
                    ),
                    _buildCard(
                      title: 'ماذا نقدم في الرّكاب',
                      content:
                          'نوفر ترجمة فورية من لغة الإشارة إلى اللغه العربية المكتوبة، لدعم التواصل المباشر للصم مع المجتمع',
                      iconData: Icons.translate,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 255, 133, 51),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content
            children: [
              const Icon(Icons.email, color: Colors.white),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  // Copy email to clipboard
                  Clipboard.setData(
                      const ClipboardData(text: 'Alrikab2024@gmail.com'));

                  // Show a SnackBar confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'تم نسخ البريد الإلكتروني',
                        style: TextStyle(
                          fontFamily: 'AvenirArabic',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text(
                  'Alrikab2024@gmail.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'AvenirArabic',
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    decorationThickness: 1.5,
                    height: .5,
                  ),
                ),
              ),


              const SizedBox(width: 5),

              
              const Text(
                ':تواصل معنا',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'AvenirArabic',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String content,
    IconData? iconData,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AvenirArabic',
                      color: Color.fromARGB(255, 255, 133, 51),
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  iconData,
                  color: const Color.fromARGB(255, 255, 133, 51),
                  size: 40,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                height: 1.5,
                fontWeight: FontWeight.w400,
                fontFamily: 'AvenirArabic',
              ),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
