import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workoutapp/data/workout_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController newWorkoutNameController = TextEditingController();

  void createNewWorkout() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Create New Workout"),
              content: TextField(
                controller: newWorkoutNameController,
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

  void save() {
    String newWorkoutName = newWorkoutNameController.text;
    context.read<WorkOutData>().addWorkOut(newWorkoutName);

    /// pop dailogbox
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
  }

  void goToWorkOutPage(String workoutName) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WorkOutPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutData>(
      builder: (context, value, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: createNewWorkout,
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text(
              'Workout Tracker',
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
              itemCount: value.workOutList.length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(value.getWorkOutList()[index].name),
                    trailing: IconButton(
                        onPressed: goToWorkOutPage,
                        icon: Icon(Icons.arrow_forward_ios)),
                  )),
        );
      },
    );
  }
}
