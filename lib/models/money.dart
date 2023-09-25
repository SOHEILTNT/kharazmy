import 'package:hive/hive.dart';

part 'money.g.dart';

@HiveType(typeId: 0)
class Money{
  @HiveField(1)
  int id;
  @HiveField(2)
  String title;
  @HiveField(3)
  String price;
  @HiveField(4)
  String date;
  @HiveField(5)
  bool isReceived;
  @HiveField(6)
  String mozoe;
  @HiveField(7)
  String pasokh;

  Money({
    required this.id,
    required this.title,
    required this.price,
    required this.date,
    required this.isReceived,
    required this.mozoe,
    required this.pasokh,
  });
}