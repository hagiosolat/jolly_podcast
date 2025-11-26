// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/Features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:jolly_podcast/Features/authentication/presentation/views/login_screen.dart';
import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/Features/podcast/presentation/bloc/audio_player_bloc.dart';
import 'package:jolly_podcast/Features/podcast/presentation/bloc/podcast_bloc.dart';
import 'package:jolly_podcast/Features/podcast/presentation/views/audio_player_screen.dart';
import 'package:jolly_podcast/Features/podcast/presentation/views/podcast_screen.dart';
import 'package:jolly_podcast/core/services/injection_container.dart';
import 'package:jolly_podcast/dashboard.dart';

part 'names.dart';
