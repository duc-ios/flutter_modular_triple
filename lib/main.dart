import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'modules/app/app_module.dart';
import 'modules/app/app_routes.dart';
import 'modules/app/app_widget.dart';
import 'modules/auth/data/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Hive.registerAdapter(UserModelAdapter());
  await Hive.initFlutter();
  await Hive.openBox('box');

  TripleObserver.addListener((triple) {
    debugPrint(triple.toString());
  });

  final authCubit = AuthCubit();

  authCubit.stream.listen(
    (state) => state.whenOrNull(
      authenticated: () => Modular.to.navigate(AppRoutes.home),
      unauthenticated: () => Modular.to.navigate(AppRoutes.login),
    ),
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      fallbackLocale: const Locale('en'),
      path: 'assets/i18n',
      child: BlocProvider(
        create: (context) => authCubit,
        child: ModularApp(
          module: AppModule(authCubit),
          child: const AppWidget(),
        ),
      ),
    ),
  );
}
