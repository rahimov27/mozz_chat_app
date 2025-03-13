abstract class SendState {}

class SendMessageInitial extends SendState {}

class SendMessageLoading extends SendState {}

class SendMessageSuccess extends SendState {
  final dynamic successMessage;
  final bool isImage;

  SendMessageSuccess({required this.successMessage, this.isImage = false});
}

class SendMessageError extends SendState {
  final String error;
  SendMessageError({required this.error});
}
