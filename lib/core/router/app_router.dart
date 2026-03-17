import 'package:go_router/go_router.dart';
import 'package:salaison_app/features/pieces/presentation/screens/home_screen.dart';
import 'package:salaison_app/features/creation_flow/presentation/add_piece_screen.dart';
import 'package:salaison_app/features/pieces/presentation/screens/piece_detail_screen.dart';
import 'package:salaison_app/features/pieces/presentation/screens/settings_screen.dart';
import 'package:salaison_app/features/pieces/presentation/screens/archives_screen.dart';
import 'package:salaison_app/features/pieces/presentation/screens/taxonomy_screen.dart';
import 'package:salaison_app/features/pieces/presentation/screens/tour_de_cave_screen.dart';
import 'package:salaison_app/features/pieces/presentation/screens/about_screen.dart';
import 'package:salaison_app/features/pieces/presentation/screens/mqtt_settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/mqtt-settings',
      builder: (context, state) => const MqttSettingsScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const AddPieceScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/archives',
      builder: (context, state) => const ArchivesScreen(),
    ),
    GoRoute(
      path: '/taxonomy',
      builder: (context, state) => const TaxonomyScreen(),
    ),
    GoRoute(
      path: '/tour-de-cave',
      builder: (context, state) => const TourDeCaveScreen(),
    ),
    GoRoute(
      path: '/piece/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PieceDetailScreen(pieceId: id);
      },
    ),
  ],
);
