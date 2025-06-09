import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple/Bloc/demo/demo_bloc.dart';
import 'package:simple/Reusable/color.dart';
import 'package:simple/Reusable/image.dart';
import 'package:simple/UI/Videoplayer/videoItems.dart';
import 'package:simple/UI/Videoplayer/video_card.dart';
import 'package:simple/UI/buttomnavigationbar/buttomnavigation.dart';

class AwarenessPage extends StatelessWidget {
  final bool isDarkMode;
  const AwarenessPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DemoBloc(),
      child: AwarenessPageView(
        isDarkMode: isDarkMode,
      ),
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
  static const _videos = [
    VideoItem(id: 'I7-G4rrQyx0', title: 'Awarez', date: '02-04-2025'),
    VideoItem(id: 'Z1iHVxOCCkA', title: 'Precautions', date: '05-04-2025'),
    VideoItem(id: 'GLeUJhybJQw', title: 'Dental', date: '02-06-2025'),
  ];

  String? errorMessage;
  bool feedLoad = false;
  @override
  void initState() {
    super.initState();
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
                    'assets/image/awarenessimage.jpg', // Ensure this image path is correct
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
                      item: _videos[i],
                      isDarkMode:
                          widget.isDarkMode), // Pass isDarkMode to video card
                  childCount: _videos.length,
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
          body: BlocBuilder<DemoBloc, dynamic>(
            buildWhen: ((previous, current) {
              debugPrint("current:$current");
              // if (current is PutFeedBackModel) {
              //   putFeedBackModel = current;
              //   if (current.errorResponse != null) {
              //     if (current.errorResponse!.errors != null &&
              //         current.errorResponse!.errors!.isNotEmpty) {
              //       errorMessage = current.errorResponse!.errors![0].message ??
              //           "Something went wrong";
              //     } else {
              //       errorMessage = "Something went wrong";
              //     }
              //     showToast("$errorMessage", context, color: false);
              //     setState(() {
              //       feedLoad = false;
              //     });
              //   } else if (putFeedBackModel.success == true) {
              //     if (putFeedBackModel.data?.status == true) {
              //       debugPrint("putFeedBackModel:${putFeedBackModel.message}");
              //       setState(() {
              //         showToast("${putFeedBackModel.message}", context,
              //             color: true);
              //         feedLoad = false;
              //       });
              //       Navigator.of(context).pushReplacement(MaterialPageRoute(
              //           builder: (context) => const DashboardScreen(
              //             selectTab: 3,
              //           )));
              //     } else if (putFeedBackModel.data?.status == false) {
              //       debugPrint("putFeedBackModel:${putFeedBackModel.message}");
              //       setState(() {
              //         showToast("${putFeedBackModel.message}", context,
              //             color: false);
              //         feedLoad = false;
              //       });
              //     }
              //   }
              //   return true;
              // }
              return false;
            }),
            builder: (context, dynamic) {
              return mainContainer();
            },
          )),
    );
  }
}
