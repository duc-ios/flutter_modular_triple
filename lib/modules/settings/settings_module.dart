import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../generated/locale_keys.g.dart';
import 'modules/about/presentation/blocs/about_bloc.dart';
import 'modules/about/presentation/ui/about_page.dart';
import 'modules/supportive/ui/supportive_page.dart';
import 'presentation/ui/settings_page.dart';
import 'settings_routes.dart';

class SettingsModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => const SettingsPage(),
        ),
        ChildRoute(
          SettingsRoutes.about,
          child: (_, args) => BlocProvider(
            create: (context) => AboutBloc(),
            child: const AboutPage(),
          ),
        ),
        ChildRoute(
          SettingsRoutes.termsConditions,
          child: (_, args) => SupportivePage(
            title: LocaleKeys.terms_conditions.tr(),
            content: LocaleKeys.terms_conditions.tr(),
          ),
        ),
        ChildRoute(
          SettingsRoutes.privacyPolicies,
          child: (_, args) => SupportivePage(
            title: LocaleKeys.privacy_policies.tr(),
            content: LocaleKeys.privacy_policies.tr(),
          ),
        ),
      ];
}
