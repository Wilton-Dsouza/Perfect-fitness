import 'package:perfect_fitness/core/const/color_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:perfect_fitness/data/user_data.dart';
import 'package:perfect_fitness/core/const/global_constants.dart';
import 'package:perfect_fitness/core/service/user_storage_service.dart';
import 'package:perfect_fitness/core/const/data_constants.dart';
import 'package:perfect_fitness/data/workout_data.dart';
import 'package:perfect_fitness/screens/workouts/widget/workout_card.dart';
import 'package:flutter/material.dart';
import 'package:perfect_fitness/core/const/text_constants.dart';
import 'package:perfect_fitness/screens/workouts/bloc/workouts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

class WorkoutContent extends StatefulWidget {
  WorkoutContent({Key? key}) : super(key: key);
  @override
  _WorkoutContent createState() => _WorkoutContent();
}

class _WorkoutContent extends State<WorkoutContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.homeBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: _createHomeBody(context),
    );
  }

  Widget _createHomeBody(BuildContext context) {
    final bloc = BlocProvider.of<WorkoutsBloc>(context);
    List<WorkoutData> workouts = DataConstants.workouts;
    final currUser = FirebaseAuth.instance.currentUser;
    GlobalConstants.currentUser = UserData.fromFirebase(currUser);
    ReloadWorkoutsState(workouts: workouts);
    var workcheck = GlobalConstants.workouts;
    if (workcheck != null) {
      if (workcheck.isEmpty) {
        // final bloc = BlocProvider.of<WorkoutsBloc>(context);
        // final workout1 = bloc.workouts;
        ReloadWorkoutsState(workouts: []);
      } else {
        for (int i = 0; i < workouts.length; i++) {
          final workoutsUserIndex = GlobalConstants.workouts
              ?.indexWhere((w) => w.id == workouts?[i].id);
          if (workoutsUserIndex != -1 && workcheck != null) {
            workouts[i] = workcheck[workoutsUserIndex ?? 1];
          }
        }
      }
    }
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              TextConstants.workouts,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
              // padding: const EdgeInsets.only(top: 5),
              child: RefreshIndicator(
            onRefresh: () {
              setState(() {
                workouts = DataConstants.workouts;
              });
              return Future<void>.delayed(Duration(seconds: 0));
            },
            child: ListView(
              shrinkWrap: true,
              children:
                  bloc.workouts.map((e) => _createWorkoutCard(e)).toList(),
            ),
          )),
        ],
      ),
    );
  }

  Widget _createWorkoutCard(WorkoutData workoutData) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: WorkoutCard(workout: workoutData),
    );
  }
}
