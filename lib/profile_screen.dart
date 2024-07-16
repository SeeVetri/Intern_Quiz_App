import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  Map<String, dynamic>? userData;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _fetchUserData();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user!.uid).get();
      if (userDoc.exists) {
        setState(() {
          userData = userDoc.data() as Map<String, dynamic>;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.purple[400],
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              ScaleTransition(
                scale: _scaleAnimation,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: userData!['profilePicture'] != null
                      ? NetworkImage(userData!['profilePicture'])
                      : AssetImage('assets/images/user_pic.png') as ImageProvider,
                ),
              ),
              SizedBox(height: 40),
              AnimatedOpacity(
                opacity: userData == null ? 0.0 : 1.0,
                duration: Duration(seconds: 1),
                child: Column(
                  children: [
                    ProfileDetailCard(
                      icon: Icons.person,
                      label: 'Username',
                      value: userData!['username'],
                    ),
                    ProfileDetailCard(
                      icon: Icons.person_outline,
                      label: 'First Name',
                      value: userData!['firstName'],
                    ),
                    ProfileDetailCard(
                      icon: Icons.person_outline,
                      label: 'Last Name',
                      value: userData!['lastName'],
                    ),
                    ProfileDetailCard(
                      icon: Icons.cake,
                      label: 'Birthdate',
                      value: userData!['birthdate'],
                    ),
                    ProfileDetailCard(
                      icon: Icons.phone,
                      label: 'Phone Number',
                      value: userData!['phoneNumber'],
                    ),
                    ProfileDetailCard(
                      icon: Icons.email,
                      label: 'Email',
                      value: userData!['email'],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileDetailCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ProfileDetailCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.purple),
            SizedBox(width: 10),
            Text(
              '$label: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Flexible(
              child: Text(
                value,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
