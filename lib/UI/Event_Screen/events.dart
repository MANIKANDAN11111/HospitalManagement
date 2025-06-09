import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple/Alertbox/snackBarAlert.dart';
import 'package:simple/Bloc/Contact/contact_bloc.dart';
import 'package:simple/Bloc/demo/demo_bloc.dart';
import 'package:simple/ModelClass/Events/getEventModel.dart';
import 'package:simple/Reusable/color.dart';
import 'package:simple/Reusable/image.dart';
import 'package:simple/Reusable/text_styles.dart';
import 'package:simple/UI/buttomnavigationbar/buttomnavigation.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventsPage extends StatelessWidget {
  final bool isDarkMode;
  const EventsPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactDentalBloc(),
      child: EventsPageView(
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class EventsPageView extends StatefulWidget {
  final bool isDarkMode;
  const EventsPageView({
    super.key,
    required this.isDarkMode,
  });

  @override
  EventsPageViewState createState() => EventsPageViewState();
}

class EventsPageViewState extends State<EventsPageView> {
  GetEventModel getEventModel = GetEventModel();
  final String firstCardImage =
      'assets/image/newsEvent1.png'; // doctor with patient
  final String secondCardImage = 'assets/image/newsEvent2.png';
  String? errorMessage;
  bool eventLoad = false;
  final int totalImages = 5;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _previousImage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextImage() {
    if (_currentPage < totalImages - 1) {
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ContactDentalBloc>().add(EventDental());
    eventLoad = true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final Color scaffoldBackgroundColor =
        widget.isDarkMode ? Colors.grey[900]! : whiteColor;
    final Color appBarBackgroundColor =
        widget.isDarkMode ? const Color(0xFF424242) : appPrimaryColor;
    final Color backgroundColor =
        widget.isDarkMode ? Colors.grey[900]! : const Color(0xFFF1F2F7);
    final Color cardColor =
        widget.isDarkMode ? Colors.grey[800]! : Colors.white;
    final Color titleColor =
        widget.isDarkMode ? Colors.amberAccent : Colors.red;
    final Color textColor = widget.isDarkMode ? Colors.white : Colors.black87;
    final Color descriptionColor =
        widget.isDarkMode ? Colors.grey[300]! : Colors.black;
    final Color iconColor = widget.isDarkMode ? Colors.white : Colors.black;

    Widget mainContainer() {
      return eventLoad
          ? const SpinKitChasingDots(color: appPrimaryColor, size: 30)
          : getEventModel.data == null
              ? Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  alignment: Alignment.center,
                  child: Text(
                    "No Events found !!!",
                    style: MyTextStyle.f16(
                      appPrimaryColor,
                      weight: FontWeight.w500,
                    ),
                  ))
              : Container(
                  color: backgroundColor, // Set background color based on theme
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: getEventModel.data!.events!
                          .map(
                            (e) => Column(
                              children: [
                                // First Card
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 4,
                                  color: cardColor, // Apply dynamic card color
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        // ClipRRect(
                                        //   borderRadius:
                                        //       BorderRadius.circular(12),
                                        //   child: Image.asset(
                                        //     secondCardImage,
                                        //     fit: BoxFit.cover,
                                        //     width: double.infinity,
                                        //     errorBuilder:
                                        //         (context, error, stackTrace) {
                                        //       return Container(
                                        //         height: 200,
                                        //         color: Colors.grey[300],
                                        //         child: const Center(
                                        //           child: Text('Image not found',
                                        //               style: TextStyle(
                                        //                   color:
                                        //                       Colors.black54)),
                                        //         ),
                                        //       );
                                        //     },
                                        //   ),
                                        // ),
                                        CachedNetworkImage(
                                          imageUrl: "${e.bannerImage}",
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) {
                                            return const Icon(
                                              Icons.error,
                                              size: 30,
                                              color: appHomeTextColor,
                                            );
                                          },
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const SpinKitCircle(
                                                  color: appPrimaryColor,
                                                  size: 30),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          '${e.title} ',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                titleColor, // Apply dynamic title color
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Date: ${e.eventDate}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                textColor, // Apply dynamic text color
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "${e.description}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  descriptionColor), // Apply dynamic description color
                                        ),
                                        const SizedBox(height: 12),
                                        Center(
                                          child: Text(
                                            'Event Images',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  textColor, // Apply dynamic text color
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                height: 200,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: PageView.builder(
                                                  controller: _pageController,
                                                  itemCount: totalImages,
                                                  onPageChanged: (index) {
                                                    setState(() {
                                                      _currentPage = index;
                                                    });
                                                  },
                                                  itemBuilder:
                                                      (context, index) {
                                                    // Use different images based on index, or dynamic content
                                                    // For now, using the same image for demonstration
                                                    final imageToDisplay =
                                                        index % 2 == 0
                                                            ? secondCardImage
                                                            : firstCardImage;
                                                    return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: Image.asset(
                                                        imageToDisplay,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Container(
                                                            color: Colors
                                                                .grey[300],
                                                            child: const Center(
                                                              child: Text(
                                                                  'Image not found',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54)),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              child: IconButton(
                                                icon: Icon(Icons.arrow_back_ios,
                                                    color:
                                                        iconColor), // Apply dynamic icon color
                                                onPressed: _previousImage,
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: IconButton(
                                                icon: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color:
                                                        iconColor), // Apply dynamic icon color
                                                onPressed: _nextImage,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Second Card
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 4,
                                  color: cardColor, // Apply dynamic card color
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.asset(
                                            firstCardImage,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                height: 200,
                                                color: Colors.grey[300],
                                                child: const Center(
                                                  child: Text('Image not found',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          'Testing 2',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                titleColor, // Apply dynamic title color
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Date: 21-03-2025',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                textColor, // Apply dynamic text color
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Testing',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  descriptionColor), // Apply dynamic description color
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
    }

    return WillPopScope(
      onWillPop: () async {
        if (ModalRoute.of(context)?.isCurrent == true) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
            (route) => false,
          );
          return false;
        }
        return true;
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
              if (current is GetEventModel) {
                getEventModel = current;
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
                    eventLoad = false;
                  });
                } else if (getEventModel.success == true) {
                  if (getEventModel.data?.status == true) {
                    debugPrint("getEventModel:${getEventModel.message}");
                    setState(() {
                      eventLoad = false;
                    });
                  } else if (getEventModel.data?.status == false) {
                    debugPrint("getEventModel:${getEventModel.message}");
                    setState(() {
                      showToast("${getEventModel.message}", context,
                          color: false);
                      eventLoad = false;
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
