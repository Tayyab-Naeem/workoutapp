import 'package:flutter/cupertino.dart';
import 'package:workoutapp/models/exercise.dart';
import 'package:workoutapp/models/workout.dart';

class WorkOutData extends ChangeNotifier {
  List<WorkOut> workOutList = [
    WorkOut(name: "Upper Body", exercises: [
      Exercise(name: 'bicep curl', reps: '10', sets: '10', weight: '3')
    ]),
    WorkOut(name: "lower Body", exercises: [
      Exercise(name: 'squit curl', reps: '10', sets: '10', weight: '3')
    ]),
  ];

  /// get the list of workout
  List<WorkOut> getWorkOutList() {
    return workOutList;
  }

  /// get the length of given workout
  int numberOfExerciseInWorkout(String workoutName) {
    WorkOut releventWorkout = getReleventWorkOut(workoutName);
    return releventWorkout.exercises.length;
  }

  /// add a new workout with blank list of Excercise
  void addWorkOut(String name) {
    workOutList.add(WorkOut(name: name, exercises: []));
    notifyListeners();
  }

  /// add exercise to the workOut
  void addExercise(
    String exerciseName,
    String workoutName,
    String sets,
    String reps,
    String weight,
  ) {
    /// find relevent Exercise
    WorkOut releventWorkout = getReleventWorkOut(workoutName);
    releventWorkout.exercises.add(
        Exercise(name: exerciseName, reps: reps, sets: sets, weight: weight));
    notifyListeners();
  }

  /// check off exercise
  void checkoffExercise(
    String workoutName,
    String exerciseName,
  ) {
    // find relevent Exercise in that workout
    Exercise releventExercise = getReleventExercise(workoutName, exerciseName);
// check off boolean to show user completed the exercise
    releventExercise.isCompleted = !releventExercise.isCompleted;
    notifyListeners();
  }

  /// return a relevent workout object and given a workoutName
  WorkOut getReleventWorkOut(String workoutName) {
    WorkOut releventWorkout =
        workOutList.firstWhere((workout) => workout.name == workoutName);
    return releventWorkout;
  }

  /// return a relevent Exercise object and given a workOutName+exerciseName
  Exercise getReleventExercise(String workoutName, String exerciseName) {
    /// find relevent workout first
    WorkOut releventWorkout = getReleventWorkOut(workoutName);

    /// than find the relevent excercise in that workout
    Exercise releventExercise = releventWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return releventExercise;
  }
}
