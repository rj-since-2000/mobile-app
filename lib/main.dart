import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:mobile_app/cv_theme.dart';
import 'package:mobile_app/locale/locales.dart';
import 'package:mobile_app/locator.dart';
import 'package:mobile_app/utils/router.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'ui/views/startup_view.dart';
import 'viewmodels/profile/edit_profile_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register all the models and services before the app starts
  await setupLocator();

  runApp(CircuitVerseMobile());
}

class CircuitVerseMobile extends StatelessWidget {
  // This widget is the root of CircuitVerse Mobile.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EditProfileViewModel>(
            create: (_) => EditProfileViewModel()),
      ],
      child: KeyboardDismissOnTap(
        child: ThemeProvider(
          saveThemesOnChange: true,
          loadThemeOnInit: true,
          themes: [
            AppTheme(
              id: 'light',
              data: ThemeData(
                primaryColor: CVTheme.primaryColor,
                accentColor: CVTheme.primaryColor,
                fontFamily: 'Poppins',
                cursorColor: CVTheme.primaryColor,
              ),
              description: 'LightTheme',
            ),
            AppTheme(
              id: 'dark',
              data: ThemeData(
                primaryColor: CVTheme.secondaryColor,
                accentColor: CVTheme.secondaryColor,
                fontFamily: 'Poppins',
                brightness: Brightness.dark,
                cursorColor: CVTheme.primaryColor,
              ),
              description: 'DarkTheme',
            ),
          ],
          child: ThemeConsumer(
            child: Builder(
              builder: (themeContext) => GetMaterialApp(
                title: 'CircuitVerse Mobile',
                localizationsDelegates: [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale('en', ''),
                ],
                onGenerateTitle: (BuildContext context) =>
                    AppLocalizations.of(context).title,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: CVRouter.generateRoute,
                theme: ThemeProvider.themeOf(themeContext).data,
                home: StartUpView(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
