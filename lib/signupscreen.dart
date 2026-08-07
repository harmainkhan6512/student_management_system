import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'myhome.dart';
import 'loginscreen.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final Emailtext = TextEditingController();
  final Passwordltext = TextEditingController();
  bool flag = false;
  final supabaselogin = Supabase.instance.client;

  login_function() async {
    setState(() {
      flag = true;
    });
    try {
      final result = await supabaselogin.auth.signUp(
          email: Emailtext.text, password: Passwordltext.text);
      if (result.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('signUp Sucessfully!!!'),
          backgroundColor: Colors.green,
        ));
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => const MyHome()), (route) => false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
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
              controller: Passwordltext,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            flag ? const CircularProgressIndicator() : ElevatedButton(
                onPressed: () {
                  login_function();
                },
                child: const Text('Sign up', style: TextStyle(fontSize: 25))),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Loginscreen()));
                },
                child: const Text('you have already account?', style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}