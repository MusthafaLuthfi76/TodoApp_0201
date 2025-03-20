import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> tasks = [];

  void addData() {
    setState(() {
      tasks.add(nameController.text);
    });
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}