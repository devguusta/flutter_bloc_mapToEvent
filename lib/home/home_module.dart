import 'package:exemplo_bloc/home/home_bloc.dart';
import 'package:exemplo_bloc/home/home_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../main.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton(
      (i) => HomeBloc(HomeStateEmptyList()),
    ),
  ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (_, args) => const MyApp(),
        ),
      ];
}
