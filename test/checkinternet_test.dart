import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';

Future<bool> checkInternet() async {
  var connectivityResult = [ConnectivityResult.mobile, ConnectivityResult.wifi];
  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.wifi)) {
    return true;
  } else {
    return false;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('return true', () async {
    final result = await checkInternet();
    const expectedresult = true;
    expect(result, expectedresult);
  });
}
