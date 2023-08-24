import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/features/detail_screen/cubit/detail_movie_cubit.dart';
import 'package:tmdb_app/features/detail_screen/presentation/detail_screen.dart';
import 'package:tmdb_app/features/discover_screen/bloc/discover_bloc.dart';
import 'package:tmdb_app/features/discover_screen/presentation/discover_screen.dart';
import 'package:tmdb_app/features/search_screen/bloc/seach_bloc.dart';
import 'package:tmdb_app/features/search_screen/presentation/search_screen.dart';
import 'package:tmdb_app/features/home_screen/presentation/home_screen.dart';
import 'package:tmdb_app/utils/routes.dart';

class AppRouter {
  final DiscoverBloc discoverBloc = DiscoverBloc();
  final SeachBloc seachBloc = SeachBloc();
  final DetailMovieCubit detailMovieCubit = DetailMovieCubit();
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: discoverBloc..add(FetchUpcomingEvent()),
              ),
              BlocProvider.value(
                value: detailMovieCubit,
              ),
            ],
            child: const HomeScreen(),
          );
        });
      case discoverScreen:
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: discoverBloc..add(FetchNowPlayingEvent()),
              ),
              BlocProvider.value(
                value: discoverBloc,
              ),
              BlocProvider.value(
                value: detailMovieCubit,
              ),
            ],
            child: const DiscoverScreen(),
          );
        });
      case searchScreen:
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: seachBloc,
              ),
              BlocProvider.value(
                value: detailMovieCubit,
              ),
              BlocProvider.value(
                value: discoverBloc,
              ),
            ],
            child: const SeachScreen(),
          );
        });
      case detailScreen:
        return MaterialPageRoute(builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: detailMovieCubit,
              ),
            ],
            child: const DetailScreen(),
          );
        });

      default:
        return notFoundRoute();
    }
  }

  Route notFoundRoute() {
    return MaterialPageRoute(
      builder: (context) => const Material(
        child: Scaffold(
          body: Center(child: Text('Page Not Found')),
        ),
      ),
    );
  }
}
