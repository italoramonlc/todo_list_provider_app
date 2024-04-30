import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';
import 'package:todo_list_provider/app/services/user/user_service_impl.dart';

import '../../../core/ui/messages.dart';

class LoginController extends DefaultChangeNotifier {

  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
  : _userService = userService;

  bool get hasInfo => infoMessage != null;

  void login(String email,String password) async{
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.login(email, password);
      if(user != null){
        success();
      }else{
        setError('Usuário ou senha inválidos');
      }
    } on AuthException catch (e) {
      setError(e.message);
    }finally{
      hideLoading();
      notifyListeners();
    }
  }

  void forgotPassword(String email)async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Resete de senha enviado para o seu e-mail!';
    } catch (e) {
      setError('Erro ao resetar a senha');
    }finally{
      hideLoading();
      notifyListeners();
    }
  }

}
