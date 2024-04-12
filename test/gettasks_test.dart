import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/class/crud.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/core/class/statusrequest.dart';

class MockCrud extends Mock implements CrudGet {
  @override
  Future<Either<StatusRequest, Map<String, dynamic>>?> getData(
      String linkurl) async {
    return const Right({});
  }
}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCrud mockCrud;

  setUp(() {
    mockCrud = MockCrud();
  });

  test('gettasks - Success', () async {
    // Arrange
    const limit = 10;
    const skip = 0;
    // Act
    final response = await mockCrud
        .getData('https://dummyjson.com/todos?limit=$limit&skip=$skip');

    // Assert
    expect(response, isA<Right<StatusRequest, Map<String, dynamic>>>());
  });
}
