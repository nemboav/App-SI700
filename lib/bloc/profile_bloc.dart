import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trabalho_01/model/user_profile.dart';
import 'package:trabalho_01/provider/user_provider.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(InsertState(userList: [])) {
    on<SubmitEvent>((event, emit) {
      UserProvider.helper.insertUser(event.userProfile);
    });
    on<DeleteEvent>((event, emit) {
      UserProvider.helper.deletetUser(event.cpf);
    });

    on<GetUserListEvent>((event, emit) async {
      List<UserProfile> userList = await UserProvider.helper.getUserList();
      emit(InsertState(userList: userList));
    });
  }
}

/*
 EVENTOS
 */
abstract class ProfileEvent {}

class SubmitEvent extends ProfileEvent {
  UserProfile userProfile;
  SubmitEvent({required this.userProfile});
}

class DeleteEvent extends ProfileEvent {
  String cpf;
  DeleteEvent({required this.cpf});
}

class GetUserListEvent extends ProfileEvent {}

/*
Estados
 */
abstract class ProfileState {}

class InsertState extends ProfileState {
  List<UserProfile> userList;
  InsertState({required this.userList});
}
