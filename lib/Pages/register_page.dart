import 'package:alrikabf/Components/background.dart';
import 'package:alrikabf/Pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

 Future signUp() async {
  if (passwordConfirmed()) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 255, 133, 51), 
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
      );

      if (mounted) {
        Navigator.of(context).pop();
      }

    } on FirebaseAuthException catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
      }

      if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'خطأ',
                textAlign: TextAlign.end,
                style: TextStyle(fontFamily: 'AvenirArabic'),
              ),
              content: const Text(
                'هذا البريد الإلكتروني موجود بالفعل',
                textAlign: TextAlign.end,
                style: TextStyle(fontFamily: 'AvenirArabic'),
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
      } else {
        print('Error: ${e.message}');
      }
    }
  }
}


  Future addUserDetails(String firstName, String lastName, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      //the cooection i created it in the cloud firestore database
      'first name': firstName,
      'last name': lastName,
      'email': email,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();

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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                "أهلًا وسهلًا",
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'AvenirArabic',
                                  color: Color.fromARGB(255, 255, 133, 51),
                                ),
                              ),

                              const SizedBox(height: 8), 

                              const Text(
                                "كن جزءًا من مستقبل جديد",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'AvenirArabic',
                                  color: Colors.black87,
                                ),
                              ),

                              //------------------------------

                              const SizedBox(height: 50),

                              // first name TextField
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: TextField(
                                  controller: _firstNameController,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: 'ماهو اسمك',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey,fontFamily: 'AvenirArabic'),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 133, 51),),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                  ),
                                ),
                              ),

                              //------------------------------
                              const SizedBox(height: 15),

                              // Last name TextField
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: TextField(
                                  controller: _lastNameController,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: 'ماهو اسم عائلتك',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey,fontFamily: 'AvenirArabic'),
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
                                        const TextStyle(color: Colors.grey,fontFamily: 'AvenirArabic'),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 133, 51),),
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
                                        const TextStyle(color: Colors.grey,fontFamily: 'AvenirArabic'),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 133, 51),),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                  ),
                                ),
                              ),

                              //------------------------------
                              const SizedBox(height: 15),

                              // Confirm Password TextField
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: TextField(
                                  controller: _confirmPasswordController,
                                  obscureText: true,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    hintText: ' ادخل كلمة المرور للتأكيد',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey,fontFamily: 'AvenirArabic'),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 133, 51),),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                  ),
                                ),
                              ),

                              //------------------------------

                              const SizedBox(height: 20),

                              // Sign-up Button
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: ElevatedButton(
                                  onPressed: signUp,
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
                                      'تسجيل ',
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

                              // signin Now
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: widget.showLoginPage,
                                    child: const Text(
                                      ' سجل الدخول الان',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 133, 51),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'AvenirArabic',
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    '  لديك حساب؟',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'AvenirArabic',
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
          )
        ],
      ),
    );
  }
}
