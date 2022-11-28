import 'package:perfect_fitness/screens/home/bloc/home_bloc.dart';
import 'package:perfect_fitness/screens/home/widget/home_content.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<HomeBloc> _buildContext(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(),
      child: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (_, currState) =>
            currState is HomeInitial || currState is WorkoutsGotState,
        builder: (context, state) {
          final bloc = BlocProvider.of<HomeBloc>(context);
          if (state is HomeInitial) {
            bloc.add(HomeInitialEvent());
            bloc.add(ReloadDisplayNameEvent());
            bloc.add(ReloadImageEvent());
          }

          return HomeContent(workouts: bloc.workouts);
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }
}
