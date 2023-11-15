import 'package:get_it/get_it.dart';
import 'package:pomodoro_timer/timer/data/datasource/local/setting_repository_db.dart';

import '../../timer/data/repository/reactive_setting_repository_impl.dart';
import '../../timer/domain/repository/reactive_setting_repository.dart';
import '../../timer/domain/usecase/usecases.dart';
import '../../timer/presentation/blocs/timer/timer_bloc.dart';
import '../../timer/presentation/blocs/timer_counter/timer_counter_bloc.dart';
import 'audio_player.dart';
import 'countdown.dart';
import 'logger.dart';
import 'time_converter.dart';

// Service Locator
final sl = GetIt.instance;

void init() {
  // Utils
  sl.registerLazySingleton(() => const Countdown());
  sl.registerLazySingleton(() => TimeConverter());
  sl.registerLazySingleton<AudioPlayerL>(() => AudioPlayerLImpl());
  sl.registerLazySingleton<ILogger>(() => LoggerImpl());

  sl.registerSingletonAsync<SettingRepositoryDB>(
    () async => await SettingRepositoryHiveDB.create(logger: sl()),
    // () async {
    //   final settingRepositoryHiveDB = await SettingRepositoryHiveDB.create(logger: sl());
    //   return settingRepositoryHiveDB;
    // },
  );
  sl.registerLazySingleton<ReactiveSettingRepository>(
      () => ReactiveSettingRepositoryImpl(
            dbRepository: sl(),
            logger: sl(),
          ));
  // sl.registerLazySingleton<TimerRepository>(
  //   () => TimerRepositoryImpl(timerRepositoryDB: sl(), logger: sl()),
  // );

  // Usecase
  sl.registerLazySingleton(() => GetTimerUsecase(sl()));
  sl.registerLazySingleton(() => SetTimerUsecase(sl()));

  // Blocs
  sl.registerFactory(
    () => TimerBloc(
      logger: sl(),
      getTimerUsecase: sl(),
      setTimerUsecase: sl(),
      // timeConverter: sl(),
    ),
  );
  sl.registerFactory<TimerCounterBloc>(
    () => TimerCounterBloc(
      countdown: sl(),
      timeConverter: sl(),
      logger: sl(),
      getTimerUsecase: sl(),
      audioPlayer: sl(),
    ),
  );
}
