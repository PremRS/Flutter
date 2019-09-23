
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/bloc_event/AuthenticationEvent.dart';
import 'package:my_app/bloc_state/AuthenticationState.dart';
import 'package:my_app/repository/UserRepository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{

  final UserRepository userRepo;

  AuthenticationBloc({@required this.userRepo})
  :assert(userRepo != null);
  
  @override
  AuthenticationState get initialState => AuthUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {

    if(event is AppStarted) {
      final bool hasToken = await userRepo.hasToken();

      if(hasToken){
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }

    if(event is LoggedIn){
      yield AuthLoading();
      await userRepo.persistToken(event.token);
      yield  AuthAuthenticated();
    }

    if(event is LoggedOut) {
      yield AuthLoading();
      await userRepo.deleteToken();
      yield AuthUnauthenticated();
    }
    
  }
  
}