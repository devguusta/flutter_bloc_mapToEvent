import 'package:exemplo_bloc/home/home_event.dart';
import 'package:exemplo_bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(HomeStateEmptyList());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    late HomeState state;
    if (event is HomeFetchList) {
      yield HomeStateLoading();
      try {
        state = await _fetchList();
        yield state;
      } catch (e) {
        yield HomeStateEmptyList();
      }
    } else {
      yield HomeStateLoading();
      try {
        _fetchListWithError();
      } catch (e) {
        _fetchListWithEmptyList();
      }
    }
  }

  Future<HomeState> _fetchList() async {
    var list = await Future.delayed(
      const Duration(
        seconds: 1,
      ),
      () => <String>[
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
        'Item 1',
      ],
    );
    return HomeStateLoaded(list: list);
  }

  Future<HomeState> _fetchListWithEmptyList() async {
    return await Future.delayed(
        const Duration(
          seconds: 3,
        ),
        () => HomeStateEmptyList());
  }

  Future<HomeState> _fetchListWithError() async {
    return await Future.delayed(
        const Duration(
          seconds: 3,
        ),
        () => HomeErrorState(message: 'Não foi possível carregar os dados.'));
  }
}
