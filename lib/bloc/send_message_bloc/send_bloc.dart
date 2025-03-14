import 'package:bloc/bloc.dart';
import 'package:mozz_chat_app/bloc/send_message_bloc/send_event.dart';
import 'package:mozz_chat_app/bloc/send_message_bloc/send_state.dart';

class SendBloc extends Bloc<SendEvent, SendState> {
  SendBloc() : super(SendMessageInitial()) {
    on<SendMessageEvent>((event, emit) async {
      emit(SendMessageLoading());

      if (event.imagePath != null) {
        // if image present, send our message with image
        emit(
          SendMessageSuccess(
            successMessage: event.message,
            isImage: true,
            imagePath: event.imagePath,
          ),
        );
      } else {
        // if we don't have image, just send the message
        emit(SendMessageSuccess(successMessage: event.message, isImage: false));
      }
    });

    on<SendImageEvent>((event, emit) {
      try {
        emit(
          SendMessageSuccess(successMessage: event.imagePath, isImage: true),
        );
      } catch (e) {
        emit(SendMessageError(error: "Ошибка при загрузке фото"));
      }
    });
  }
}
