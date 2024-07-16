import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'username': _usernameController.text,
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'birthdate': _birthdateController.text,
          'phoneNumber': _phoneNumberController.text,
          'email': _emailController.text,
          'createdAt': FieldValue.serverTimestamp(),
        });

        Navigator.pop(context); // Navigate back after successful registration
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdateController.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              Center(
                child: Image.asset(
                  'assets/images/quiz_logo.jpg', // Replace with your app logo image path
                  width: 90,
                  height: 90,
                ),
              ),
              SizedBox(height: 20),
              _buildBoxedTextField('Email', _emailController),
              SizedBox(height: 10),
              _buildBoxedTextField('Password', _passwordController, isPassword: true),
              SizedBox(height: 10),
              _buildBoxedTextField('Username', _usernameController),
              SizedBox(height: 10),
              _buildBoxedTextField('First Name', _firstNameController),
              SizedBox(height: 10),
              _buildBoxedTextField('Last Name', _lastNameController),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: _buildBoxedTextField('Birthdate', _birthdateController),
                ),
              ),
              SizedBox(height: 10),
              _buildBoxedTextField('Phone Number', _phoneNumberController, keyboardType: TextInputType.phone),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBoxedTextField(String label, TextEditingController controller, {bool isPassword = false, TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: label,
          border: InputBorder.none,
        ),
        obscureText: isPassword,
        keyboardType: keyboardType,
      ),
    );
  }
}
