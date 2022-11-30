import 'dart:convert';

import 'package:perfect_fitness/core/const/global_constants.dart';
import 'package:perfect_fitness/core/service/user_storage_service.dart';
import 'package:perfect_fitness/data/workout_data.dart';
import 'package:perfect_fitness/data/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:perfect_fitness/core/const/data_constants.dart';
import 'package:perfect_fitness/core/const/path_constants.dart';
import 'package:perfect_fitness/core/const/text_constants.dart';
import 'package:perfect_fitness/data/exercise_data.dart';
import 'package:perfect_fitness/data/workout_data.dart';

class DataService {
  static Future<List<WorkoutData>> getWorkoutsForUser() async {
    final currUser = FirebaseAuth.instance.currentUser;
    GlobalConstants.currentUser = UserData.fromFirebase(currUser);
    final currUserEmail = GlobalConstants.currentUser?.mail;

    // await UserStorageService.deleteSecureData('${currUserEmail}Workouts');

    final workoutsStr =
        await UserStorageService.readSecureData('${currUserEmail}Workouts');
    if (workoutsStr == null) {
      final List<WorkoutData> workoutsnull = [
        WorkoutData(
            id: 'workout1',
            title: TextConstants.yogaTitle,
            exercises: TextConstants.yogaExercises,
            minutes: TextConstants.yogaMinutes,
            currentProgress: 0,
            progress: 3,
            image: PathConstants.yoga,
            exerciseDataList: [
              ExerciseData(
                id: 'exercise1',
                title: 'Yoga warm up',
                minutes: TextConstants.recliningMinutes,
                progress: 0,
                image: PathConstants.yogawarm,
                video: PathConstants.recliningVideo,
                description: TextConstants.warriorDescription,
                steps: [
                  TextConstants.warriorStep1,
                  TextConstants.warriorStep2,
                  TextConstants.warriorStep1,
                  TextConstants.warriorStep2,
                  TextConstants.warriorStep1,
                  TextConstants.warriorStep2,
                ],
              ),
              ExerciseData(
                id: 'exercise2',
                title: TextConstants.cowPose,
                minutes: TextConstants.cowPoseMinutes,
                progress: 0,
                image: PathConstants.cowpose,
                video: PathConstants.cowPoseVideo,
                description: TextConstants.warriorDescription,
                steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
              ),
              ExerciseData(
                id: 'exercise3',
                title: TextConstants.warriorPose,
                minutes: TextConstants.warriorPoseMinutes,
                progress: 0,
                image: PathConstants.warriorpose2,
                video: PathConstants.warriorIIVideo,
                description: TextConstants.warriorDescription,
                steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
              ),
            ]),
        WorkoutData(
            id: 'workout2',
            title: TextConstants.pilatesTitle,
            exercises: TextConstants.pilatesExercises,
            minutes: TextConstants.pilatesMinutes,
            currentProgress: 0,
            progress: 3,
            image: PathConstants.pilates,
            exerciseDataList: [
              ExerciseData(
                id: 'exercise1',
                title: 'Breathing',
                minutes: TextConstants.recliningMinutes,
                progress: 0.0,
                image: PathConstants.breathing,
                video: PathConstants.recliningVideo,
                description: TextConstants.warriorDescription,
                steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
              ),
              ExerciseData(
                id: 'exercise2',
                title: 'Shoulder bridge',
                minutes: TextConstants.cowPoseMinutes,
                progress: 0.0,
                image: PathConstants.shoulderbridge,
                video: PathConstants.cowPoseVideo,
                description: TextConstants.warriorDescription,
                steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
              ),
              ExerciseData(
                id: 'exercise3',
                title: 'Leg lifts',
                minutes: TextConstants.warriorPoseMinutes,
                progress: 0.0,
                image: PathConstants.leftlift,
                video: PathConstants.warriorIIVideo,
                description: TextConstants.warriorDescription,
                steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
              ),
            ]),
        WorkoutData(
            id: 'workout3',
            title: TextConstants.fullBodyTitle,
            exercises: TextConstants.fullBodyExercises,
            minutes: TextConstants.fullBodyMinutes,
            currentProgress: 0,
            progress: 3,
            image: PathConstants.fullBody,
            exerciseDataList: [
              ExerciseData(
                id: 'exercise1',
                title: 'Burpee',
                minutes: TextConstants.recliningMinutes,
                progress: 0.0,
                image: PathConstants.burpee,
                video: PathConstants.recliningVideo,
                description: TextConstants.warriorDescription,
                steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
              ),
              ExerciseData(
                id: 'exercise2',
                title: 'Plank',
                minutes: TextConstants.cowPoseMinutes,
                progress: 0.0,
                image: PathConstants.plank,
                video: PathConstants.cowPoseVideo,
                description: TextConstants.warriorDescription,
                steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
              ),
              ExerciseData(
                id: 'exercise3',
                title: 'Thruster',
                minutes: TextConstants.warriorPoseMinutes,
                progress: 0.0,
                image: PathConstants.thrusters,
                video: PathConstants.warriorIIVideo,
                description: TextConstants.warriorDescription,
                steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
              ),
            ]),
        WorkoutData(
          id: 'workout4',
          title: TextConstants.stretchingTitle,
          exercises: TextConstants.stretchingExercises,
          minutes: TextConstants.stretchingMinutes,
          currentProgress: 0,
          progress: 3,
          image: PathConstants.stretching,
          exerciseDataList: [
            ExerciseData(
              id: 'exercise1',
              title: 'Quad Stretch',
              minutes: TextConstants.recliningMinutes,
              progress: 0.0,
              image: PathConstants.quad,
              video: PathConstants.recliningVideo,
              description: TextConstants.warriorDescription,
              steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
            ),
            ExerciseData(
              id: 'exercise2',
              title: 'Side Stretch',
              minutes: TextConstants.cowPoseMinutes,
              progress: 0.0,
              image: PathConstants.sidestretch,
              video: PathConstants.cowPoseVideo,
              description: TextConstants.warriorDescription,
              steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
            ),
            ExerciseData(
              id: 'exercise3',
              title: 'Hamstring Stretch',
              minutes: TextConstants.warriorPoseMinutes,
              progress: 0.0,
              image: PathConstants.hamString,
              video: PathConstants.warriorIIVideo,
              description: TextConstants.warriorDescription,
              steps: [TextConstants.warriorStep1, TextConstants.warriorStep2],
            ),
          ],
        ),
      ];
      GlobalConstants.workouts = workoutsnull;
      return workoutsnull;
    }
    ;
    final decoded = (json.decode(workoutsStr) as List?) ?? [];
    final workouts = decoded.map((e) {
      final decodedE = json.decode(e) as Map<String, dynamic>?;
      return WorkoutData.fromJson(decodedE!);
    }).toList();
    GlobalConstants.workouts = workouts;
    return workouts;
  }

  static Future<void> saveWorkout(WorkoutData workout) async {
    final allWorkouts = await getWorkoutsForUser();
    final index = allWorkouts.indexWhere((w) => w.id == workout.id);
    if (index != -1) {
      allWorkouts[index] = workout;
    } else {
      allWorkouts.add(workout);
    }
    GlobalConstants.workouts = allWorkouts;
    final workoutsStr = allWorkouts.map((e) => e.toJsonString()).toList();
    final encoded = json.encode(workoutsStr);
    final currUserEmail = GlobalConstants.currentUser?.mail;
    await UserStorageService.writeSecureData(
      '${currUserEmail}Workouts',
      encoded,
    );
  }
}
