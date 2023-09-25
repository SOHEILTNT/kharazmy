import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  ProfilePage({required this.firstName,required this.lastName,required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('حساب کاربری'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'نام: $firstName',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'نام خانوادگی: $lastName',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '$email :ایمیل',
                style: TextStyle(fontSize: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}