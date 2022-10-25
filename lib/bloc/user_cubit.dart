import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState(User.empty));

  void authenticated(User user) {
    emit(UserState(user));
  }

  void unauthenticated() {
    emit(UserState(User.empty));
  }
}
