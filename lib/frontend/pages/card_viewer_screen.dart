import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wordnet_dictionary_app/backend/card_daos.dart';
import 'package:wordnet_dictionary_app/backend/data.dart';
import 'package:wordnet_dictionary_app/frontend/components/card_viewer.dart';
import 'package:wordnet_dictionary_app/frontend/pages/card_player.dart';
import 'package:wordnet_dictionary_app/lib.dart';

class CardViewerScreen extends StatefulWidget {
  final int cardId;
  const CardViewerScreen({super.key, required this.cardId});

  @override
  State<CardViewerScreen> createState() => _CardViewerScreenState();
}

class _CardViewerScreenState extends State<CardViewerScreen> {
  late CardsDao cardsDao;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cardsDao = context.read<CardsDao>();
  }

  void namingDialog() {
    Future.microtask(() async {
      final result = await showDialog<String>(
        context: context,
        builder: (context) => const _NamingDialog(),
      );

      if (result != null) {
        await cardsDao.unloadNew(result);
        Navigator.pop(context);
      }
    });
  }

  Future<PlayMode?> showPlaySheet() async {
    return showModalBottomSheet<PlayMode>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          side: BorderSide(width: 0)),
      builder: (context) {
        final theme = Theme.of(context);
        void endWith(PlayMode mode) {
          Navigator.of(context).pop(mode);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Learn",
                  style: theme.textTheme.headlineLarge,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () => endWith(PlayMode.term),
                      child: const Text("Terms")),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () => endWith(PlayMode.definition),
                      child: const Text("Definitions"))
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void play(CardInformation data, CardsDao cardsDao) async {
    final mode = await showPlaySheet();
    if (mode != null) {
      cardsDao.updateCardUse(data.cardPack.id);
      context.pushNamed("play", extra: PlayData(data, mode));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardDao = context.read<CardsDao>();
    return FutureBuilder<CardInformation>(
      future: cardDao.getCardInformation(widget.cardId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final data = snapshot.data!;
        final playFab = FloatingActionButton.extended(
          onPressed: () => play(data, cardDao),
          label: const Text("Learn"),
          icon: const Icon(Icons.play_arrow_rounded),
        );
        return Scaffold(
          body: CardList(information: data),
          floatingActionButton: widget.cardId == newItemsId
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (data.terms.isNotEmpty && data.definitions.isNotEmpty)
                      playFab,
                    const SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      splashColor: theme.colorScheme.onSurface,
                      highlightElevation: 20,
                      onPressed: () => namingDialog(),
                      heroTag: null,
                      child: const Icon(Icons.upload_rounded),
                    )
                  ],
                )
              : playFab,
        );
      },
    );
  }
}

class _NamingDialog extends StatefulWidget {
  const _NamingDialog();

  @override
  State<_NamingDialog> createState() => __NamingDialogState();
}

class __NamingDialogState extends State<_NamingDialog> {
  late TextEditingController textController;
  final _formKey = GlobalKey<FormState>();
  String? previousName;
  Future? nameVerification;
  late CardsDao cardsDao;
  bool properName = true;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textController.addListener(updateName);
  }

  void updateName() {
    if (previousName != textController.text) {
      setState(() {
        nameVerification =
            cardsDao.packNameUnused(textController.text).then((value) {
          if (mounted) {
            setState(() {
              nameVerification = null;
              properName = value;
            });
          }
        });
        previousName = textController.text;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cardsDao = context.read<CardsDao>();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void create() {
    if (nameVerification == null && properName) {
      Navigator.of(context).pop(textController.text);
    } else if (nameVerification == null) {
      updateName();
    }
  }

  void cancel() => Navigator.of(context).pop(null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Export to card pack"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: textController,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    width: 2, color: Theme.of(context).colorScheme.primary),
              ),
              errorText: !properName ? "Already used name" : null,
              label: const Text("Name")),
        ),
      ),
      actions: [
        TextButton(onPressed: cancel, child: const Text("Cancel")),
        AnimatedSize(
          duration: const Duration(milliseconds: 400),
          child: TextButton(
            onPressed: create,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Create"),
                if (nameVerification != null) const CircularProgressIndicator()
              ],
            ),
          ),
        )
      ],
    );
  }
}
