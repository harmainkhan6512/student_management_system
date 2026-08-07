import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'loginscreen.dart';
import 'add_student.dart';
import 'view_students.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final logoutSupabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddStudent()));
              },
              child: const Text('Add Student', style: TextStyle(fontSize: 25)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewStudents()));
              },
              child: const Text('View Students', style: TextStyle(fontSize: 25)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await logoutSupabase.auth.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Loginscreen()),
                        (route) => false);
              },
              child: const Text('LogOut', style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}