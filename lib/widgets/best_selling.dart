// Updated BestSelling Widget
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notifications/animation/fade_animation.dart';
import 'package:notifications/constants/theme.dart';
import 'package:notifications/widgets/responsive/responsive_utils.dart';

class BestSelling extends StatefulWidget {
  const BestSelling({super.key});

  @override
  State<BestSelling> createState() => _BestSellingState();
}

class _BestSellingState extends State<BestSelling> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double horizontalPadding = screenWidth < 360
        ? 8.0
        : (screenWidth < 414 ? 10.0 : 15.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: FadeAnimation(
        1.2,
        Container(
          height: ResponsiveUtils.getResponsiveHeight(context, 0.12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Utils.shadee,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(4.0, 4.0),
              ),
              BoxShadow(
                color: Colors.black38,
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(-4.0, -4.0),
              ),
            ],
          ),
          child: Row(
            children: [
              // Product image
              Padding(
                padding: EdgeInsets.all(screenWidth < 360 ? 12.0 : 15.0),
                child: Container(
                  height: screenWidth < 360 ? 60 : 80,
                  width: screenWidth < 360 ? 60 : 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(4.0, 4.0),
                      ),
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(-4.0, -4.0),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/nike.jpg', fit: BoxFit.cover),
                  ),
                ),
              ),

              // Product details
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth < 360 ? 12.0 : 15.0,
                    horizontal: screenWidth < 360 ? 8.0 : 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Shoes",
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context,
                            16,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xff03b680),
                            radius: screenWidth < 360 ? 3 : 5,
                          ),
                          SizedBox(width: screenWidth < 360 ? 3 : 5),
                          Text(
                            "Available",
                            style: GoogleFonts.poppins(
                              fontSize: ResponsiveUtils.getResponsiveFontSize(
                                context,
                                12,
                              ),
                              color: const Color(0xff03b680),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$100.00",
                        style: GoogleFonts.poppins(
                          color: Utils.pacificblue,
                          fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context,
                            14,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Arrow button
              Padding(
                padding: EdgeInsets.all(screenWidth < 360 ? 12.0 : 15.0),
                child: Container(
                  height: screenWidth < 360 ? 35 : 40,
                  width: screenWidth < 360 ? 35 : 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(4.0, 4.0),
                      ),
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(-4.0, -4.0),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: screenWidth < 360 ? 18 : 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
