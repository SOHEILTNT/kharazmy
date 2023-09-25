import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('درباره ما'),
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
                'خوارزمی پلتفرمی برای هموار کردن راه شما در مسیر پیدا کردن پاسخ های مسائل شماست',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}