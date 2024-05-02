import 'package:agrotech_hackat/constants/colors.dart';
import 'package:agrotech_hackat/view/webview%20page/webviewpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class KnowledgeBase extends StatelessWidget {
  const KnowledgeBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text("Farmx AI",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: white))),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 20.w,
          ),
          child: SizedBox(
            height: 0.9.sh,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const WebViewPage(
                          title: "FarmX AI",
                          uri: "https://farm-x.netlify.app/ai"));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                      ),
                      alignment: Alignment.centerLeft,
                      height: 200.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: plantLighter),
                          borderRadius: BorderRadius.all(Radius.circular(5.r))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            "assets/blog.json",
                            height: 150.h,
                            width: 150.w,
                            fit: BoxFit.cover,
                            animate: true,
                            repeat: true,
                            reverse: false,
                          ),
                          SizedBox(height: 5.h),
                          SizedBox(
                            width: 150.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "FarmX AI",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Realtime chat with our AI chat model.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: plantDark),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  InkWell(
                    onTap: () {
                      Get.to(() => const WebViewPage(
                          title: "Knowledge Base",
                          uri: "https://farm-x.netlify.app/blog"));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                      ),
                      alignment: Alignment.centerLeft,
                      height: 200.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: plantLighter),
                          borderRadius: BorderRadius.all(Radius.circular(5.r))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Farmx Wiki",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Farmers knownelge base.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: plantDark),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Lottie.asset(
                            "assets/idea.json",
                            animate: true,
                            repeat: true,
                            reverse: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
