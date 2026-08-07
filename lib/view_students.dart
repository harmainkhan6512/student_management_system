import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({super.key});

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  final supabase = Supabase.instance.client;

  Future<List<dynamic>> getStudents() async {
    final response = await supabase.from('student').select();
    return response as List<dynamic>;
  }

  deleteStudent(var id) async {
    try {
      await supabase.from('student').delete().eq('id', id);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Student Deleted Successfully!'),
        backgroundColor: Colors.red,
      ));
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: Colors.red));
    }
  }

  showEditDialog(Map student) {
    final nameEdit = TextEditingController(text: student['name']);
    final rollEdit = TextEditingController(text: student['roll_number']);
    final deptEdit = TextEditingController(text: student['department']);
    final emailEdit = TextEditingController(text: student['email']);
    final semesterEdit = TextEditingController(text: student['Semester']?.toString() ?? '');
    final addressEdit = TextEditingController(text: student['Address']?.toString() ?? '');
    final phoneEdit = TextEditingController(text: student['Phone Number']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Student Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameEdit, decoration: const InputDecoration(hintText: 'Edit Name', border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextField(controller: rollEdit, decoration: const InputDecoration(hintText: 'Edit Roll Number', border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextField(controller: deptEdit, decoration: const InputDecoration(hintText: 'Edit Department', border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextField(controller: emailEdit, decoration: const InputDecoration(hintText: 'Edit Email', border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextField(controller: semesterEdit, decoration: const InputDecoration(hintText: 'Edit Semester', border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextField(controller: addressEdit, decoration: const InputDecoration(hintText: 'Edit Address', border: OutlineInputBorder())),
              const SizedBox(height: 10),
              TextField(controller: phoneEdit,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  decoration: const InputDecoration(hintText: 'Edit Phone Number', border: OutlineInputBorder())),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () async {
              try {
                await supabase.from('student').update({
                  'name': nameEdit.text,
                  'roll_number': rollEdit.text,
                  'department': deptEdit.text,
                  'email': emailEdit.text,
                  'Semester': semesterEdit.text,
                  'Address': addressEdit.text,
                  'Phone Number': phoneEdit.text,
                }).eq('id', student['id']);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Student Updated Successfully!'),
                  backgroundColor: Colors.blue,
                ));
                setState(() {});
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
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
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<dynamic>>(
          future: getStudents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No students found.'));
            }
            final students = snapshot.data!;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(student['name'] != null && student['name'].isNotEmpty ? student['name'][0].toUpperCase() : 'S')),
                  title: Text(student['name'] ?? ''),
                  subtitle: Text('Roll: ${student['roll_number'] ?? ''} | Sem: ${student['Semester'] ?? ''}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => showEditDialog(student),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteStudent(student['id']),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}