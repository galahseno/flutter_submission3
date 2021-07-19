import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:submission_1/bloc/detail/detail_bloc.dart';
import 'package:submission_1/data/source/repository.dart';

import '../mock_repository.dart';

@GenerateMocks([Repository])
void main() {
  var repository = MockRepository();

  group('Detail Bloc Test ', () {
    blocTest(
      'Initial bloc',
      build: () => DetailBloc(repository),
      expect: () => [],
    );
    blocTest(
      'Loading Detail Restaurant',
      build: () => DetailBloc(repository),
      act: (bloc) => (bloc as DetailBloc).add(
        DetailInitialEvent(),
      ),
      expect: () => [isA<DetailInitial>()],
    );
  });
}
