import 'package:go_router/go_router.dart';
import 'package:wordnet_dictionary_app/frontend/pages/card_pack_screen.dart';
import 'package:wordnet_dictionary_app/frontend/pages/card_player.dart';
import 'package:wordnet_dictionary_app/frontend/pages/card_viewer_screen.dart';
import 'package:wordnet_dictionary_app/frontend/pages/results_screen.dart';
import 'package:wordnet_dictionary_app/frontend/pages/search_screen.dart';
import 'package:wordnet_dictionary_app/lib.dart';

GoRouter router = GoRouter(
  initialLocation: "/dictionary",
  // initialLocation: "/cards/card/1",
  routes: [
    GoRoute(
      path: '/dictionary',
      name: 'dictionary',
      pageBuilder: (context, state) =>
          const MaterialPage(child: SearchScreen()),
    ),
    GoRoute(
      path: '/cards',
      name: 'cards',
      pageBuilder: ((context, state) =>
          const MaterialPage(child: CardPackScreen())),
      routes: [
        GoRoute(
          path: 'card/:cardId',
          name: 'card',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: CardViewerScreen(
                    cardId: int.parse(state.params['cardId']!)));
          },
        )
      ],
    ),
    GoRoute(
        path: '/play',
        name: 'play',
        pageBuilder: (context, state) {
          final data = state.extra as PlayData;
          return MaterialPage(child: CardPlayerScreen(data: data));
        }),
    GoRoute(
        path: '/results',
        name: 'play_results',
        pageBuilder: (context, state) {
          final data = state.extra as ResultsData;
          return MaterialPage(child: PlayResultsScreen(data: data));
        })
  ],
);
