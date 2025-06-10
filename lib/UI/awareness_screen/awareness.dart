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
  const AwarenessPageView({
    super.key,
    required this.isDarkMode,
  });

  @override
  AwarenessPageViewState createState() => AwarenessPageViewState();
}

class AwarenessPageViewState extends State<AwarenessPageView> {
  //PutFeedBackModel putFeedBackModel = PutFeedBackModel();
  GetAwarenessModel getAwarenessModel = GetAwarenessModel();
  String? errorMessage;
  bool awarenessLoad = false;
  //  final _videos = [
  //   VideoItem(id: 'I7-G4rrQyx0', title: '${getAwarenessModel.data!.awareness!.title}', date: '${getAwarenessModel.data!.awareness!.event_date}'),
  //   const VideoItem(id: 'Z1iHVxOCCkA', title: 'Precautions', date: '05-04-2025'),
  //   const VideoItem(id: 'GLeUJhybJQw', title: 'Dental', date: '02-06-2025'),
  // ];
  List<VideoItem> get videosFromModel {
    if (getAwarenessModel?.data?.awareness == null) return [];
    return getAwarenessModel!.data!.awareness!.map((awareness) {
      final videoId = YoutubePlayer.convertUrlToId(awareness.url ?? '') ?? '';
      return VideoItem(
        id: videoId,
        title: awareness.title ?? '',
        date: awareness.eventDate ?? '',
      );
    }).toList();
  }

  bool feedLoad = false;
  @override
  void initState() {
    super.initState();
    context.read<ContactDentalBloc>().add(AwarenessDental());
    awarenessLoad = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final Color scaffoldBackgroundColor =
        widget.isDarkMode ? Colors.grey[900]! : whiteColor;
    final Color appBarBackgroundColor =
        widget.isDarkMode ? const Color(0xFF424242) : appPrimaryColor;

    final width = MediaQuery.of(context).size.width;

    final columns = width < 600 ? 1 : 2;

    final tileWidth = (width - 32 - (columns - 1) * 24) / columns;

    final thumbHeight = tileWidth * 9 / 16;

    final cardHeight = thumbHeight + 8 + 26 + 24 + 22;

    final Color highlightColor =
        widget.isDarkMode ? Colors.amber : Colors.pink[900]!;

    Widget mainContainer() {
      return awarenessLoad
          ? const SpinKitChasingDots(color: appPrimaryColor, size: 30)
          : getAwarenessModel.data == null
          ? Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02),
          alignment: Alignment.center,
          child: Text(
            "No Contacts found !!!",
            style: MyTextStyle.f16(
              appPrimaryColor,
              weight: FontWeight.w500,
            ),
          ),):Container(
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
                    height: MediaQuery.of(context).size.height * .28,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: MediaQuery.of(context).size.height * .28,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Text('Image not found',
                              style: TextStyle(color: Colors.black54)),
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
                      isDarkMode:
                          widget.isDarkMode), // Pass isDarkMode to video card
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
        )
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
                  style: TextStyle(
                    fontFamily: 'Times New Roman', // Applied font family
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Use dynamic color
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: Colors.white, // Always white for visibility
                ),
                onPressed: () {
                  setState(() {
                    //widget.isDarkMode = !widget.isDarkMode; // Toggle dark mode
                  });
                },
              ),
            ],
          ),
          body: BlocBuilder<ContactDentalBloc, dynamic>(
            buildWhen: ((previous, current) {
              debugPrint("current:$current");
              if (current is GetAwarenessModel) {
                getAwarenessModel = current;
                if (current.errorResponse != null) {
                  if (current.errorResponse!.errors != null &&
                      current.errorResponse!.errors!.isNotEmpty) {
                    errorMessage = current.errorResponse!.errors![0].message ??
                        "Something went wrong";
                  } else {
                    errorMessage = "Something went wrong";
                  }
                  showToast("$errorMessage", context, color: false);
                  setState(() {
                    awarenessLoad = false;
                  });
                } else if (getAwarenessModel.success == true) {
                  if (getAwarenessModel.data?.status == true) {
                    debugPrint("getEventModel:${getAwarenessModel.message}");
                    setState(() {
                      awarenessLoad = false;
                    });
                  } else if (getAwarenessModel.data?.status == false) {
                    debugPrint("getEventModel:${getAwarenessModel.message}");
                    setState(() {
                      showToast("${getAwarenessModel.message}", context,
                          color: false);
                      awarenessLoad = false;
                    });
                  }
                }
                return true;
              }
              return false;
            }),
            builder: (context, dynamic) {
              return mainContainer();
            },
          )),
    );
  }
}
