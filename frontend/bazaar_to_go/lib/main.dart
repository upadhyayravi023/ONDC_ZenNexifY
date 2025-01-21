import 'package:bazaar_to_go/view/Dashboard/chat_bot.dart';
import 'package:bazaar_to_go/view/auth/register_screen.dart';
import 'package:bazaar_to_go/view/order/order.dart';
import 'package:bazaar_to_go/view/profile/profile.dart';
import 'package:bazaar_to_go/view/store/catelog.dart';
import 'package:bazaar_to_go/view/store/register_shop.dart';
import 'package:bazaar_to_go/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  ProductCatalogScreen(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Get the media query size
        final mediaQueryData = MediaQuery.of(context);
        final designSize =
            mediaQueryData.size.width > mediaQueryData.size.height
                ? const Size(800, 300)
                : const Size(300, 800);

        // Initialize ScreenUtil with the correct design size
        ScreenUtil.init(
          context,
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
        );

        return child!;
      },
    );
  }
}



