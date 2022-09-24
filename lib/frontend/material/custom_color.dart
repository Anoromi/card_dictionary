import 'package:wordnet_dictionary_app/lib.dart';

import 'custom_color_gen.dart';

late CustomColors lightCustomColorsHarmonized;
late CustomColors darkCustomColorsHarmonized;

extension Custom on ThemeData {
  CustomColors get custom => extension<CustomColors>()!;
}
