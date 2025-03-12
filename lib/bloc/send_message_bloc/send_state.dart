abstract class SendState {}

class SendMessageInitial extends SendState {}

class SendMessageLoading extends SendState {}

class SendMessageSuccess extends SendState {
  final String successMessage;
  SendMessageSuccess({required this.successMessage});
}

class SendMessageError extends SendState {
  final String error;
  SendMessageError({required this.error});
}
