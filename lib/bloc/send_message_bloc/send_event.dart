abstract class SendEvent {}

class SendMessageEvent extends SendEvent {
  final String message;
  SendMessageEvent({required this.message});
}
