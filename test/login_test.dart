import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/class/crud.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/core/class/statusrequest.dart';
import 'package:task_manager/core/constants/apilinks.dart';

class MockCrud extends Mock implements Crud {
  @override
  Future<Either<StatusRequest, Map<String, dynamic>>?> postData(
      String linkurl, Map data, bool putORpost) async {
    return const Right({});
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCrud mockCrud;

  setUp(() {
    mockCrud = MockCrud();
  });

  test('gettasks - Success', () async {
    // Arrange
    const username = 'kminchelle';
    const password = '0lelplR';
    // Act
    final response = await mockCrud.postData(
        ApiLink.login, {"username": username, "password": password}, true);

    // Assert
    expect(response, isA<Right<StatusRequest, Map<String, dynamic>>>());
  });
}
