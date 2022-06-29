import 'package:bloc/bloc.dart';
import 'package:flutter_modular_base/common/extensions/int_duration.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../modules/auth/data/models/user_model.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super((Hive.box('box').get('user') is UserModel)
            ? const AuthState.authenticated()
            : const AuthState.unauthenticated());

  void set(UserModel user) {
    Hive.box('box').put('user', user);
    emit(const AuthState.authenticated());
  }

  void logout() async {
    emit(const AuthState.loading());
    await Future.delayed(1.seconds);
    Hive.box('box').delete('user');
    emit(const AuthState.unauthenticated());
  }
}
