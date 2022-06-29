import 'package:flutter_triple/flutter_triple.dart';

import '../../../../common/exceptions/failure.dart';

class TapStore extends StreamStore<Exception, int> {
  TapStore() : super(0);

  tap() {
    update(state + 1);
    if (state > 10) {
      setError(Failure('Too many tap!'));
    }
  }
}
