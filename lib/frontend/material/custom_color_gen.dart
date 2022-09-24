import 'package:flutter/material.dart';

const green = Color(0xFF006013);

CustomColors lightCustomColors = const CustomColors(
  green: Color(0xFF176D1F),
  ongreen: Color(0xFFFFFFFF),
  greenContainer: Color(0xFFA1F797),
  onGreenContainer: Color(0xFF002203),
);

CustomColors darkCustomColors = const CustomColors(
  green: Color(0xFF85DA7E),
  ongreen: Color(0xFF003908),
  greenContainer: Color(0xFF00530F),
  onGreenContainer: Color(0xFFA1F797),
);


@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.green,
    required this.ongreen,
    required this.greenContainer,
    required this.onGreenContainer,
  });

  final Color? green;
  final Color? ongreen;
  final Color? greenContainer;
  final Color? onGreenContainer;

  @override
  CustomColors copyWith({
    Color? green,
    Color? ongreen,
    Color? greenContainer,
    Color? ongreenContainer,
  }) {
    return CustomColors(
      green: green ?? this.green,
      ongreen: ongreen ?? this.ongreen,
      greenContainer: greenContainer ?? this.greenContainer,
      onGreenContainer: ongreenContainer ?? this.onGreenContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      green: Color.lerp(green, other.green, t),
      ongreen: Color.lerp(ongreen, other.ongreen, t),
      greenContainer: Color.lerp(greenContainer, other.greenContainer, t),
      onGreenContainer: Color.lerp(onGreenContainer, other.onGreenContainer, t),
    );
  }

  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith();
  }
}
