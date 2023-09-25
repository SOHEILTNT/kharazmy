import 'package:financial_management/screens/home_screen.dart';
import 'package:financial_management/screens/main_screens.dart';
import 'package:financial_management/screens/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(RegistrationPage());
}

class RegistrationPage extends StatelessWidget {

  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController lastNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('ثبت نام'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: RegistrationForm(),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: RegistrationPage.firstNameController,
            decoration: InputDecoration(labelText: 'نام'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'لطفا نام خود را وارد کنید';
              }
              return null;
            },
            onSaved: (value) {
              _firstName = value!;
            },
          ),
          TextFormField(
            controller: RegistrationPage.lastNameController,
            decoration: InputDecoration(labelText: 'نام خانوادگی'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'لطفا نام خانوادگی خود را وارد کنید';
              }
              return null;
            },
            onSaved: (value) {
              _lastName = value!;
            },
          ),
          TextFormField(
            controller: RegistrationPage.emailController,
            decoration: InputDecoration(labelText: 'ایمیل'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'لطفا ایمیل خود را وارد کنید';
              }
              return null;
            },
            onSaved: (value) {
              _email = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'رمز ورود'),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'لطفا رمز ورود خود را وارد کنید';
              }
              return null;
            },
            onSaved: (value) {
              _password = value!;
            },
          ),
          SizedBox(height: 20.0),
          Center(
            child: SizedBox(
              width: 200,
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen()
                    ),
                  );
                },
                child: Text('ثبت نام'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}