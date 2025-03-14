abstract class SendEvent {}

class SendMessageEvent extends SendEvent {
  final String message;
  final String? imagePath;
  SendMessageEvent({required this.message, this.imagePath});
}

class SendImageEvent extends SendEvent {
  final String imagePath;
  SendImageEvent({required this.imagePath});
}
