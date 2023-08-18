import 'package:alura_flutter_curso_1/screens/form_screen.dart';
import 'package:alura_flutter_curso_1/components/tasks.dart';
import 'package:alura_flutter_curso_1/data/task_dao.dart';
import 'package:alura_flutter_curso_1/data/task_inherited.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        leading: Icon(Icons.add_task),
        actions: [
          IconButton(onPressed: (){setState(() {
            
          });}, icon: Icon(Icons.refresh))
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 208, 221, 237),
        child: Padding(
          padding: EdgeInsets.only(top: 8, bottom: 70),
          child: FutureBuilder<List<Tasks>>(
              future: TaskDao().findAll(),
              builder: (context, snapshot) {
                List<Tasks>? itens = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Carregando')
                        ],
                      ),
                    );
                    break;
                  case ConnectionState.waiting:
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Carregando')
                        ],
                      ),
                    );
                    break;
                  case ConnectionState.active:
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Carregando')
                        ],
                      ),
                    );
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData && itens != null) {
                      if (itens.isNotEmpty) {
                        return ListView.builder(
                            itemCount: itens.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Tasks tarefa = itens[index];
                              return tarefa;
                            });
                      }
                      return Center(
                        child: Column(
                          children: [
                            Icon(Icons.error_outline, size: 128),
                            Text(
                              "Não há tarefas adicionadas",
                              style: TextStyle(fontSize: 32),
                            )
                          ],
                        ),
                      );
                    }
                    return Text("Erro ao carregar Tarefas");
                    break;
                }
                return Text("Erro desconhecido");
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contextNew) => FormScreen(
                      taskContext: context,
                    )),
          ).then((value) => setState(() {
                print("Recarregando tela inicial");
              }));
        },
        backgroundColor: Colors.blue[400],
        child: const Icon(Icons.add),
      ),
    );
  }
}
