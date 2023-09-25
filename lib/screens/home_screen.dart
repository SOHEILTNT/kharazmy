// ignore_for_file: must_be_immutable

import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:financial_management/constant.dart';
import 'package:financial_management/main.dart';
import 'package:financial_management/models/money.dart';
import 'package:financial_management/screens/about_us.dart';
import 'package:financial_management/screens/contact_with_us.dart';
import 'package:financial_management/screens/login_screen.dart';
import 'package:financial_management/screens/new_transactions_screen.dart';
import 'package:financial_management/screens/registation_screen.dart';
import 'package:flutter/material.dart';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:financial_management/utils/extension.dart';
import 'package:textfield_tags/textfield_tags.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static List<Money> moneys = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');
  @override
  void initState() {
    MyApp.getData();
    super.initState();
  }
  Widget body = HomeScreen();
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('پلتفرم حل مسئله خوارزمی'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        floatingActionButton: fabWidget(),

        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 33,
                  alignment: Alignment.topCenter, // Aligns the buttons to the top
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: Text('ورود'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistrationPage()),
                          );
                        },
                        child: Text('ثبت نام'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AboutUsPage()),
                          );
                        },
                        child: Text('درباره ما'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ContactWithUsPage()),
                          );
                        },
                        child: Text('ارتباط با ما'),
                      ),
                    ],
                  ),
                ),
              ),
              headerWidget(),
              //const Expanded(child: EmptyWidget()),
              Expanded(
                child: HomeScreen.moneys.isEmpty 
                ? const EmptyWidget() 
                : ListView.builder(
                  itemCount: HomeScreen.moneys.length,
                  itemBuilder: (context, index){
                    return GestureDetector(

                      //* Edit
                      onTap: (){
                        //
                        NewTransactionsScreen.date = 
                            HomeScreen.moneys[index].date;
                        //
                        NewTransactionsScreen.descriptionController.text = HomeScreen.moneys[index].title;
                        //
                        NewTransactionsScreen.priceController.text = HomeScreen.moneys[index].price;
                        //
                        NewTransactionsScreen.groupId = HomeScreen.moneys[index].isReceived ? 1 : 2;
                        //
                        NewTransactionsScreen.isEditing = true;
                        //
                        NewTransactionsScreen.id = HomeScreen.moneys[index].id;
                        //
                        NewTransactionsScreen.titleController.text = HomeScreen.moneys[index].mozoe;
                        //
                        NewTransactionsScreen.pasokhController.text = HomeScreen.moneys[index].pasokh;
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => 
                              const NewTransactionsScreen(),
                          ),
                        ).then((value){
                          MyApp.getData();
                          setState(() {});
                        });
                      },

                      //! Delete
                      onLongPress: (){
                        showDialog(
                          context: context, 
                          builder: (context)=> AlertDialog(
                            title: const Text('آیا از حذف این مورد مطمئن هستید ؟'),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actions: [
                              TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                }, 
                                child: const Text(
                                  'خیر',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black87,  
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: (){
                                  hiveBox.deleteAt(index);
                                  MyApp.getData();
                                  setState(() {});
                                  Navigator.pop(context);
                                }, 
                                child: const Text(
                                  'بله',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black87,  
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: MyListTileWidget(index: index,));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //! Fab Widget
  Widget fabWidget(){
  return FloatingActionButton(
    backgroundColor: kPurpleColor,
    elevation: 0,
    onPressed: (){
      NewTransactionsScreen.date = 'تاریخ ددلاین';
      NewTransactionsScreen.descriptionController.text = '';
      NewTransactionsScreen.priceController.text = '';
      NewTransactionsScreen.groupId = 0;
      NewTransactionsScreen.isEditing = false;
      NewTransactionsScreen.titleController.text='';
      NewTransactionsScreen.pasokhController.text='';
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context)=> const NewTransactionsScreen(),
        ),
      ).then((value){
        MyApp.getData();
        setState(() {
          print('Refresh');
        });
      });
    },
    child: const Icon(Icons.add),
  );
  }

//! Header Widget
Widget headerWidget(){
  return Padding(
      padding: const EdgeInsets.only(right: 20,top: 20,left: 5),
      child: Row(
        children: [
          Expanded(
            child: SearchBarAnimation(
              hintText: '... جستجو کنید',
              buttonElevation: 0,
              buttonShadowColour: Colors.black26,
              isOriginalAnimation: false,
              buttonBorderColour: Colors.black26,
              onCollapseComplete: (){
                MyApp.getData();
                searchController.text = '';
                setState(() {});
              },
              onFieldSubmitted: (String text){
                List<Money> result = hiveBox.values
                  .where(
                    (value) => value.title.contains(text) || 
                    value.date.contains(text),
                  )
                  .toList();
                HomeScreen.moneys.clear();
                
                setState(() {
                  for (var value in result) {
                    HomeScreen.moneys.add(value);
                  }
                });
              },
              textEditingController: searchController, 
              trailingWidget: Icon(Icons.search),
              buttonWidget: Icon(Icons.search),
              secondaryButtonWidget: Icon(Icons.close),
            ),
          ),
          const SizedBox(width: 10,),
          Text(
            'مسئله ها',
            style: TextStyle(
                fontSize: ScreenSize(context).screenWidth < 1000 
                      ? 18 
                      : ScreenSize(context).screenWidth * 0.015),
          ),
        ],
      ),
    );
}
}


//! My List Tile Widget
class MyListTileWidget extends StatelessWidget {
  
  final int index;
  const MyListTileWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: HomeScreen.moneys[index].isReceived ? kGreenColor : kRedColor,
              borderRadius: BorderRadius.circular(15),
            ),
            
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              HomeScreen.moneys[index].title,
              style: TextStyle(
                fontSize: ScreenSize(context).screenWidth < 1000 
                      ? 18 
                      : ScreenSize(context).screenWidth * 0.015),
            ),
          ),
          const Spacer(),
          Column(
              children: [
                Row(
                  children: [
                    Text(
                      HomeScreen.moneys[index].price,
                      style: TextStyle(
                        color: Colors.blue.shade600,
                          fontSize: ScreenSize(context).screenWidth < 1000 
                              ? 18 
                              : ScreenSize(context).screenWidth * 0.015),
                      ),
                  ],
                ),
                Text(
                  HomeScreen.moneys[index].date,
                  style: TextStyle(
                      fontSize: ScreenSize(context).screenWidth < 1000 
                          ? 15 
                          : ScreenSize(context).screenWidth * 0.013),
                  ),
              ],
          ),
        ],
      ),
    );
  }
}





//! Empty Widget
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        const Text('...مسئله ای موجود نیست',style: TextStyle(fontSize: 20),),
        const Spacer(),
      ],
    );
  }
}


