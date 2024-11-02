// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:alrikabf/Pages/forgot_password.dart';
import 'package:alrikabf/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:alrikabf/Components/background.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> signIn() async {
    // Check if email or password is empty
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'حدث خطأ',
              style: TextStyle(fontFamily: 'AvenirArabic'),
              textAlign: TextAlign.end,
            ),
            content: const Text(
              'يرجى إدخال البريد الإلكتروني وكلمة المرور',
              style: TextStyle(fontFamily: 'AvenirArabic'),
              textAlign: TextAlign.end,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('حسناً',style: TextStyle(
                      fontFamily: 'AvenirArabic',
                      color:  Color.fromARGB(255, 255, 133, 51),
                    ),
                    ),
                ),
              ),
            ],
          );
        },
      );
      return; // Exit the function early if fields are empty
    }

    // Show loading circle while processing the sign-in
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
            child: CircularProgressIndicator(
          color: Color.fromARGB(255, 255, 133, 51),
        ),);
      },
    );

    try {
      // Attempt to sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Close the loading circle after successful sign-in
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      // Close the loading circle
      Navigator.of(context).pop();

      // Show error dialog with specific messages based on Firebase exception codes
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'المستخدم غير موجود.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'كلمة المرور غير صحيحة، تأكد مرة أخرى';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'البريد الإلكتروني غير صالح';
      } else {
        errorMessage =
            'البريد الإلكتروني أو كلمة المرور غير صحيحة، تأكد مرة أخرى';
      }

      // Show error message in an AlertDialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'حدث خطأ',
              textAlign: TextAlign.end,
              style: TextStyle(fontFamily: 'AvenirArabic'),
            ),
            content: Text(
              errorMessage,
              textAlign: TextAlign.end,
              style: const TextStyle(fontFamily: 'AvenirArabic'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'حسناً',
                    style: TextStyle(
                      fontFamily: 'AvenirArabic',
                      color: Color.fromARGB(255, 255, 133, 51),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Background(),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30,),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: SingleChildScrollView(
                  child: Column(
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
                              vertical: 30, horizontal: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Hello Text
                              const Text(
                                "أهلًا بك",
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'AvenirArabic',
                                  color: Color.fromARGB(255, 255, 133, 51),
                                ),
                              ),

                              const SizedBox(height: 8), 

                              const Text(
                                "نحن هنا لخدمتك",
                                style: TextStyle(
                                  fontFamily: 'AvenirArabic',
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                              ),
                            

                              //------------------------------

                              const SizedBox(height: 50),

                              // Email TextField
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: TextField(
                                  controller: _emailController,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: 'ادخل الايميل',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey,fontFamily: 'AvenirArabic',),
                                        
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 133, 51)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                  ),
                                ),
                              ),

                              //------------------------------

                              const SizedBox(height: 15),

                              // Password TextField
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: 'ادخل كلمة المرور',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey,fontFamily: 'AvenirArabic',),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 133, 51)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                  ),
                                ),
                              ),

                              //------------------------------
                              const SizedBox(height: 10),

                              //Forget Password
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ForgotPasswordPage();
                                            },
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'نسيت كلمة المرور؟',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 255, 133, 51),
                                          fontFamily: 'AvenirArabic',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Sign-in Button
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: ElevatedButton(
                                  onPressed: signIn,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 133, 51),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 5,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'AvenirArabic',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //------------------------------

                              const SizedBox(height: 30),

                              // Register Now
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: widget.showRegisterPage,
                                    child: const Text(
                                      'سجل الان',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 133, 51),
                                        fontFamily: 'AvenirArabic',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    ' ليس لديك حساب؟',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'AvenirArabic',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),

                              //------------------------------
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Skip Login outside the Card
                      RawMaterialButton(
                        onPressed: (){
                           Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(builder: (context) => HomePage()),
                            );
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        padding: const EdgeInsets.all(20.0),
                        shape: const CircleBorder(),
                        child: const Text(
                          'تخطي ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'AvenirArabic',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
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
