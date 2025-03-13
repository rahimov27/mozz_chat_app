abstract class SendEvent {}

class SendMessageEvent extends SendEvent {
  final String message;
  SendMessageEvent({required this.message});
}

class SendImageEvent extends SendEvent {
  final String imagePath; // Change the type to String for image path
  SendImageEvent({required this.imagePath});
}
