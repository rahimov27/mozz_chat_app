import 'package:hive/hive.dart';
part 'message_model.g.dart'; // Эта строка нужна для генерации

@HiveType(typeId: 0) // Уникальный ID для типа
class Message {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final String timeStamp;

  @HiveField(2)
  final String? imagePath;

  Message({required this.text, required this.timeStamp, this.imagePath});
}
