import 'package:alrikabf/Components/background.dart';
import 'package:alrikabf/Components/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
   final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/check_page');
  }

  Widget _buildSectionCard({
    required String title,
    required String subtitle,
    IconData? iconData,
    VoidCallback? onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      color: Colors.white,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'AvenirArabic',
            color: Color.fromARGB(255, 255, 133, 51),
          ),
          textAlign: TextAlign.end,
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'AvenirArabic',
            color: Colors.black87,
          ),
          textAlign: TextAlign.end,
        ),
        trailing: iconData != null
            ? Icon(iconData, color: const Color.fromARGB(255, 255, 133, 51))
            : null,
        onTap: onTap,
      ),
    );
  }

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
                child: ListView(
                  shrinkWrap: true,
                  children: [ if (currentUser != null) ...[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 8,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color.fromARGB(255, 255, 133, 51).withOpacity(0.2),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Color.fromARGB(255, 255, 133, 51),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                currentUser?.email ?? 'No email registered',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'AvenirArabic',
                                  color: Colors.black45,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _signOut,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                                ),
                                child: const Text(
                                  'تسجيل الخروج',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'AvenirArabic',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                     
                      const SizedBox(height: 20),
                      _buildSectionCard(
                        title: 'السجل',
                        subtitle: 'هنا سيتم عرض السجل الخاص بك',
                        iconData: Icons.history,
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/history_page');
                        },
                      ),
                    ] else ...[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 8,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                size: 50,
                                color: Color.fromARGB(255, 255, 133, 51),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'لم تقم بتسجيل الدخول. إذا كنت تريد رؤية ملفك الشخصي، يُرجى تسجيل الدخول',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'AvenirArabic',
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/check_page');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 255, 133, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                                ),
                                child: const Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'AvenirArabic',
                                    color: Colors.white,
                                  ), 
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
