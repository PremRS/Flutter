
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/bloc/AuthenticationBloc.dart';
import 'package:my_app/bloc_event/AuthenticationEvent.dart';
import 'package:my_app/bloc_event/LoginEvent.dart';
import 'package:my_app/bloc_state/LoginState.dart';
import 'package:my_app/repository/UserRepository.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  
  final UserRepository userRepo;
  final AuthenticationBloc authBloc;

  LoginBloc(
    {
      @required this.userRepo,
      @required this.authBloc,
    })
  :assert(userRepo != null),
   assert(authBloc != null);
  
  
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    
    if(event is LoginAttempt){
      
      yield LoginLoading();

      try{
        final token = await userRepo.authenticate(
          username: event.username,
          password: event.password
        );
          
        authBloc.dispatch(LoggedIn(token:token));
      } catch(error) {
        yield LoginUnsuccessful(error : error.toString());
      }
    }
  }
  
}