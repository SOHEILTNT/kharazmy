import 'dart:math';
import 'package:financial_management/utils/extension.dart';
import 'package:financial_management/constant.dart';
import 'package:financial_management/models/money.dart';
import 'package:financial_management/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../main.dart';

class NewTransactionsScreen extends StatefulWidget {
  const NewTransactionsScreen({super.key});
  static int groupId = 0;
  static TextEditingController descriptionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static TextEditingController titleController = TextEditingController();
  static TextEditingController pasokhController = TextEditingController();
  static bool isEditing = false;
  static int id = 0;
  static String date = 'تاریخ ددلاین';
  @override
  State<NewTransactionsScreen> createState() => _NewTransactionsScreenState();
}

class _NewTransactionsScreenState extends State<NewTransactionsScreen> {
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                NewTransactionsScreen.isEditing 
                    ? 'ویرایش مسئله' 
                    : 'مسئله جدید',
                style: TextStyle(
                  fontSize: ScreenSize(context).screenWidth < 900 
                      ? 17 
                      : ScreenSize(context).screenWidth * 0.013),
              ),
              MyTextField(
                hintText: 'نام مسئله',
                controller: NewTransactionsScreen.descriptionController,
              ),
              MyTextField(
                hintText: 'موضوع مسئله',
                type: TextInputType.number,
                controller: NewTransactionsScreen.priceController,
              ),
              MyTextField(
                hintText: 'توضیحات',
                type: TextInputType.number,
                controller: NewTransactionsScreen.titleController,
              ),
              MyTextField(
                hintText: 'پاسخ مسئله',
                type: TextInputType.number,
                controller: NewTransactionsScreen.pasokhController,
              ),
              SizedBox(height: 25,),
              const TypeAndDateWidget(),
              const SizedBox(height: 25,),
              MyButton(
                text: NewTransactionsScreen.isEditing ? 'ویرایش کردن' : 'اضافه کردن مسئله',
                onPressed: (){
                  Money item = Money(
                        id: Random().nextInt(99999999), 
                        title: NewTransactionsScreen.descriptionController.text, 
                        price: NewTransactionsScreen.priceController.text, 
                        date: NewTransactionsScreen.date, 
                        isReceived: NewTransactionsScreen.groupId == 1 ? true : false,
                        mozoe: NewTransactionsScreen.titleController.text,
                        pasokh: NewTransactionsScreen.pasokhController.text,
                  );
                  if(NewTransactionsScreen.isEditing){
                    int index = 0;
                    MyApp.getData();
                    for (int i = 0; i < hiveBox.values.length; i++) {
                      if(hiveBox.values.elementAt(i).id == 
                          NewTransactionsScreen.id){
                        index = i;
                      }
                    }
                    print(index);
                    hiveBox.putAt(index, item);
                  }
                  else{
                    //HomeScreen.moneys.add(item);
                    hiveBox.add(item);
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//! My Button Widget
class MyButton extends StatelessWidget {


  final String text;
  final Function() onPressed;
  const MyButton({super.key, required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: kPurpleColor,
          elevation: 0,
        ),
        onPressed: onPressed, 
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

//! Type And Date Widget
class TypeAndDateWidget extends StatefulWidget{
  const TypeAndDateWidget ({
    Key? key,
  }) : super(key: key);

  @override
  State<TypeAndDateWidget> createState() => _TypeAndDateWidgetState();
}

class _TypeAndDateWidgetState extends State<TypeAndDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: MyRadioButton(
            value: 1,
            groupValue: NewTransactionsScreen.groupId,
            onChanged: (value){
              setState(() {
                NewTransactionsScreen.groupId = value!;
              });
            },
            text: 'پاسخ دادن به مسئله',
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: MyRadioButton(
            value: 2,
            groupValue: NewTransactionsScreen.groupId,
            onChanged: (value){
              setState(() {
                NewTransactionsScreen.groupId = value!;
              });
            },
            text: 'طرح کردن مسئله',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () async {
                var pickedDate = await showPersianDatePicker(
                  context: context, 
                  initialDate: Jalali.now(), 
                  firstDate: Jalali(1400), 
                  lastDate: Jalali(1499),
                );
                setState(() {
                  String year = pickedDate!.year.toString();
                  //
                  String month = pickedDate.month.toString().length == 1 
                      ? '0${pickedDate.month.toString()}' 
                      : pickedDate.month.toString();
                  //
                  String day = pickedDate.day.toString().length == 1 
                      ? '0${pickedDate.day.toString()}' 
                      : pickedDate.day.toString();
                  //
                  NewTransactionsScreen.date = year + '/' + month + '/' + day;
                });
              }, 
              child: Text(
                NewTransactionsScreen.date == 'تاریخ ددلاین'
                ? 'تاریخ ددلاین'
                : NewTransactionsScreen.date,
                style: TextStyle(
                  fontSize: ScreenSize(context).screenWidth < 900 
                      ? 19 
                      : ScreenSize(context).screenWidth * 0.015),
              ),
            ),
          ),
        ),
      ],
    );
  }
}



//! My Radio Button
class MyRadioButton extends StatelessWidget {
  

  final int value;
  final int groupValue;
  final Function(int?) onChanged;
  final String text;

  const MyRadioButton({
    super.key, 
    required this.value, 
    required this.groupValue, 
    required this.onChanged, 
    required this.text});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Radio(
            activeColor: kPurpleColor,
            value: value, 
            groupValue: groupValue, 
            onChanged: onChanged,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                    fontSize: ScreenSize(context).screenWidth < 900 
                        ? 17 
                        : ScreenSize(context).screenWidth * 0.013),
          ),
        ),
      ],
    );
  }
}


//! My Text Field Widget
class MyTextField extends StatelessWidget {
  
  final String hintText;
  final TextInputType type;
  final TextEditingController controller;
  const MyTextField({
    super.key, 
    required this.hintText,
    required this.controller,
    this.type = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: 5,
      controller: controller,
      keyboardType: type,
      cursorColor: Colors.blue.shade400,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
                      fontSize: ScreenSize(context).screenWidth < 900 
                          ? 17 
                          : ScreenSize(context).screenWidth * 0.013),
      ),
    );
  }
}