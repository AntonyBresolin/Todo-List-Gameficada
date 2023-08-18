

import 'package:alura_flutter_curso_1/components/tasks.dart';
import 'package:flutter/material.dart';

class TaskInherited extends InheritedWidget {
   TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Tasks> tasklist = [
    Tasks('Andar de Bike', 'assets/images/bike.webp', 2),
    Tasks('Ler 50 páginas', 'assets/images/ler.jpg', 1),
  ];

  void newTask(String name, String photo, int difficulty){
    tasklist.add(Tasks(name, photo, difficulty));
    //colocar salvar aqui
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.tasklist.length != tasklist.length;
  }
}
