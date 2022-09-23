import 'package:wordnet_dictionary_app/lib.dart';

mixin SingleAnimatorMixin<T extends StatefulWidget> on State<T>
    implements SingleTickerProviderStateMixin<T> {
  Animator createAnimator();
  late Animator animator;

  @override
  void initState() {
    animator = createAnimator();
    super.initState();
  }

  @override
  void dispose() {
    animator.dispose();
    super.dispose();
  }
}
