abstract class SendState {}

class SendMessageInitial extends SendState {}

class SendMessageLoading extends SendState {}

class SendMessageSuccess extends SendState {
  final String successMessage;
  final bool isImage;
  final String? imagePath;

  SendMessageSuccess({
    required this.successMessage,
    required this.isImage,
    this.imagePath,
  });
}

class SendMessageError extends SendState {
  final String error;
  SendMessageError({required this.error});
}
