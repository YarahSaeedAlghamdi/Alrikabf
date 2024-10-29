import 'package:alrikabf/Components/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> passwordReset() async {
    String email = _emailController.text.trim();
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      _showDialog(
        title: 'خطأ في البريد الإلكتروني',
        content: 'يرجى إدخال بريد إلكتروني صالح',
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showDialog(
        title: 'تم الإرسال',
        content:
            ' سوف يتم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني إذا كنت مسجل لدينا',
      );
    } catch (e) {
      _showDialog(
        title: 'حدث خطأ',
        content: 'لم نتمكن من إرسال الرابط. يرجى المحاولة مرة أخرى لاحقاً.',
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showDialog({required String title, required String content}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title,
              style: const TextStyle(fontFamily: 'AvenirArabic'),
              textAlign: TextAlign.end),
          content: Text(content,
              style: const TextStyle(fontFamily: 'AvenirArabic'),
              textAlign: TextAlign.end),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('حسناً',
                  style: TextStyle(fontFamily: 'AvenirArabic')),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 133, 51),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("استعادة كلمة المرور",
            style: TextStyle(fontFamily: 'AvenirArabic', color: Colors.white)),
      ),
      body: Stack(
        children: [
          Background(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'ادخل ايميلك لكي نرسل لك رابط إعادة تعيين كلمة المرور',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 22, fontFamily: 'AvenirArabic'),
                      ),
                      const SizedBox(height: 30),
                      // Email TextField
                      TextField(
                        controller: _emailController,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'ادخل الايميل',
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontFamily: 'AvenirArabic'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 133, 51)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Reset Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : passwordReset,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 133, 51),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  'إعادة تعيين',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'AvenirArabic',
                                      color: Colors.white),
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
