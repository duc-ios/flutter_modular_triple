import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../stores/counter_store.dart';
import '../stores/tap_store.dart';

class CounterController extends Disposable {
  CounterController() {
    final counterErrorStream = counterStore.selectError;
    final tapErrorStream = tapStore.selectError;
    final result = Rx.merge([
      counterErrorStream,
      tapErrorStream,
    ]);
    result.listen((error) {
      asuka.showDialog(
          builder: (context) => AlertDialog(
                backgroundColor: Colors.redAccent,
                content: Text(
                  error.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.white),
                ),
              ));
    });
  }
  final counterStore = CounterStore();
  final tapStore = TapStore();

  @override
  void dispose() {
    counterStore.destroy();
    tapStore.destroy();
  }
}
