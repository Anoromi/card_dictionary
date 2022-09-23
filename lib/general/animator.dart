import 'package:wordnet_dictionary_app/lib.dart';

class AnimatorBuilder {
  final AnimationController controller;
  AnimatorBuilder(
      {double? value,
      Duration? duration,
      Duration? reverseDuration,
      String? debugLabel,
      double lowerBound = 0.0,
      double upperBound = 1.0,
      AnimationBehavior animationBehavior = AnimationBehavior.normal,
      required TickerProvider vsync})
      : controller = AnimationController(
            value: value,
            duration: duration,
            reverseDuration: reverseDuration,
            debugLabel: debugLabel,
            lowerBound: lowerBound,
            upperBound: upperBound,
            animationBehavior: animationBehavior,
            vsync: vsync);
  Animator create(
      Animation<double> Function(AnimationController parent) builder) {
    return Animator(controller, builder(controller));
  }
}

class Animator {
  final AnimationController controller;
  final Animation<double> animation;

  Animator(this.controller, this.animation);

  void updateAnimation(bool direction) {
    if (!controller.isCompleted && direction) {
      controller.forward(from: controller.value);
    } else if (!controller.isDismissed && !direction) {
      controller.reverse(from: controller.value);
    }
  }

  void dispose() {
    controller.dispose();
  }
}
