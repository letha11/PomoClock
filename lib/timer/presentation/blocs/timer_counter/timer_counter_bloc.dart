// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:clock/clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/core/constants.dart';
import 'package:pomodoro_timer/core/utils/notifications.dart';
import 'package:pomodoro_timer/core/utils/vibration.dart';
import 'package:pomodoro_timer/timer/domain/entity/sound_setting_entity.dart';

import 'package:pomodoro_timer/timer/domain/entity/timer_setting_entity.dart';
import 'package:pomodoro_timer/timer/domain/usecase/get_sound_setting.dart';
import 'package:pomodoro_timer/timer/domain/usecase/get_timer.dart';
import 'package:pomodoro_timer/core/utils/audio_player.dart';
import 'package:pomodoro_timer/core/utils/countdown.dart';
import 'package:pomodoro_timer/core/utils/time_converter.dart';
import 'package:pomodoro_timer/core/utils/error_object.dart';
import 'package:pomodoro_timer/core/utils/logger.dart';
import 'package:vibration/vibration.dart';

part 'timer_counter_event.dart';

part 'timer_counter_state.dart';

enum TimerType {
  pomodoro,
  breakTime,
  longBreak,
}

extension TTToString on TimerType {
  String toShortString() {
    if (name == "breakTime") {
      return 'break';
    } else if (name == "longBreak") {
      return 'long break';
    } else {
      return 'pomodoro';
    }
  }
}

class TimerCounterBloc extends Bloc<TimerCounterEvent, TimerCounterState> {
  final Countdown _countdown;
  final ILogger? _logger;
  final AudioPlayerL _audioPlayer;
  final TimeConverter timeConverter;
  final GetTimerUsecase _getTimerUsecase;
  final GetSoundSettingUsecase _getSoundSettingUsecase;
  final NotificationHelper? _notificationHelper;
  final VibrationL _vibration;
  late TimerSettingEntity timer;
  late SoundSettingEntity soundSetting;
  int _pomodoroCounter = 0;
  TimerType type = TimerType.pomodoro;

  StreamSubscription<int>? _countdownSubscription;
  int _duration = 3;
  int _timeStamps = clock.now().millisecondsSinceEpoch;
  late final StreamSubscription<TimerSettingEntity> _timerSubscription;
  late final StreamSubscription<SoundSettingEntity> _soundSettingSubscription;

  TimerCounterBloc({
    required Countdown countdown,
    required this.timeConverter,
    required GetTimerUsecase getTimerUsecase,
    required GetSoundSettingUsecase getSoundSettingUsecase,
    required AudioPlayerL audioPlayer,
    required VibrationL vibration,
    NotificationHelper? notificationHelper,
    ILogger? logger,
    StreamSubscription<int>? streamSubscription,
  })  : _countdown = countdown,
        _countdownSubscription = streamSubscription,
        _audioPlayer = audioPlayer,
        _vibration = vibration,
        _notificationHelper = notificationHelper,
        _logger = logger,
        _getTimerUsecase = getTimerUsecase,
        _getSoundSettingUsecase = getSoundSettingUsecase,
        super(const TimerCounterInitial('00:00', 0)) {
    _subscribeTimer();
    _subscribeSoundSetting();
    _notificationHelper?.initialize();

    on<TimerCounterStarted>(_onTimerStarted);
    on<TimerCounterPaused>(_onTimerPaused);
    on<TimerCounterResumed>(_onTimerResumed);
    on<TimerCounterReset>(_onTimerReset);
    on<TimerCounterTypeChange>(_onTimerTypeChange);

    on<_TimerCounterTicked>(_onTimerTicked);
  }

  @override
  Future<void> close() {
    _countdownSubscription?.cancel();
    _timerSubscription.cancel();
    _soundSettingSubscription.cancel();
    return super.close();
  }

  void _subscribeSoundSetting() {
    final result = _getSoundSettingUsecase();

    result.fold(
        (err) => emit(
              TimerCounterFailure(
                ErrorObject.mapFailureToError(err),
              ),
            ), (stream) {
      _soundSettingSubscription = stream.listen((data) => soundSetting = data);
    });
  }

  void _subscribeTimer() {
    final result = _getTimerUsecase();

    result.fold(
      (err) => emit(
        TimerCounterFailure(
          ErrorObject.mapFailureToError(err),
        ),
      ),
      (stream) {
        _timerSubscription = stream.listen((data) {
          _countdownSubscription?.cancel();

          timer = data;

          // will change _duration value
          _setDurationByType();

          emit(
            TimerCounterInitial(
                timeConverter.fromSeconds(_duration), _timeStamps),
          );
        });
      },
    );
  }

