import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_clsf/core/app_export.dart';
import 'package:image_clsf/core/utils/size_utils.dart';
/*import 'package:image_clsf/logic/auth_page.dart';*/
import 'package:image_clsf/presentation/designpage.dart';
import 'package:image_clsf/presentation/login_page.dart';
import 'package:image_clsf/theme/app_decoration.dart';
import 'package:image_clsf/theme/theme_helper.dart';
import 'package:image_clsf/widgets/custom_elevated_button.dart';
import 'package:image_clsf/widgets/custom_image_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselScreen extends StatelessWidget {
  const CarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: CarouselSlider(
          options: CarouselOptions(
            height: screenHeight,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              // Handle page change if needed
            },
          ),
          items: [
            buildLayoutOne(context),
            buildLayoutTwo(context),
            buildLayoutThree(context),
          ],
        ),
      ),
    );
  }

  Widget buildLayoutOne(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              _buildDepthFrameZero(context),
              Text(
                "Detect, Alert, Protect",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge!.copyWith(
                  height: 1.75,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24.v),
              Container(
                width: 298.h,
                margin: EdgeInsets.only(
                  left: 46.h,
                  right: 45.h,
                ),
                child: Text(
                  "we detect potential threats, alert authorities, and protect lives",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge!.copyWith(
                    height: 1.75,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                height: 8.v,
                child: AnimatedSmoothIndicator(
                  activeIndex: 0,
                  count: 3,
                  effect: ScrollingDotsEffect(
                    spacing: 12,
                    activeDotColor: appTheme.blueGray700 ??
                        Color.fromARGB(255, 21, 40, 208),
                    dotColor:
                        theme.colorScheme.onPrimaryContainer ?? Colors.grey,
                    dotHeight: 8.v,
                    dotWidth: 8.h,
                  ),
                ),
              ),
              SizedBox(height: 32.v),
              CustomElevatedButton(
                text: "Get started",
                margin: EdgeInsets.symmetric(horizontal: 16.h),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
              SizedBox(height: 12.v),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLayoutTwo(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              _buildDepthFrameOne(context),
              Text(
                "Vigilance Redefined",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge!.copyWith(
                  height: 1.75,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24.v),
              Container(
                width: 298.h,
                margin: EdgeInsets.only(
                  left: 46.h,
                  right: 45.h,
                ),
                child: Text(
                  "Redefine the concept of vigilance paving the way for a safer future",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge!.copyWith(
                    height: 1.75,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                height: 8.v,
                child: AnimatedSmoothIndicator(
                  activeIndex: 1,
                  count: 3,
                  effect: ScrollingDotsEffect(
                    spacing: 12,
                    activeDotColor: appTheme.blueGray700 ??
                        Color.fromARGB(255, 21, 40, 208),
                    dotColor:
                        theme.colorScheme.onPrimaryContainer ?? Colors.grey,
                    dotHeight: 8.v,
                    dotWidth: 8.h,
                  ),
                ),
              ),
              SizedBox(height: 32.v),
              CustomElevatedButton(
                text: "Get started",
                margin: EdgeInsets.symmetric(horizontal: 16.h),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLayoutThree(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              _buildDepthFrameTwo(context),
              Text(
                "Stay Ahead, Stay Safe: Our Smart Anomaly Detection is Your Shield!",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge!.copyWith(
                  height: 1.75,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24.v),
              Container(
                width: 298.h,
                margin: EdgeInsets.only(
                  left: 46.h,
                  right: 45.h,
                ),
                child: Text(
                  "Stay one step ahead of threats with our powerful Smart Anomaly Detection system, ensuring your safety at all times",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge!.copyWith(
                    height: 1.75,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                height: 8.v,
                child: AnimatedSmoothIndicator(
                  activeIndex: 2,
                  count: 3,
                  effect: ScrollingDotsEffect(
                    spacing: 12,
                    activeDotColor: appTheme.blueGray700 ??
                        Color.fromARGB(255, 21, 40, 208),
                    dotColor:
                        theme.colorScheme.onPrimaryContainer ?? Colors.grey,
                    dotHeight: 8.v,
                    dotWidth: 8.h,
                  ),
                ),
              ),
              SizedBox(height: 32.v),
              CustomElevatedButton(
                text: "Get started",
                margin: EdgeInsets.symmetric(horizontal: 16.h),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildDepthFrameZero(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillPrimaryContainer,
      child: Column(
        children: [
          SizedBox(height: 11.v),
          CustomImageView(
            imagePath: ImageConstant.imgImage1011,
            height: 207.v,
            width: 390.h,
          ),
        ],
      ),
    );
  }

  Widget _buildDepthFrameOne(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillPrimaryContainer,
      child: Column(
        children: [
          SizedBox(height: 11.v),
          CustomImageView(
            imagePath: ImageConstant.imgImage1012,
            height: 207.v,
            width: 390.h,
          ),
        ],
      ),
    );
  }

  Widget _buildDepthFrameTwo(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillPrimaryContainer,
      child: Column(
        children: [
          SizedBox(height: 11.v),
          CustomImageView(
            imagePath: ImageConstant.imgImage1013,
            height: 207.v,
            width: 390.h,
          ),
        ],
      ),
    );
  }
}
