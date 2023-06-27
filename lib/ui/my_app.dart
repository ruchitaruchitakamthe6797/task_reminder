import 'package:send_remider_to_user/constants/app_theme.dart';
import 'package:send_remider_to_user/constants/strings.dart';
import 'package:send_remider_to_user/data/repository.dart';
import 'package:send_remider_to_user/di/components/service_locator.dart';
import 'package:send_remider_to_user/stores/language/language_store.dart';
import 'package:send_remider_to_user/stores/theme/theme_store.dart';
import 'package:send_remider_to_user/ui/add_todo/todo_list.dart';
import 'package:send_remider_to_user/ui/contacts/contacts.dart';
import 'package:send_remider_to_user/utils/locale/app_localization.dart';
import 'package:send_remider_to_user/utils/routes/routes.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return CalendarControllerProvider(
            controller: EventController(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Strings.appName,
              theme: _themeStore.darkMode
                  // ? AppThemeData.darkThemeData
                  // : AppThemeData.lightThemeData,
                  ? themeDataDark
                  : themeData,
              routes: Routes.routes,
              locale: Locale(_languageStore.locale),
              supportedLocales: _languageStore.supportedLanguages
                  .map((language) => Locale(language.locale!, language.code))
                  .toList(),
              localizationsDelegates: [
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
                // Built-in localization of basic text for Cupertino widgets
                GlobalCupertinoLocalizations.delegate,
              ],
              // home: _userStore.isLoggedIn ? HomeScreen() : LoginScreen(),
              // home: SplashScreen(),
              home: TodoListScreen(),
              // home: MyApp1(),

            ),
          );
        },
      ),
    );
  }
}
