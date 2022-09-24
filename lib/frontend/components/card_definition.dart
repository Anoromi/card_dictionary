import 'package:wordnet_dictionary_app/frontend/pages/card_player.dart';
import 'package:wordnet_dictionary_app/lib.dart';

enum DisplayMode {
  term,
  definition;

  static DisplayMode fromPlayMode(PlayMode playMode) {
    switch (playMode) {
      case PlayMode.term:
        return DisplayMode.term;
      case PlayMode.definition:
        return DisplayMode.definition;
    }
  }
}

class CardDefinition extends StatelessWidget {
  final String front;
  final List<String> back;
  final DisplayMode mode;
  final Color textColor;

  const CardDefinition(
      {super.key,
      required this.front,
      required this.back,
      required this.mode,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            alignment: Alignment.topLeft,
            child: Text(
              front,
              style: theme.textTheme.titleSmall?.copyWith(color: textColor),
            ),
          ),
          flex: mode == DisplayMode.term ? 2 : 3,
        ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Icon(Icons.arrow_forward_ios_rounded,
              color: theme.colorScheme.onSurface.withOpacity(0.6)),
        )),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: back
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      child: Text(
                        e,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: textColor),
                      ),
                    ))
                .toList(),
          ),
          flex: mode == DisplayMode.term ? 3 : 2,
        ),
      ],
    );
  }
}
