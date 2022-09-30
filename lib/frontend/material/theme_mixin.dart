import 'package:wordnet_dictionary_app/lib.dart';

mixin StatelessThemeMixin on StatelessWidget {
  late ThemeData theme;
  late TextTheme text;
  late ColorScheme colors;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    text = theme.textTheme;
    colors = theme.colorScheme;
    return super.build(context);
  }

  Widget buildWith(BuildContext context);
}

mixin StatefulThemeMixin<T extends StatefulWidget> on State<T> {
  late ThemeData theme;
  late TextTheme text;
  late ColorScheme colors;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    text = theme.textTheme;
    colors = theme.colorScheme;
    return buildWith(context);
  }

  Widget buildWith(BuildContext context);
}
