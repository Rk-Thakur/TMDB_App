// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:tmdb_app/features/detail_screen/cubit/detail_movie_cubit.dart';
import 'package:tmdb_app/features/detail_screen/model/detail_movie_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailMovieCubit, DetailMovieState>(
        builder: (context, state) {
          if (state.detailStatus == DetailStatus.loading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.detailStatus == DetailStatus.success) {
            final details = state.movieDetailModel;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 375.w,
                  height: 400.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/original/${details.posterPath}',
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(30.sp),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.sp),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          movieName(name: details.originalTitle!),
                          watchTimeRating(
                              runtime: details.runtime.toString(),
                              vote_average: details.voteAverage.toString()),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Divider(
                            color: Color(0xff515151),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          movieDateGenre(genre: details.genres!, date: details.releaseDate!),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Divider(
                            color: Color(0xff515151),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "${details.title}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: 0.32.sp,
                            ),
                          ),
                          ReadMoreText(
                            '${details.overview}',
                            trimLines: 4,
                            colorClickableText: Colors.white,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            style: const TextStyle(
                              color: Color(0xffBCBCBC),
                            ),
                            lessStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            moreStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state.detailStatus == DetailStatus.failure) {
            return Center(
              child: Text(
                'Something is Missing!! Sorry',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget movieDateGenre({required List<Genre> genre, required DateTime date}) {
    return Row(
      children: [
        SizedBox(
          width: 110.w,
          height: 46.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Release Date",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.24.sp,
                ),
              ),
              const Spacer(),
              Text(
                '${date.year.toString()}-${date.month.toString()}-${date.day.toString()}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffBCBCBC),
                  letterSpacing: 0.24.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 56.w,
        ),
        Expanded(
          child: SizedBox(
            width: 104.w,
            height: 50.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Genre",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 0.24.sp,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 25.h,
                  width: double.infinity,
                  child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: genre.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 60.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                            color: Colors.black45, borderRadius: BorderRadius.circular(15.sp)),
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              genre[index].name!,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                letterSpacing: 0.24.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 12.w,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget watchTimeRating({required String runtime, required String vote_average}) {
    return SizedBox(
      width: 210.w,
      height: 30.h,
      child: Row(
        children: [
          const Icon(
            Icons.timer,
            color: Color(0xffBCBCBC),
          ),
          Text(
            "$runtime Minutes",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xffBCBCBC),
              letterSpacing: 0.24.sp,
            ),
          ),
          SizedBox(
            width: 14.w,
          ),
          const Icon(
            Icons.star,
            color: Color(0xffBCBCBC),
          ),
          Text(
            "$vote_average(ImDb)",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xffBCBCBC),
              letterSpacing: 0.24.sp,
            ),
          )
        ],
      ),
    );
  }

  Widget movieName({required String name}) {
    return Row(
      children: [
        SizedBox(
          width: 290.w,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 0.48.sp,
            ),
          ),
        ),
        Container(
          height: 22.h,
          width: 30.w,
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(5.sp),
          ),
          child: Center(
              child: Text(
            "4K",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              letterSpacing: 0.24.sp,
            ),
          )),
        ),
      ],
    );
  }
}
