import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wordnet_dictionary_app/frontend/model/main_navigation_model.dart';
import 'package:wordnet_dictionary_app/lib.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainNavigationModel>();
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.library_books), label: "Dictionary"),
        BottomNavigationBarItem(
            icon: Icon(Icons.signal_cellular_no_sim_rounded), label: "Cards")
      ],
      onTap: (value) {
        final newRoute = MainRoutes.values[value];
        if (model.currentRoute != newRoute) {
          model.currentRoute = newRoute;
          context.goNamed(newRoute.routeName());
        }
      },
      currentIndex: MainRoutes.values.indexOf(model.currentRoute),
    );
  }
}
