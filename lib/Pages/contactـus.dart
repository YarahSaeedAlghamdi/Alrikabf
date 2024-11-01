import 'package:flutter/material.dart';
import 'package:alrikabf/Components/background.dart';
import 'package:alrikabf/Components/navigation_bar.dart';
import 'package:flutter/services.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavigationBar(),
      body: Stack(
        children: [
          Background(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "تواصل معنا",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'AvenirArabic',
                            color: Color.fromARGB(255, 255, 133, 51),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        _buildContactRow(
                          context,
                          icon: Icons.email,
                          label: 'البريد الإلكتروني',
                          contactInfo: 'Alrikab2024@gmail.com',
                          onTap: () {
                            Clipboard.setData(const ClipboardData(
                              text: 'Alrikab2024@gmail.com',
                            ));
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
                        ),
                        const SizedBox(height: 20),
                        _buildContactRow(
                          context,
                          icon: Icons.alternate_email,
                          label: 'منصة اكس',
                          contactInfo: '@Alrikab2024',
                          onTap: () {
                            Clipboard.setData(const ClipboardData(
                              text: '@Alrikab2024',
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم نسخ حساب منصة اكس',
                                    style: TextStyle(
                                      fontFamily: 'AvenirArabic',
                                    ),
                                    textAlign: TextAlign.center),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(BuildContext context,
      {required IconData icon,
      required String label,
      required String contactInfo,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'AvenirArabic',
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  contactInfo,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontFamily: 'AvenirArabic',
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Icon(icon, color: const Color.fromARGB(255, 255, 133, 51), size: 30),
        ],
      ),
    );
  }
}
