// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/core/components/movie_description.dart';

import '../../detail_screen/cubit/detail_movie_cubit.dart';
import '../../discover_screen/bloc/discover_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: 46.h, horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _title(),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "TV ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 24.sp,
                    letterSpacing: 0.48.sp,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 327.w,
              height: 191.h,
              child: BlocBuilder<DiscoverBloc, DiscoverState>(
                builder: (context, state) {
                  if (state.popularStatus == PopularStatus.success) {
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.popularMovieModel.results!.length,
                      itemBuilder: (context, index) {
                        final image = state.popularMovieModel.results![index];

                        return Container(
                          width: 327.w,
                          height: 191.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/original/${image.posterPath}',
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(30.sp),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 20.w,
                        );
                      },
                    );
                  } else if (state.popularStatus == PopularStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "Movies ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 24.sp,
                    letterSpacing: 0.48.sp,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            SizedBox(
              width: double.infinity,
              height: 336.h,
              child: BlocBuilder<DiscoverBloc, DiscoverState>(
                builder: (context, state) {
                  if (state.popularStatus == PopularStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (state.popularStatus == PopularStatus.success) {
                    return CarouselSlider.builder(
                      itemCount: state.popularMovieModel.results!.length,
                      itemBuilder: (context, index, pageViewIndex) {
                        final movie = state.popularMovieModel.results![index];
                        return GestureDetector(
                          onTap: () {
                            context.read<DetailMovieCubit>().getMovieDetails(movie.id);

                            Navigator.pushNamed(context, '/detail');
                          },
                          child: MovieDescription(
                            image: 'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                            name: movie.title,
                            rating: movie.voteAverage.toString(),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 336.h,
                        clipBehavior: Clip.antiAlias,
                        autoPlayCurve: Curves.decelerate,
                        pageSnapping: true,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: .7,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget _title() {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Stream ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24.sp,
                    letterSpacing: 0.48.sp,
                    fontStyle: FontStyle.normal,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [
                          Color(0xffff8f71),
                          Color(0xffef2d1a),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                      ).createShader(const Rect.fromLTRB(0, 0, 200, 100)),
                  ),
                ),
                TextSpan(
                  text: "Everwhere",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 24.sp,
                    letterSpacing: 0.48.sp,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ]),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/discover');
                },
                icon: const Icon(
                  Icons.movie,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
