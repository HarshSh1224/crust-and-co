import 'package:bloc/bloc.dart';
import 'package:crust_and_co/constants/app_language.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepository;

  SignUpBloc(this.userRepository) : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcessing());
      try {
        final success =
            await userRepository.signUp(event.myUser, event.password);
        if (success) {
          emit(SignUpSuccess());
        } else {
          emit(SignUpError(message: AppLanguage.signUpFailed));
        }
      } on ApiException catch (e) {
        emit(SignUpError(message: e.message!));
      }
    });
  }
}
