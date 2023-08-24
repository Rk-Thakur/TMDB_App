import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmdb_app/features/search_screen/bloc/seach_bloc.dart';

import '../../detail_screen/cubit/detail_movie_cubit.dart';

class SeachScreen extends StatefulWidget {
  const SeachScreen({super.key});

  @override
  State<SeachScreen> createState() => _SeachScreenState();
}

class _SeachScreenState extends State<SeachScreen> {
  @override
  final query = TextEditingController();
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
                width: 283.w,
                child: Text(
                  "Find Movies, Tv Series, and more...",
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
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              controller: query,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      context.read<SeachBloc>().add(SearchingEvent(query: query.text));
                    },
                    icon: const Icon(Icons.search)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.solid,
                  ),
                ),
                hintText: 'Sherlock Holmes',
                hintStyle: const TextStyle(
                  color: Color(0xffbbbbbb),
                ),
                contentPadding: EdgeInsets.only(
                  left: 14.sp,
                  top: 7.sp,
                ),
              ),
              //
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: SizedBox(
                width: 327.w,
                child: BlocBuilder<SeachBloc, SearchState>(
                  builder: (context, state) {
                    if (state.searchStatus == SearchStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (state.searchStatus == SearchStatus.success) {
                      return GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: state.searcModel.results!.length,
                        itemBuilder: (context, index) {
                          final image = state.searcModel.results![index];
                          return GestureDetector(
                            onTap: () {
                              context.read<DetailMovieCubit>().getMovieDetails(image.id!);

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
                                      child: image.posterPath == null
                                          ? const Center(
                                              child: Align(
                                              alignment: Alignment.center,
                                              child: Text("No Images"),
                                            ))
                                          : Image.network(
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
                                            image.originalTitle!,
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
                    } else if (state.searchStatus == SearchStatus.success) {
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
}
