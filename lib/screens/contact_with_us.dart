import 'package:flutter/material.dart';

class ContactWithUsPage extends StatelessWidget {
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ارتباط با ما'),
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
                'نام توسعه دهنده : سهیل عباسی ورزقانی',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '09916284117 : تلفن',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '09359458448         ',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'soheil.abbasi.v@gmail.com : ایمیل',
                style: TextStyle(fontSize: 20),
              ), 
              Text(
                'آدرس : دانشکده هوافضا دانشگاه خواجه نصیر الدین طوسی ، خوابگاه دانش 1',
                style: TextStyle(fontSize: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}