import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../generated/locale_keys.g.dart';
import '../controllers/counter_controller.dart';

class CounterPage extends StatelessWidget {
  CounterPage({Key? key}) : super(key: key);

  final _controller = Modular.get<CounterController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.counter.tr())),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TripleBuilder(
              store: _controller.counterStore,
              builder: (_, triple) {
                if (triple.isLoading) {
                  return const CircularProgressIndicator();
                }
                return Text('value: ${triple.state}',
                    style: textTheme.headline2);
              }),
          ScopedBuilder(
              store: _controller.tapStore,
              onState: (_, state) =>
                  Text('tap: $state', style: textTheme.headline2))
        ]),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'counterView_increment_floatingActionButton',
            child: const Icon(Icons.add),
            onPressed: () {
              _controller.tapStore.tap();
              _controller.counterStore.increment();
            },
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'counterView_decrement_floatingActionButton',
            child: const Icon(Icons.remove),
            onPressed: () {
              _controller.tapStore.tap();
              _controller.counterStore.decrement();
            },
          ),
        ],
      ),
    );
  }
}
