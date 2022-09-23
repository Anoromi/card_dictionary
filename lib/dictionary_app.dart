import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordnet_dictionary_app/frontend/database_provider.dart';
import 'package:wordnet_dictionary_app/frontend/material/color_schemes.g.dart';
import 'package:wordnet_dictionary_app/frontend/material/custom_color.dart';
import 'package:wordnet_dictionary_app/frontend/material/custom_color.g.dart';
import 'package:wordnet_dictionary_app/frontend/model/main_navigation_model.dart';
import 'package:wordnet_dictionary_app/frontend/router.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      ColorScheme lightScheme;
      ColorScheme darkScheme;

      if (lightDynamic != null && darkDynamic != null) {
        lightScheme = lightDynamic.harmonized();
        lightCustomColorsHarmonized = lightCustomColors.harmonized(lightScheme);

        // Repeat for the dark color scheme.
        darkScheme = darkDynamic.harmonized();
        darkCustomColorsHarmonized = darkCustomColors.harmonized(darkScheme);
      } else {
        // Otherwise, use fallback schemes.
        lightScheme = lightColorScheme;
        darkScheme = darkColorScheme;
        lightCustomColorsHarmonized = lightCustomColors;
        darkCustomColorsHarmonized = darkCustomColors;
      }
      return MaterialApp.router(
        routerConfig: router,
        builder: (context, child) => ChangeNotifierProvider(
          create: (context) => MainNavigationModel(),
          child: DatabaseProvider(child: child),
        ),
        theme: ThemeData(
            colorScheme: lightScheme,
            extensions: [lightCustomColorsHarmonized],
            useMaterial3: true),
        darkTheme: ThemeData(
            colorScheme: darkScheme,
            extensions: [darkCustomColorsHarmonized],
            useMaterial3: true),
            themeMode: ThemeMode.dark,
      );
    });
  }
}
