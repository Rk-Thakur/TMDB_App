import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieDescription extends StatelessWidget {
  final String image;
  final String name;
  final String rating;
  const MovieDescription(
      {super.key, required this.image, required this.name, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 224.w,
        height: 336.h,
        child: Stack(
          children: [
            Container(
              width: 224.w,
              height: 336.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.sp),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x33000000),
                    Color(0x00000000),
                    Color(0xb2000000),
                  ],
                ),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(.2),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16.h,
              right: 16.w,
              child: Container(
                  width: 77.w,
                  height: 46.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    color: const Color(0x4cd9d9d9),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 14.w, top: 7.h),
                        child: Text(
                          "IMDb",
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.w,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 20.sp,
                              color: Colors.yellow,
                            ),
                            Center(
                                child: Text(
                              rating,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            )),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(20.0.sp),
                child: Container(
                  width: 192.w,
                  height: 76.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                    color: const Color(0x4cd9d9d9),
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                        child: Text(
                          name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
