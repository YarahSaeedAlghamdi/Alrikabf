import 'package:alrikabf/Components/help_button.dart';
import 'package:alrikabf/Pages/CameraFeed_Page.dart';
import 'package:flutter/material.dart';

import 'package:alrikabf/Components/background.dart';
import 'package:alrikabf/Components/navigation_bar.dart';
import 'package:alrikabf/Pages/account_page.dart';


class HomePage extends StatefulWidget {
   

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 15,
                        shadowColor: Colors.grey.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Hello Text
                              const Text(
                                "أهلاً",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'AvenirArabic',
                                  color: Color.fromARGB(255, 255, 133, 51),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "كيف أقدر أساعدك؟",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontFamily: 'AvenirArabic',
                                ),
                              ),

                              //-------------------------------------

                              const SizedBox(height: 20),
                              
                              // First Inner Card
                             
                               GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CameraFeedPage(),
                                    ),
                                  );
                                },
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 300,maxHeight: 300,minWidth: 200,minHeight: 200),
                                  child: SizedBox(
                                    width: double.infinity, 
                                    height: 140, 
                                    child: Card(
                                      elevation: 10,
                                      shadowColor: Colors.grey.withOpacity(0.3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      color: Colors.white,
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 20,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "ترجمة لغة الإشارة",
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'AvenirArabic',
                                                color: Color.fromARGB(255, 255, 133, 51),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Icon(
                                              Icons.sign_language,
                                              color: Color.fromARGB(255, 255, 133, 51),
                                              size: 50,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //------------------------------------------
                              
                              const SizedBox(height: 20),

                              // Second Inner Card
                               GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AccountPage(),
                                    ),
                                  );
                                },
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 300,maxHeight: 300,minWidth: 200,minHeight: 200),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 140, 
                                    child: Card(
                                      elevation: 10,
                                      shadowColor: Colors.grey.withOpacity(0.3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      color: Colors.white,
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 20,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "الحساب",
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'AvenirArabic',
                                                color: Color.fromARGB(255, 255, 133, 51),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Icon(
                                              Icons.person,
                                              color: Color.fromARGB(255, 255, 133, 51),
                                              size: 50,
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
                        ),
                      ),
                      const SizedBox(height: 20),
                      const HelpButton(),
                    ],
                  ),
                ),
              ),
            ),
            
          ),

          

        ],
      ),
    );
  }
}
