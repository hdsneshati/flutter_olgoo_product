import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localisation/flutter_localisation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_olgoo_product/config/asset/theme/theme_data.dart';
import 'package:flutter_olgoo_product/config/routing/routes.dart';
import 'package:flutter_olgoo_product/core/dependency_injection/locator.dart';
import 'package:flutter_olgoo_product/feature/presentation/authentication/bloc/auth/auth.bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:size_config/size_config.dart';
import 'package:persian/persian.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _flutterLocalisationService.initialize();

  await locatorSetup();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthBloc(locator()))],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizeConfigInit(
      referenceHeight: 900,
      referenceWidth: 360,
      builder: (BuildContext context, Orientation orientation) {
        return MaterialApp.router(
          routerConfig: routs,
          title: 'OLGOO',
          theme: lightThemeData,
          locale: const Locale("fa", "IR"),
          supportedLocales: const [
            Locale("fa", "IR"),
            // Locale('en', 'US'),
          ],
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            PersianMaterialLocalizations.delegate,
            PersianCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            // GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}

final _flutterLocalisationService = TranslationService(
  config: const TranslationConfig(
    enableLogging: true,
    secretKey: "sk_live_Z095M95SsXi-LqI39vduaa9Vhc-Zjug8oXjnST-DGNs",
    supportedLocales: ['en', 'es'],
    projectId: 31,
    flavorName: 'Default',
  ),
);
