import 'package:flutter_triple/flutter_triple.dart';

import '../../../../common/exceptions/failure.dart';

class CounterStore extends StreamStore<Exception, int> {
  CounterStore() : super(0);

  /// Add 1 to the current state.
  increment() {
    execute(() => _add(1));
  }

  /// Subtract 1 from the current state.
  decrement() {
    execute(() => _add(-1));
  }

  Future<int> _add(int value) async {
    final newValue = state + value;
    if (newValue > 5) {
      throw Failure('value must be < 5');
    } else if (newValue < 0) {
      throw Failure('value must be >= 0');
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
      return newValue;
    }
  }
}
