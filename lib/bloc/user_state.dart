part of 'user_cubit.dart';


class UserState extends Equatable {
  User user;
  UserState(this.user);

  @override
  List<Object> get props => [user];
}
