import 'package:flutter/material.dart';
import 'package:simple/Reusable/color.dart';
import 'package:simple/Reusable/image.dart';
import 'package:simple/UI/buttomnavigationbar/buttomnavigation.dart';

class EventsPage extends StatefulWidget {
  final bool isDarkMode;
  const EventsPage({super.key, required this.isDarkMode});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final String firstCardImage =
      'assets/image/newsEvent1.png'; // doctor with patient
  final String secondCardImage =
      'assets/image/newsEvent2.png'; // dental equipment

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int totalImages = 5;

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
  Widget build(BuildContext context) {
    // Define colors based on dark mode state
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

    // Returning only the SingleChildScrollView as the body content
    return WillPopScope(
      onWillPop: () async {
        if (ModalRoute.of(context)?.isCurrent == true)
        {
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
                  //   widget.isDarkMode = !widget.isDarkMode; // Toggle dark mode
                });
              },
            ),
          ],
        ),
        body: Container(
          color: backgroundColor, // Set background color based on theme
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            secondCardImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Text('Image not found',
                                      style: TextStyle(color: Colors.black54)),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Testing ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: titleColor, // Apply dynamic title color
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Date: 20-03-2025',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor, // Apply dynamic text color
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
                        const SizedBox(height: 12),
                        Center(
                          child: Text(
                            'Event Images',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor, // Apply dynamic text color
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
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: totalImages,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentPage = index;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    // Use different images based on index, or dynamic content
                                    // For now, using the same image for demonstration
                                    final imageToDisplay = index % 2 == 0
                                        ? secondCardImage
                                        : firstCardImage;
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        imageToDisplay,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: Text('Image not found',
                                                  style: TextStyle(
                                                      color: Colors.black54)),
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
                                icon: Icon(Icons.arrow_forward_ios,
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
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            firstCardImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Text('Image not found',
                                      style: TextStyle(color: Colors.black54)),
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
                            color: titleColor, // Apply dynamic title color
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Date: 21-03-2025',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor, // Apply dynamic text color
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
          ),
        ),
      ),
    );
  }
}
