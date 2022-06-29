import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../generated/locale_keys.g.dart';
import '../../../../app/app_routes.dart';
import '../../../../auth/data/models/user_model.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          Text(
              LocaleKeys.hello.tr(namedArgs: {
                'name': (Hive.box('box').get('user') as UserModel).name
              }),
              style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Modular.to.pushNamed(AppRoutes.counter),
            child: Text(LocaleKeys.counter.tr()),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Modular.to.pushNamed(AppRoutes.settings),
            child: Text(LocaleKeys.settings.tr()),
          ),
        ],
      ),
    );
  }
}
