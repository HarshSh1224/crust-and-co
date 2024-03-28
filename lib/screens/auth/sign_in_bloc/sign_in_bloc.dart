import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;
  SignInBloc(this.userRepository) : super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcessing());
      try {
        final success =
            await userRepository.signIn(event.email, event.password);
        if (success) {
          emit(SignInSuccess());
        } else {
          emit(const SignInError(message: 'Sign in failed'));
        }
      } on ApiException catch (e) {
        emit(SignInError(message: e.message!));
      }
    });
  }
}
