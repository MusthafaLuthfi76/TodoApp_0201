import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> tasks = [];
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _addTask() {
    setState(() {
        tasks.add({
          'title': nameController.text,
          'deadline': selectedDate!,
          'done': false,
        });
        nameController.clear();
        selectedDate = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task Added!')),
      );
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      tasks[index]['done'] = !tasks[index]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Form Page',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Task Date:', style: TextStyle(fontSize: 18)),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Row(
                  children: [
                    Text(
                      selectedDate == null
                          ? 'Select a date'
                          : DateFormat('dd-MM-yyyy').format(selectedDate!),
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    SizedBox(width: 250),
                    Icon(Icons.calendar_today, color: Colors.blue, ),
                  ],
                ),
              ),
              if (selectedDate == null)
                Text(
                  'Please select a date',
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a task name';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: 'Enter your first name',
                          border: OutlineInputBorder(),
                          label: Text("First Name")
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _addTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ],
      ),)),
    );
  }
}