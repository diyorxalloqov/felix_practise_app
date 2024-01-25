import 'package:dio/dio.dart';
import 'package:felix_practise_app/service/ads_service.dart';
import 'package:felix_practise_app/service/auth_service.dart';
import 'package:felix_practise_app/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:felix_practise_app/view_model/bloc/practise_bloc.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    saveLocale: true,
    startLocale: const Locale("uz"),
    supportedLocales: const [Locale('uz'), Locale("ru"), Locale('ru', 'Cyrl')],
    path: "lib/core/lang",
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService(Dio());
    final adsService = AdsService(Dio());
    return BlocProvider(
      create: (context) => PractiseBloc(authService, adsService),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const HomePage(),
      ),
    );
  }
}
