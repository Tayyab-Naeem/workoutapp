import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workoutapp/data/workout_data.dart';

class WorkOutPage extends StatefulWidget {
  final String workOutName;

  const WorkOutPage({super.key, required this.workOutName});

  @override
  State<WorkOutPage> createState() => _WorkOutPageState();
}

class _WorkOutPageState extends State<WorkOutPage> {
  final exerciseNameController = TextEditingController();
  final setsController = TextEditingController();
  final repsController = TextEditingController();
  final weightController = TextEditingController();

  void createNewExercise() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add A New Exercise"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: exerciseNameController,
                  ),
                  TextField(
                    controller: setsController,
                  ),
                  TextField(
                    controller: repsController,
                  ),
                  TextField(
                    controller: weightController,
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: const Text("Save"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("Cancel"),
                ),
              ],
            ));
  }

  void clear() {
    exerciseNameController.clear();
    setsController.clear();
    repsController.clear();
    weightController.clear();
  }

  void save() {
    String newExerciseName = exerciseNameController.text;
    String sets = setsController.text;
    String reps = repsController.text;
    String weight = weightController.text;
    Provider.of<WorkOutData>(context, listen: false)
        .addExercise(newExerciseName, widget.workOutName, sets, reps, weight);

    /// pop dailogbox
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  /// checkbox function
  void onCheckedBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkOutData>(context, listen: false)
        .checkoffExercise(workoutName, exerciseName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutData>(
      builder: (context, value, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: createNewExercise,
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.workOutName),
          ),
          body: ListView.builder(
              itemCount: value.numberOfExerciseInWorkout(widget.workOutName),
              itemBuilder: (context, index) => Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      trailing: Checkbox(
                          activeColor: Colors.deepPurple,
                          value: value
                              .getReleventWorkOut(widget.workOutName)
                              .exercises[index]
                              .isCompleted,
                          onChanged: (val) => onCheckedBoxChanged(
                              widget.workOutName,
                              value
                                  .getReleventWorkOut(widget.workOutName)
                                  .exercises[index]
                                  .name)),
                      title: Text(value
                          .getReleventWorkOut(widget.workOutName)
                          .exercises[index]
                          .name),
                      subtitle: Row(
                        children: [
                          Chip(
                              label: Text(
                                  "${value.getReleventWorkOut(widget.workOutName).exercises[index].weight}kg")),
                          Chip(
                              label: Text(
                                  "${value.getReleventWorkOut(widget.workOutName).exercises[index].sets}sets")),
                          Chip(
                              label: Text(
                                  "${value.getReleventWorkOut(widget.workOutName).exercises[index].reps}reps")),
                        ],
                      ),
                    ),
                  )),
        );
      },
    );
  }
}
