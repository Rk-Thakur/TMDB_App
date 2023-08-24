import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/features/detail_screen/cubit/detail_movie_cubit.dart';

import '../bloc/discover_bloc.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int tappedIndex = 0;
  List<String> moviesList = [
    'Now Playing',
    'Popular',
    'Top Rated',
    'Upcoming',
  ];

  final String imageUrl = 'https://image.tmdb.org/t/p/original/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 46.h, horizontal: 20.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 24.sp,
                        letterSpacing: 0.48.sp,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/search');
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            _moviesList(),
            Expanded(
              child: SizedBox(
                width: 327.w,
                child: BlocBuilder<DiscoverBloc, DiscoverState>(
                  builder: (context, state) {
                    if (state.popularStatus == PopularStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (state.popularStatus == PopularStatus.success) {
                      return GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: state.popularMovieModel.results!.length,
                        itemBuilder: (context, index) {
                          final image = state.popularMovieModel.results![index];
                          return GestureDetector(
                            onTap: () {
                              context.read<DetailMovieCubit>().getMovieDetails(image.id);
                              
                              Navigator.pushNamed(context, '/detail');
                            },
                            child: Container(
                              height: 150.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.sp),
                                color: const Color(0xffFF8F71).withOpacity(.2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.sp),
                                      child: Image.network(
                                        'https://image.tmdb.org/t/p/original/${image.posterPath}',
                                        fit: BoxFit.fill,
                                        width: 150.w,
                                        height: 130.h,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 23.h,
                                      child: FittedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            image.originalTitle,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state.popularStatus == PopularStatus.success) {
                      return const Center(
                        child: Text('Something went Wrong!!'),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moviesList() {
    return SizedBox(
      height: 30.h,
      width: double.infinity,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final list = moviesList[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  tappedIndex = index;
                });

                movieCategory(index);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  index == tappedIndex
                      ? ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.topCenter,
                              colors: [
                                Color(0xffFF8F71),
                                Color(0xffEF2D1A),
                              ],
                            ).createShader(bounds);
                          },
                          child: Text(
                            list,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                          ),
                        )
                      : Text(
                          list,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                        ),
                  index == tappedIndex
                      ? Container(
                          width: 19.w,
                          height: 3.h,
                          color: Colors.red,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 24.w,
            );
          },
          itemCount: moviesList.length),
    );
  }

  void movieCategory(int index) {
    switch (index) {
      case 0:
        return context.read<DiscoverBloc>().add(FetchNowPlayingEvent());

      case 1:
        return context.read<DiscoverBloc>().add(FetchPopularEvent());

      case 2:
        return context.read<DiscoverBloc>().add(FetchTopRatedEvent());

      case 3:
        return context.read<DiscoverBloc>().add(FetchUpcomingEvent());

      default:
        return context.read<DiscoverBloc>().add(FetchNowPlayingEvent());
    }
  }
}
