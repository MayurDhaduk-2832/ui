import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/screens/print_data.dart';
import 'package:ui/screens/splash_screen.dart';
import '../app_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passVisible = false;
  var emailControl = TextEditingController();
  var passControl = TextEditingController();
  bool evalidate = false;
  bool pvalidate = false;

  void initstate() {
    super.initState();
    passVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/1.png',
                    scale: 5,
                  ),
                  Text(
                    'Leafboard',
                    style: TextStyle(
                        color: Colors.black, fontSize: AppLayout.getHeight(30)),
                  )
                ],
              ),
            ),
            const Center(
              child: Text(
                'Work Without Limits',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: AppLayout.getHeight(30),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                'Your Email address',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailControl,
                decoration: InputDecoration(
                    errorText: evalidate ? "Enter Your Email" : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                'Choose a password',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: passControl,
                obscureText: !passVisible,
                decoration: InputDecoration(
                    errorText: pvalidate ? "Enter Your Password" : null,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            passVisible = !passVisible;
                          });
                        },
                        icon: Icon(!passVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            InkWell(
              onTap: () async {
                emailControl.text.isEmpty
                    ? evalidate = true
                    : evalidate = false;
                passControl.text.isEmpty ? pvalidate = true : pvalidate = false;
                if (!evalidate && !pvalidate) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrintData(),
                      ));
                  var sharedPref = await SharedPreferences.getInstance();
                  sharedPref.setBool(SplashScreenState.LOGINKEY, true);
                  setState(() {});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Please Enter Your Details')));
                  setState(() {});
                }
              },
              child: Center(
                child: Container(
                  height: AppLayout.getHeight(40),
                  width: AppLayout.getWidth(300),
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(child: Text('Continue')),
                ),
              ),
            ),
            SizedBox(
              height: AppLayout.getHeight(15),
            ),
            const Center(child: Text('or')),
            SizedBox(
              height: AppLayout.getHeight(10),
            ),
            InkWell(
              onTap: () {},
              child: Center(
                child: Container(
                  height: AppLayout.getHeight(40),
                  width: AppLayout.getWidth(300),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                      child: Text(
                    'Sign up with Google',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Center(
                child: Container(
                  height: AppLayout.getHeight(40),
                  width: AppLayout.getWidth(300),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                      child: Text(
                    'Sign up with Apple',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
