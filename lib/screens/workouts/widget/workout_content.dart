import 'package:perfect_fitness/core/const/color_constants.dart';
import 'package:perfect_fitness/core/const/data_constants.dart';
import 'package:perfect_fitness/data/workout_data.dart';
import 'package:perfect_fitness/screens/workouts/widget/workout_card.dart';
import 'package:flutter/material.dart';
import 'package:perfect_fitness/core/const/text_constants.dart';
import 'package:perfect_fitness/screens/workouts/bloc/workouts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              TextConstants.workouts,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          Container(
              padding: const EdgeInsets.only(top: 5),
              child: RefreshIndicator(
                onRefresh: () {
                  setState(() {});
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
