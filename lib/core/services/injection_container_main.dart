part of 'injection_container.dart';

final sl = GetIt.instance;
Future<void> init() async {
  await _authInit();
}

Future<void> _authInit() async {
  sl
    ..registerFactory(() => AuthBloc(login: sl()))
    ..registerLazySingleton(() => LoginUsecase(sl()))
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepoImpl(datasource: sl()),
    )
    ..registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(apiclient: sl()),
    )
    ..registerLazySingleton<ApiClient>(() => ApiClient())
    ..registerFactory(() => PodcastBloc(getEpisodes: sl(), getEditorPick: sl()))
    ..registerLazySingleton(() => LatestEpisodesUsecase(sl()))
    ..registerLazySingleton(() => GetEditorPickUseCase(sl()))
    ..registerLazySingleton<PodcastRepository>(
      () => PodcastRepositoryImpl(datasource: sl()),
    )
    ..registerLazySingleton<PodCastDatasource>(
      () => PodCastDatasourceImpl(apiClient: sl()),
    )
    //DEPENDENCY INJECTION FOR AUDIO PLAYER LOGIC.
    ..registerLazySingleton(() => AudioPlayer())
    ..registerLazySingleton<AudioPlayerRepo>(
      () => AudioPlayerRepoImpl(audioPlayer: sl()),
    )
    ..registerFactory(() => AudioPlayerBloc(audioPlayerRepo: sl()));
}
