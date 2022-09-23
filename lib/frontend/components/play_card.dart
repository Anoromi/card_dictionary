import 'package:wordnet_dictionary_app/lib.dart';

class PlayCard extends StatelessWidget {
  final String front;
  final List<String> back;
  final bool currentFront;
  const PlayCard(
      {super.key,
      required this.front,
      required this.back,
      required this.currentFront});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget displayedData;
    if (currentFront) {
      displayedData = Center(
        child: Text(front,
            style: theme.textTheme.headlineSmall
                ?.copyWith(color: theme.colorScheme.onPrimaryContainer)),
      );
    } else {
      displayedData = Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: back
                .map((e) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        e,
                        style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer),
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    }

    return Material(
      color: theme.colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: displayedData,
      ),
    );
  }
}
