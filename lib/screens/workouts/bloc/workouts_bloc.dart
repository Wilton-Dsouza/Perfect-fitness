import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:perfect_fitness/data/workout_data.dart';
import 'package:meta/meta.dart';
import 'package:perfect_fitness/core/const/data_constants.dart';
import 'package:perfect_fitness/core/service/data_service.dart';
import 'package:perfect_fitness/core/const/global_constants.dart';
import 'package:perfect_fitness/data/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'workouts_event.dart';
part 'workouts_state.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  WorkoutsBloc() : super(WorkoutsInitial());

  List<WorkoutData> workouts = DataConstants.workouts;

  @override
  Stream<WorkoutsState> mapEventToState(
    WorkoutsEvent event,
  ) async* {
    List<WorkoutData> workouts1 = DataConstants.workouts;
    final currUser = FirebaseAuth.instance.currentUser;
    GlobalConstants.currentUser = UserData.fromFirebase(currUser);
    if (event is WorkoutsInitialEvent) {
      final currUser = FirebaseAuth.instance.currentUser;
      GlobalConstants.currentUser = UserData.fromFirebase(currUser);
      GlobalConstants.workouts = await DataService.getWorkoutsForUser();
      for (int i = 0; i < workouts.length; i++) {
        final workoutsUserIndex =
            GlobalConstants.workouts?.indexWhere((w) => w.id == workouts[i].id);
        if (workoutsUserIndex != -1) {
          workouts[i] = GlobalConstants.workouts![workoutsUserIndex ?? 1];
        }
      }
      yield ReloadWorkoutsState(workouts: workouts);
    } else if (event is CardTappedEvent) {
      yield CardTappedState(workout: event.workout);
    }
  }
}
