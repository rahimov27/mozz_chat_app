abstract class SendEvent {}

class SendMessageEvent extends SendEvent {
  final String message;
  final String? imagePath; // Опциональное поле для пути к изображению
  SendMessageEvent({required this.message, this.imagePath});
}

class SendImageEvent extends SendEvent {
  final String imagePath; // Передаем путь к изображению
  SendImageEvent({required this.imagePath});
}
