import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/Provider/form_data.dart';
import 'package:my_flutter_app/pages/home_page.dart';
import 'package:my_flutter_app/pages/screen_one.dart';
import 'package:my_flutter_app/pages/screen_two.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FormData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: HomePage());
          },
        ),
        GoRoute(
          path: '/screen-one',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: ScreenOne());
          },
        ),
        GoRoute(
          path: '/screen-two',
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: ScreenTwo());
          },
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
