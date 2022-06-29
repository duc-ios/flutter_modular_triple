import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../../../app/app_routes.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key) {
    fetchAll();
  }

  fetchAll() async {
    await Future.delayed(const Duration(milliseconds: 10));

    Modular.get<AuthCubit>().state.whenOrNull(
          authenticated: () => Modular.to.navigate(AppRoutes.home),
          unauthenticated: () => Modular.to.navigate(AppRoutes.login),
        );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
