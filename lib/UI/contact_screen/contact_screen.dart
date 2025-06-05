import 'package:flutter/material.dart';
import 'package:simple/Reusable/color.dart'; // Assuming your color definitions are here
import 'package:simple/Reusable/text_styles.dart'; // Assuming your text styles are here
import 'package:simple/UI/Home_screen/home_screen.dart';
class ContactScreen extends StatelessWidget {
  final bool isDarkMode;

  const ContactScreen({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color secondaryTextColor = isDarkMode ? Colors.grey[400]! : Colors.grey;
    final Color cardBackgroundColor = isDarkMode ? Colors.grey[800]! : Colors.white;
    final Color iconColor = isDarkMode ? Colors.lightBlueAccent : Colors.purple;
    // Define a background color for the main card that wraps the contact cards
    final Color mainCardBackgroundColor = isDarkMode ? Colors.grey[850]! : const Color(0xFFF8F5FB);

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
        );
        return false;// Prevent default back action
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Get in Touch',
              style: TextStyle(
                fontFamily: 'Times New Roman',
                color: textColor,
                fontSize: 36,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'We would love to hear from you. Feel free to reach out through any of the following channels.',
              style: TextStyle(
                fontFamily: 'Times New Roman',
                color: secondaryTextColor,
                fontSize: 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // New parent card wrapping the three contact cards
            Container(
              padding: const EdgeInsets.all(24.0), // Padding inside the main card
              decoration: BoxDecoration(
                color: mainCardBackgroundColor, // Use the new background color
                borderRadius: BorderRadius.circular(16), // Slightly larger rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // More prominent shadow for the main card
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Determine if we are on a larger screen to show cards in a row
                  if (constraints.maxWidth > 700) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _buildContactCard(
                            icon: Icons.location_on,
                            title: 'Address',
                            content: 'Pavoorchathram',
                            cardBackgroundColor: cardBackgroundColor,
                            textColor: textColor,
                            secondaryTextColor: secondaryTextColor,
                            iconColor: iconColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildContactCard(
                            icon: Icons.phone,
                            title: 'Phone',
                            content: '6374073525',
                            cardBackgroundColor: cardBackgroundColor,
                            textColor: textColor,
                            secondaryTextColor: secondaryTextColor,
                            iconColor: iconColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildContactCard(
                            icon: Icons.mail,
                            title: 'Mail',
                            content: 'paulrajmmc@gmail.com',
                            cardBackgroundColor: cardBackgroundColor,
                            textColor: textColor,
                            secondaryTextColor: secondaryTextColor,
                            iconColor: iconColor,
                          ),
                        ),
                      ],
                    );
                  } else {
                    // For smaller screens, stack cards vertically
                    return Column(
                      children: [
                        _buildContactCard(
                          icon: Icons.location_on,
                          title: 'Address',
                          content: 'Pavoorchathram',
                          cardBackgroundColor: cardBackgroundColor,
                          textColor: textColor,
                          secondaryTextColor: secondaryTextColor,
                          iconColor: iconColor,
                        ),
                        const SizedBox(height: 20),
                        _buildContactCard(
                          icon: Icons.phone,
                          title: 'Phone',
                          content: '6374073525',
                          cardBackgroundColor: cardBackgroundColor,
                          textColor: textColor,
                          secondaryTextColor: secondaryTextColor,
                          iconColor: iconColor,
                        ),
                        const SizedBox(height: 20),
                        _buildContactCard(
                          icon: Icons.mail,
                          title: 'Mail',
                          content: 'paulrajmmc@gmail.com',
                          cardBackgroundColor: cardBackgroundColor,
                          textColor: textColor,
                          secondaryTextColor: secondaryTextColor,
                          iconColor: iconColor,
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String content,
    required Color cardBackgroundColor,
    required Color textColor,
    required Color secondaryTextColor,
    required Color iconColor,
  }) {
    return Container(
      height: 250, // Fixed height to ensure all cards are the same size
      width: 250,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // No mainAxisSize.min or Flexible/Expanded on content here,
        // the fixed height of the Container manages the layout.
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1), // Light background for icon
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Times New Roman',
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'Times New Roman',
              color: secondaryTextColor,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
            maxLines: 2, // Allow content to wrap
            overflow: TextOverflow.ellipsis, // Add ellipsis if it still overflows
          ),
        ],
      ),
    );
  }
}
