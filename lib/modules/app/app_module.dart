import 'package:flutter_modular/flutter_modular.dart';

import '../../core/presentation/cubits/auth_cubit/auth_cubit.dart';
import '../auth/presentation/ui/auth_page.dart';
import '../counter/presentation/controllers/counter_controller.dart';
import '../counter/presentation/ui/counter_page.dart';
import '../home/presentation/ui/home_page.dart';
import '../settings/settings_module.dart';
import '../splash/presentation/ui/splash_page.dart';
import 'app_routes.dart';

class AppModule extends Module {
  final AuthCubit authCubit;
  AppModule(this.authCubit);

  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<AuthCubit>((_) => authCubit),
        Bind.instance<CounterController>(CounterController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => SplashPage()),
        ChildRoute(AppRoutes.login, child: (_, args) => const AuthPage()),
        ChildRoute(AppRoutes.home, child: (_, args) => const HomePage()),
        ChildRoute(AppRoutes.counter, child: (_, args) => CounterPage()),
        ModuleRoute(AppRoutes.settings, module: SettingsModule())
      ];
}
