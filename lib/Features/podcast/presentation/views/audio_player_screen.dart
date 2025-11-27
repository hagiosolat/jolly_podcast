import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/Features/podcast/presentation/bloc/audio_player_bloc.dart';
import 'package:jolly_podcast/Features/podcast/presentation/views/widgets/editor_pick_card.dart';
import 'package:jolly_podcast/Features/podcast/presentation/views/widgets/episode_card.dart';
import 'package:jolly_podcast/Features/podcast/presentation/views/widgets/progress_bar.dart';
import 'package:jolly_podcast/core/common/assetsnames/assetname.dart';
import 'package:jolly_podcast/core/common/color/app_color.dart';
import 'package:jolly_podcast/core/common/custom_text.dart';
import 'package:sizer/sizer.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({
    super.key,
    required this.episodes,
    required this.selectedEpisode,
  });

  final List<EpisodeEntity> episodes;
  final EpisodeEntity selectedEpisode;

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  Duration? totalDuration;
  Duration? buffer;
  Duration? currentPosition;
  late final AudioPlayerBloc? _audioBloc;
  bool isPlaying = false;
  bool isLoading = false;
  EpisodeEntity? currentEpisode;

  @override
  void initState() {
    context.read<AudioPlayerBloc>().add(
      LoadAudioPlayList(
        playList: widget.episodes,
        initialIndex: widget.episodes.indexWhere(
          (episode) => episode == widget.selectedEpisode,
        ),
      ),
    );
    //**THIS WILL SUBSCRIBE TO THE STREAM BEFORE IT STARTS TO LISTEN TO THE EVENTS OR  */
    //**OR THE PLAYER STATE CHANGE */
    _audioBloc = context.read<AudioPlayerBloc>();
    _audioBloc?.add(PlayerStateChangeEvent());
    _audioBloc?.add(GetCurrentAudioBufferPosition());
    _audioBloc?.add(GetCurrentAudioPosition());
    _audioBloc?.add(GetAudioTotalDuration());
    _audioBloc?.add(GetCurrentAudioEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        _audioBloc?.add(DisposeAudioPlayerEvent());
      },
      child: BlocConsumer<AudioPlayerBloc, AudioPlayerStates>(
        listener: (context, state) {
          if (state is AudioPlayerLoaded) {
            totalDuration = state.totalAudioDuration;
            isLoading = false;
          }
          if (state is CurrentSongLoaded) {
            currentEpisode = state.currentEpisode;
            isLoading = false;
          }
          if (state is AudioPlayerPlaying) {
            isPlaying = state.isPlaying;
            isLoading = false;
          }
          if (state is AudioPlayerPaused) {
            isPlaying = !state.isPaused;
            isLoading = false;
          }
          if (state is AudioCurrentDuration) {
            currentPosition = state.current;
          }
          if (state is AudioBufferDuration) {
            buffer = state.buffer;
          }
          if (state is AudioPlayerLoading) {
            isLoading = true;
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                 gradient: RadialGradient(
                  center: Alignment(1.0, -0.5),
                  colors: [
                    Color(0xFF56B512),
                    Color(0xFF33932A),
                    Color(0xFF197547),
                    Color(0xFF197547),
                  ],
                  stops: [0.0, 0.35, 0.8, 1.0],
                  radius: 1.7,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _audioBloc?.add(DisposeAudioPlayerEvent());
                        Navigator.pop(context);
                      },
                      child: interactionButton(Appasset.downwardArrow, 2.0),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      height: 39.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            currentEpisode?.picture_url ??
                                widget.selectedEpisode.picture_url ??
                                '',
                          ),
                        ),
                      ),
                    ),
                    //PODCAST DETAILS
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 9.w),
                      child: Column(
                        children: [
                          CustomText(
                            text:
                                "${currentEpisode?.title ?? widget.selectedEpisode.title}",
                            fontWeight: FontWeight.w800,
                            fontSize: 0.25,
                            overflow: TextOverflow.ellipsis,
                          ),
                          CustomText(
                            text:
                                "${currentEpisode?.description ?? widget.selectedEpisode.description}",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    //PROGRESS BAR INDICATOR
                    ProgressBar(
                      bufferProgress:
                          (buffer?.inMicroseconds ?? 0) /
                          (totalDuration?.inMicroseconds ?? 0),
                      audioProgress:
                          (currentPosition?.inMicroseconds ?? 0.0) /
                          (totalDuration?.inMicroseconds ?? 0),
                    ),
                    //TIMER INDICATOR
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 1.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text:
                                "${currentPosition?.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
                                "${(currentPosition?.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                            fontWeight: FontWeight.w700,
                          ),
                          CustomText(
                            text:
                                "${totalDuration?.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
                                "${(totalDuration?.inSeconds.remainder(60).toString().padLeft(2, '0'))}",
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //PREVIOUS PODCAST BUTTON
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: AppColor.lightGreen,
                              highlightColor: AppColor.lightGreen,
                              onTap: () => context.read<AudioPlayerBloc>().add(
                                PlayPreviousAudioEvent(),
                              ),
                              child: SvgPicture.asset(Appasset.previousIcon),
                            ),
                          ),
                          //FORWARD PODCAST BY 10 SECONDS
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: AppColor.lemonGreen,
                              highlightColor: AppColor.lightGreen,
                              onTap: () => context.read<AudioPlayerBloc>().add(
                                AdjustAudioCurrentPosition(
                                  adjustedDuration:
                                      (currentPosition ??
                                              Duration.zero -
                                                  Duration(seconds: 10)) <
                                          Duration.zero
                                      ? Duration.zero
                                      : (currentPosition ?? Duration.zero) -
                                            Duration(seconds: 10),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                    Appasset.backward,
                                    width: 7.5.w,
                                    height: 7.5.w,
                                  ),
                                  Positioned(
                                    left: 2.4.w,
                                    bottom: 1.4.h,
                                    child: SvgPicture.asset(Appasset.tenLogo),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //PLAY AND PAUSE BUTTON
                          InkWell(
                            onTap: () {
                              if (isPlaying) {
                                context.read<AudioPlayerBloc>().add(
                                  PauseAudioPlayerEvent(),
                                );
                              } else {
                                context.read<AudioPlayerBloc>().add(
                                  PlayAudioPlayerEvent(),
                                );
                              }
                            },
                            child: isPlaying
                                ? interactionButton(Appasset.pauseLogo, 3.0)
                                : interactionButton(Appasset.playIcon, 3.0),
                          ),
                          //FAST FORWARD BY TEN 10 SECONDS
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: AppColor.lemonGreen,
                              highlightColor: AppColor.lightGreen,
                              onTap: () => context.read<AudioPlayerBloc>().add(
                                AdjustAudioCurrentPosition(
                                  adjustedDuration:
                                      Duration(seconds: 10) +
                                      (currentPosition ?? Duration(seconds: 0)),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                    Appasset.fastforward,
                                    height: 7.5.w,
                                    width: 7.5.w,
                                  ),
                                  Positioned(
                                    left: 2.4.w,
                                    bottom: 1.4.h,
                                    // alignment: Alignment(1.5, 0.1),
                                    child: SvgPicture.asset(Appasset.tenLogo),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //NEXT AUDIO BUTTON
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: AppColor.lemonGreen,
                              highlightColor: AppColor.lightGreen,
                              onTap: () => context.read<AudioPlayerBloc>().add(
                                PlayNextAudioEvent(),
                              ),
                              child: SvgPicture.asset(Appasset.nextIcon),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 7.h,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: BoxTiles(
                              assetName: Appasset.queueIcon,
                              title: "Add to queue",
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: BoxTiles(
                              assetName: Appasset.favouriteIcon,
                              title: "Save",
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: BoxTiles(
                              assetName: Appasset.shareIcon,
                              title: "Share episode",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 7.h,
                      child: Row(
                        children: [
                          Expanded(
                            child: BoxTiles(
                              assetName: Appasset.addIcon,
                              title: "Add to playlist",
                            ),
                          ),
                          Expanded(
                            child: BoxTiles(
                              assetName: Appasset.iphoneforwardarrow,
                              title: "Go to episode page",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
