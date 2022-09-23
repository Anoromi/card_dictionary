import 'package:wordnet_dictionary_app/lib.dart';

import 'custom_color.g.dart';

late CustomColors lightCustomColorsHarmonized;
late CustomColors darkCustomColorsHarmonized;

extension Custom on ThemeData {
  CustomColors get custom => extension<CustomColors>()!;
}
