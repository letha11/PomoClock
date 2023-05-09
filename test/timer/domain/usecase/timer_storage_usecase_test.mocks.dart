// Mocks generated by Mockito 5.4.0 from annotations
// in pomodoro_timer/test/timer/domain/usecase/timer_storage_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:pomodoro_timer/timer/domain/entity/timer_entity.dart' as _i4;
import 'package:pomodoro_timer/timer/domain/repository/timer_storage_repository.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [TimerStorageRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTimerStorageRepository extends _i1.Mock
    implements _i2.TimerStorageRepository {
  @override
  _i3.Stream<_i4.TimerEntity> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i3.Stream<_i4.TimerEntity>.empty(),
        returnValueForMissingStub: _i3.Stream<_i4.TimerEntity>.empty(),
      ) as _i3.Stream<_i4.TimerEntity>);
  @override
  void add(_i4.TimerEntity? timer) => super.noSuchMethod(
        Invocation.method(
          #add,
          [timer],
        ),
        returnValueForMissingStub: null,
      );
}
