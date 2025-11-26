import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/Features/podcast/presentation/bloc/podcast_bloc.dart';
import 'package:jolly_podcast/Features/podcast/presentation/views/widgets/editor_pick_card.dart';
import 'package:jolly_podcast/Features/podcast/presentation/views/widgets/episode_card.dart';
import 'package:jolly_podcast/core/common/assetsnames/assetname.dart';
import 'package:jolly_podcast/core/common/back_ground_widget.dart';
import 'package:jolly_podcast/core/common/color/app_color.dart';
import 'package:jolly_podcast/core/common/custom_text.dart';
import 'package:jolly_podcast/core/services/routes.dart';
import 'package:sizer/sizer.dart';

class PodcastScreen extends StatefulWidget {
  const PodcastScreen({super.key});

  @override
  State<PodcastScreen> createState() => _PodcastScreenState();
}

class _PodcastScreenState extends State<PodcastScreen> {
  List<EpisodeEntity> data = [];
  EpisodeEntity? getEditor;
  @override
  void initState() {
    context.read<PodcastBloc>().add(GetLatestEpisodesEvent());
    context.read<PodcastBloc>().add(GetEditorPickEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: BlocConsumer<PodcastBloc, PodcastState>(
        listener: (context, state) {
          if (state is PodCastDataLoaded) {
            data = state.podCastData;
          }
          if (state is EditorPickLoaded) {
            getEditor = state.editorPick;
          }
        },
        builder: (context, state) {
          return AppBaseView(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Row(
                      children: [
                        Image.asset(Appasset.firesideLogo),
                        SizedBox(width: 1.w),
                        CustomText(
                          text: "Hot & trending episodes",
                          fontWeight: FontWeight.w800,
                          fontSize: 0.25,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  data.isNotEmpty
                      ? SizedBox(
                          height: 41.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.AUDIOPLAYER,
                                    arguments: {
                                      'selectedEpisode': data[index],
                                      'allEpisodes': data,
                                    },
                                  );
                                },
                                child: EpisodeCard(episode: data[index]),
                              );
                            },
                          ),
                        )
                      : Container(
                          height: 41.h,
                          width: 75.w,
                          decoration: BoxDecoration(),
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: AppColor.faintGreen,
                            ),
                          ),
                        ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(Appasset.starIcon),
                        SizedBox(width: 4),
                        CustomText(
                          text: "Editor's pick",
                          fontWeight: FontWeight.w800,
                          fontSize: 0.25,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  if (getEditor != null) EditorPickCard(editorpick: getEditor),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
