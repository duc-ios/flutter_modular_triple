import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/extensions/build_context_x.dart';
import '../../../../../../common/extensions/int_duration.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../blocs/about_bloc.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.about.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<AboutBloc, AboutState>(builder: (context, state) {
          final bloc = context.read<AboutBloc>();
          return Column(
            children: [
              AnimatedSize(
                duration: 300.milliseconds,
                child: SizedBox(
                    height: state.when(show: () => null, hide: () => 0.0),
                    width: context.mediaQuery.size.width,
                    child: const Text(
                      '''
Aliquip consectetur anim est nostrud quis eu nisi nulla enim aliqua labore ad.
Magna nisi nulla do cillum sunt.
Id velit occaecat reprehenderit minim dolore ut in cupidatat culpa nostrud.
Cupidatat sint commodo est consequat sunt officia adipisicing cupidatat in.
                  ''',
                    )),
              ),
              OutlinedButton(
                onPressed: () => state.when(
                  show: () => bloc.add(const AboutEvent.hide()),
                  hide: () => bloc.add(const AboutEvent.show()),
                ),
                child: Icon(state.when(
                    show: () => Icons.visibility_off,
                    hide: () => Icons.visibility)),
              )
            ],
          );
        }),
      ),
    );
  }
}
