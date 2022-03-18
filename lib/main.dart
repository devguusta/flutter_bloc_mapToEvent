import 'dart:async';

import 'package:exemplo_bloc/app_module.dart';
import 'package:exemplo_bloc/app_widget.dart';
import 'package:exemplo_bloc/home/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home/home_bloc.dart';
import 'home/home_state.dart';

void main() =>
    runApp(ModularApp(module: AppModule(), child: const AppWidget()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Modular.get<HomeBloc>();
  late StreamSubscription disposer;

  @override
  void initState() {
    disposer = controller.stream.listen((state) {
      if (state is HomeStateLoading) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()));
      } else if (state is HomeStateLoaded) {
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.add(HomeFetchList());
          },
          child: const Icon(Icons.local_dining),
        ),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: BlocBuilder<HomeBloc, HomeState>(
              bloc: controller,
              builder: (context, state) {
                if (state is HomeStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is HomeStateLoaded) {
                  return ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.list[index]),
                      );
                    },
                  );
                }

                if (state is HomeErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                if (state is HomeStateEmptyList) {
                  return const Center(
                    child: Text('Não há dados disponíveis.'),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              }),
        ));
  }
}
