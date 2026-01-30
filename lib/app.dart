import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/theme/app_colors.dart';
import 'presentation/home/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Bloc Boilerplate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: AppColors.colorScheme, useMaterial3: true),
        home: child,
      ),
      child: const HomePage(),
    );
  }
}
