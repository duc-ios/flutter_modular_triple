import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_base/core/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../common/extensions/build_context_x.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../settings_routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.settings.tr())),
      body: ListView(
        children: [
          ListTile(
            title: Row(
              children: [
                Text(LocaleKeys.language.tr()),
                const Spacer(),
                Text(context.supportedLocales.first.languageCode.toUpperCase()),
                const SizedBox(width: 16),
                CupertinoSwitch(
                    value: context.locale == context.supportedLocales.last,
                    onChanged: (value) {
                      EasyLocalization.of(context)?.setLocale(value
                          ? context.supportedLocales.last
                          : context.supportedLocales.first);
                    }),
                const SizedBox(width: 16),
                Text(context.supportedLocales.last.languageCode.toUpperCase()),
              ],
            ),
          ),
          ListTile(
            title: Text(LocaleKeys.about.tr()),
            onTap: () => Modular.to.pushNamed('.${SettingsRoutes.about}'),
          ),
          ListTile(
            title: Text(LocaleKeys.terms_conditions.tr()),
            onTap: () =>
                Modular.to.pushNamed('.${SettingsRoutes.termsConditions}'),
          ),
          ListTile(
            title: Text(LocaleKeys.privacy_policies.tr()),
            onTap: () =>
                Modular.to.pushNamed('.${SettingsRoutes.privacyPolicies}'),
          ),
          ListTile(
            title: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) => state.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                authenticated: () => Text(
                  LocaleKeys.logout.tr(),
                ),
                unauthenticated: () => const SizedBox(),
              ),
            ),
            onTap: () => Modular.get<AuthCubit>().logout(),
          ),
          ListTile(
            title: FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  final version = snapshot.data?.version;
                  final buildNumber = snapshot.data?.buildNumber;

                  if (version != null && buildNumber != null) {
                    return Text(
                      LocaleKeys.version_x.tr(args: ['$version($buildNumber)']),
                      style: context.textTheme.caption,
                    );
                  }
                  return const SizedBox();
                }),
          ),
        ],
      ),
    );
  }
}