  void _onTimerStarted(
      TimerCounterStarted event, Emitter<TimerCounterState> emit) async {
    _logger?.log(Level.debug, "TimerCounterStarted event get sent");

    /// because we are about to start a new one.
    /// cancel the subscription if there are any
    if (state is! TimerCounterInProgress && state is! TimerCounterPause) {
      _countdownSubscription?.cancel();
      _audioPlayer.stopSound();

      // print(_duration - 1);
      await _countdown.count(_duration - 1).fold(
        (err) {
          _logger?.log(Level.warning, "[count] {duration: $_duration}");
          emit(TimerCounterFailure(
            ErrorObject.mapFailureToError(err),
          ));
        },
        (data) async {
          add(_TimerCounterTicked(
              formattedDuration: timeConverter.fromSeconds(_duration)));
          _logger?.log(Level.debug, "Start Listening into a stream");
          _countdownSubscription = data.listen((d) {
            add(_TimerCounterTicked(
                formattedDuration: timeConverter.fromSeconds(d)));
            _notificationHelper?.showTimerCounter(
              type.toShortString(),
              timeConverter.fromSeconds(d),
            );
          }, onDone: () async {
            if(type == TimerType.pomodoro) {
              _pomodoroCounter++;
            }

            _logger?.log(Level.debug, "Stream Finished");

            if (soundSetting.playSound) {
              // if (soundSetting.type.isDefault)
              // then play with audiopath
              // else *which mean it's an imported or soundSetting.type.isImported
              // then play with Uint8List / source them and then play
              if (soundSetting.type.isDefault) {
                _audioPlayer.playSound(soundSetting.defaultAudioPath);
              } else {
                _audioPlayer.playSoundFromUint8List(soundSetting.bytesData!);
              }
            } else {
              if(await _vibration.hasCustomVibrationsSupport() ?? false) {
                _vibration.vibrate(duration: 1000);
              } else {
                _vibration.vibrate();
                await Future.delayed(const Duration(milliseconds: 500));
                _vibration.vibrate();
              }
            }

            if (type == TimerType.pomodoro &&
                _pomodoroCounter % 4 == 0 &&
                timer.pomodoroSequence) {
              _setDurationByType(TimerType.longBreak);
            } else if (type == TimerType.pomodoro) {
              _setDurationByType(TimerType.breakTime);
            } else {
              _setDurationByType(TimerType.pomodoro);
            }

            add(TimerCounterReset());
          });
        }, // listen
      );
    }
  }

  _onTimerPaused(TimerCounterPaused event, Emitter<TimerCounterState> emit) {
    _logger?.log(Level.debug, "TimerCounterPaused event get sent");
    final stateDuration = timeConverter.convertStringToSeconds(state.duration);

    if (stateDuration > 0 && state is TimerCounterInProgress) {
      _countdownSubscription!.pause();

      emit(TimerCounterPause(state.duration));
      _notificationHelper?.showTimerCounter(
        type.toShortString(),
        state.duration,
      );
    }
  }

  _onTimerResumed(TimerCounterResumed event, Emitter<TimerCounterState> emit) {
    _logger?.log(Level.debug, "TimerCounterResumed event get sent");
    final isPaused = _countdownSubscription?.isPaused ?? false;
    final stateDuration = timeConverter.convertStringToSeconds(state.duration);

    if (state is TimerCounterPause && isPaused && stateDuration > 0) {
      // stream.resume will delay vaguely one second
      // so i just emulate a `TimerRunning` event with emitting a
      // `TimerCounterInProgress` with the current duration
      emit(TimerCounterInProgress(state.duration));
      _countdownSubscription?.resume();
      _notificationHelper?.showTimerCounter(
        type.toShortString(),
        state.duration,
      );
    }
  }

  _onTimerReset(TimerCounterReset event, Emitter<TimerCounterState> emit) {
    _logger?.log(Level.debug, "TimerCounterReset event get sent");
    if (state is! TimerCounterInitial) {
      _countdownSubscription?.cancel();

      emit(TimerCounterInitial(
          timeConverter.fromSeconds(_duration), _timeStamps));
      _notificationHelper?.dismiss(timerCounterNotificationId);
    }
  }

  _onTimerTypeChange(
      TimerCounterTypeChange event, Emitter<TimerCounterState> emit) {
    _logger?.log(Level.debug,
        "TimerCounterChange event get sent, [type: ${event.type}, currentType: $type]");

    if (type != event.type) {
      _timeStamps = clock.now().millisecondsSinceEpoch; // reassign

      _countdownSubscription?.cancel();

      _setDurationByType(event.type);

      emit(TimerCounterInitial(
          timeConverter.fromSeconds(_duration), _timeStamps));
      _notificationHelper?.dismiss(timerCounterNotificationId);
    }
  }

  _onTimerTicked(_TimerCounterTicked event, Emitter<TimerCounterState> emit) {
    emit(TimerCounterInProgress(event.formattedDuration));
  }

  _setDurationByType([TimerType? typeArgs]) {
    _logger?.log(Level.debug,
        "_setDurationByType function get called, [type: $typeArgs]");
    type = typeArgs ?? type;

    switch (type) {
      case TimerType.pomodoro:
        _duration = timer.pomodoroTime;
        break;
      case TimerType.breakTime:
        _duration = timer.shortBreak;
        break;
      case TimerType.longBreak:
        _duration = timer.longBreak;
        break;
      default:
        _duration = timer.pomodoroTime;
    }
  }
}
