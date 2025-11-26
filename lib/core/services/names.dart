// ignore_for_file: constant_identifier_names

part of 'routes.dart';

class AppRoutes {
  static const INITIAL = '/';
  static const PODCAST = '/podCast';
  static const AUDIOPLAYER = '/audio_Player';
  static const DASHBOARD = "/dashboard";
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.INITIAL:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: LoginScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.PODCAST:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<PodcastBloc>(),
          child: PodcastScreen(),
        ),
        settings: settings,
      );
    case AppRoutes.AUDIOPLAYER:
      final params = settings.arguments as Map<String, dynamic>;
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<AudioPlayerBloc>(),
          child: AudioPlayerScreen(
            selectedEpisode: params["selectedEpisode"] as EpisodeEntity,
            episodes: params["allEpisodes"] as List<EpisodeEntity>,
          ),
        ),
        settings: settings,
      );
    case AppRoutes.DASHBOARD:
      return _pageBuilder(
        (context) => BlocProvider(
          create: (context) => sl<PodcastBloc>(),
          child: Dashboard(),
        ),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: LoginScreen(),
        ),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, _, child) =>
        FadeTransition(opacity: animation, child: child),
    pageBuilder: (context, _, _) => page(context),
  );
}
