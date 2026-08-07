import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'signupscreen.dart';
import 'myhome.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final Emailtext = TextEditingController();
  final Passwordtext = TextEditingController();
  bool flag = false;
  final supabaselogin = Supabase.instance.client;

  loginfunction() async {
    setState(() {
      flag = true;
    });
    try {
      final result = await supabaselogin.auth.signInWithPassword(
          email: Emailtext.text, password: Passwordtext.text);
      if (result.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MyHome()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        flag = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: 90,
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              'Student Management',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              'System',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: Emailtext,
              decoration: const InputDecoration(
                hintText: 'Enter Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: Passwordtext,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            flag
                ? const CircularProgressIndicator()
                : ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                loginfunction();
              },
              child: const Text('Sign in', style: TextStyle(fontSize: 25)),
            ),
            const SizedBox(height: 20),
            const Text(
              'you have no account? Then SignUp first',
              style: TextStyle(fontSize: 17, color: Colors.red),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Signupscreen()));
              },
              child: const Text('Sign Up', style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}