import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple/Bloc/demo/demo_bloc.dart';
import 'package:simple/Reusable/color.dart';
import 'package:simple/Reusable/image.dart';
import 'package:simple/Reusable/text_styles.dart';
import 'package:simple/Alertbox/snackBarAlert.dart';
import 'package:simple/Bloc/Contact/contact_bloc.dart';
import 'package:simple/UI/Videoplayer/videoItems.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:simple/UI/Videoplayer/video_card.dart';
import 'package:simple/UI/buttomnavigationbar/buttomnavigation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple/ModelClass/Awareness/getAwarenessModel.dart';
import 'package:simple/Api/apiprovider.dart';

class AwarenessPage extends StatelessWidget {
  final bool isDarkMode;
  const AwarenessPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactDentalBloc>(
      create: (context) => ContactDentalBloc(),
      child: AwarenessPageView(isDarkMode: isDarkMode),
    );
  }
}

class AwarenessPageView extends StatefulWidget {
  final bool isDarkMode;
  const AwarenessPageView({super.key, required this.isDarkMode});

  @override
  AwarenessPageViewState createState() => AwarenessPageViewState();
}

class AwarenessPageViewState extends State<AwarenessPageView> {
  GetAwarenessModel getAwarenessModel = GetAwarenessModel();
  String? errorMessage;
  bool awarenessLoad = false;
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
    context.read<ContactDentalBloc>().add(AwarenessDental());
    awarenessLoad = true;
  }

  List<VideoItem> get videosFromModel {
    if (getAwarenessModel.data?.awareness == null) return [];
    return getAwarenessModel.data!.awareness!.map((awareness) {
      final videoId = YoutubePlayer.convertUrlToId(awareness.url ?? '') ?? '';
      return VideoItem(
        id: videoId,
        title: awareness.title ?? '',
        date: awareness.eventDate ?? '',
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final columns = width < 600 ? 1 : 2;
    final tileWidth = (width - 32 - (columns - 1) * 24) / columns;
    final thumbHeight = tileWidth * 9 / 16;
    final cardHeight = thumbHeight + 8 + 26 + 24 + 22;

    final scaffoldBackgroundColor = isDarkMode ? Colors.grey[900]! : whiteColor;
    final appBarBackgroundColor = isDarkMode ? const Color(0xFF424242) : appPrimaryColor;
    final highlightColor = isDarkMode ? Colors.amber : Colors.pink[900]!;

    Widget mainContainer() {
      if (awarenessLoad) {
        return const Center(
          child: SpinKitChasingDots(color: appPrimaryColor, size: 30),
        );
      }

      if (getAwarenessModel.data == null || videosFromModel.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.02),
            child: Text(
              "No awareness videos available!",
              style: MyTextStyle.f16(appPrimaryColor, weight: FontWeight.w500),
            ),
          ),
        );
      }

      return Container(
        color: scaffoldBackgroundColor,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/image/awarenessimage.jpg',
                    height: height * .28,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: height * .28,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Text('Image not found', style: TextStyle(color: Colors.black54)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, i) => VideoCard(
                    item: videosFromModel[i],
                    isDarkMode: isDarkMode,
                  ),
                  childCount: videosFromModel.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisExtent: cardHeight,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
              (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: appBarBackgroundColor,
          title: Row(
            children: [
              Image.asset(Images.logo1, height: 50, width: 50),
              const SizedBox(width: 10),
               Text(
                'PAUL DENTAL CARE',
                style:MyTextStyle.f20(
                    whiteColor
                ),
               ),
            ],
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(
          //       isDarkMode ? Icons.light_mode : Icons.dark_mode,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       setState(() {
          //         isDarkMode = !isDarkMode;
          //       });
          //     },
          //   ),

        ),
        body: BlocBuilder<ContactDentalBloc, dynamic>(
          buildWhen: (previous, current) {
            if (current is GetAwarenessModel)
            {
              getAwarenessModel = current;
              if (current.errorResponse != null) {
                final errorList = current.errorResponse!.errors;
                errorMessage = (errorList != null && errorList.isNotEmpty)
                    ? errorList[0].message ?? "Something went wrong"
                    : "Something went wrong";

                showToast(errorMessage!, context, color: false);
                setState(() => awarenessLoad = false);
              } else if (current.success == true) {
                if (current.data?.status == true) {
                  debugPrint("getEventModel: ${current.message}");
                  setState(() => awarenessLoad = false);
                } else {
                  debugPrint("getEventModel: ${current.message}");
                  showToast(current.message ?? "Unknown Error", context, color: false);
                  setState(() => awarenessLoad = false);
                }
              }
              return true;
            }
            return false;
          },
          builder: (context, state) {
            return mainContainer();
          },
        ),
      ),
    );
  }
}
