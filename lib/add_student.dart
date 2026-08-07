import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final deptController = TextEditingController();
  final emailController = TextEditingController();
  final semesterController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;
  final supabase = Supabase.instance.client;

  insertStudent() async {
    setState(() {
      isLoading = true;
    });
    try {
      await supabase.from('student').insert({
        'name': nameController.text,
        'roll_number': rollController.text,
        'department': deptController.text,
        'email': emailController.text,
        'Semester': semesterController.text,
        'Address': addressController.text,
        'Phone Number': phoneController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Student Added Successfully!'),
        backgroundColor: Colors.green,
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Column(
          children: [
            Text('Student Management', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Text('System', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(hintText: 'Enter Name', border: OutlineInputBorder())),
              const SizedBox(height: 15),
              TextField(controller: rollController, decoration: const InputDecoration(hintText: 'Enter Roll Number', border: OutlineInputBorder())),
              const SizedBox(height: 15),
              TextField(controller: deptController, decoration: const InputDecoration(hintText: 'Enter Department', border: OutlineInputBorder())),
              const SizedBox(height: 15),
              TextField(controller: emailController, decoration: const InputDecoration(hintText: 'Enter Email', border: OutlineInputBorder())),
              const SizedBox(height: 15),
              TextField(controller: semesterController, decoration: const InputDecoration(hintText: 'Enter Semester', border: OutlineInputBorder())),
              const SizedBox(height: 15),
              TextField(controller: addressController, decoration: const InputDecoration(hintText: 'Enter Address', border: OutlineInputBorder())),
              const SizedBox(height: 15),
              TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  decoration: const InputDecoration(hintText: 'Enter Phone Number',
                      border: OutlineInputBorder())),
              const SizedBox(height: 25),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: insertStudent,
                child: const Text('Save Student', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}