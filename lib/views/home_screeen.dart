// Updated HomeScreen
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notifications/constants/sizes.dart';
import 'package:notifications/constants/theme.dart';
import 'package:notifications/datass/services/notifications.dart';
import 'package:notifications/provider/cart_provider.dart';
import 'package:notifications/provider/notifications_controller.dart';
import 'package:notifications/provider/product_provider.dart';
import 'package:notifications/provider/user_controller.dart';
import 'package:notifications/views/cart_screen.dart';
import 'package:notifications/views/notifications_page.dart';
import 'package:notifications/views/profile_screen.dart';
import 'package:notifications/widgets/best_selling.dart';
import 'package:notifications/widgets/notifications.dart';
import 'package:notifications/widgets/products.dart';
import 'package:notifications/widgets/responsive/responsive_utils.dart';
import 'package:provider/provider.dart';
import 'all_product.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({super.key});

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  final NotificationsServices services = NotificationsServices();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    try {
      final controller = Provider.of<UserController>(context, listen: false);
      await controller.updateDeviceToken();
      services.requestNotificationPermission();
      services.initNotifications(context);
      final token = await services.getDeviceToken();
      print("Device Token: $token");
    } catch (e) {
      print("Error initializing notifications: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    // Responsive padding and spacing
    double horizontalPadding = screenWidth < 360
        ? 8.0
        : (screenWidth < 414 ? 10.0 : 15.0);
    double verticalSpacing = screenHeight * 0.015;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Utils.maincolor,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with notification and profile
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<NotificationsController>(
                        builder: (context, controller, child) {
                          return NotificationBell(
                            backgroundColor: Utils.maincolor,
                            notificationCount: controller.unreadCount,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationsPage(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        ),
                        child: CircleAvatar(
                          radius: screenWidth < 360
                              ? 20
                              : (screenWidth < 414 ? 23 : 25),
                          foregroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: screenWidth < 360
                                ? 17
                                : (screenWidth < 414 ? 20 : 22),
                            foregroundImage: const AssetImage(
                              'assets/profile.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: TSizes.spaceBtwSections),

                // Search bar and cart
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Row(
                    children: [
                      // Search bar - flexible width
                      Expanded(
                        flex: screenWidth < 360 ? 4 : 5,
                        child: Container(
                          height: ResponsiveUtils.getResponsiveHeight(
                            context,
                            0.065,
                          ),
                          decoration: BoxDecoration(
                            color: Utils.maincolor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: Offset(-5.0, -5.0),
                              ),
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: Utils.maincolor,
                              filled: true,
                              prefixIcon: Icon(
                                CupertinoIcons.search,
                                color: Colors.white,
                                size: screenWidth < 360 ? 18 : 20,
                              ),
                              hintText: 'Search',
                              hintStyle: GoogleFonts.poppins(
                                letterSpacing: 0.5,
                                fontSize: ResponsiveUtils.getResponsiveFontSize(
                                  context,
                                  14,
                                ),
                                color: Colors.white,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.015,
                                horizontal: 10,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Utils.maincolor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Utils.maincolor),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: screenWidth * 0.03),

                      // Cart icon
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: screenWidth < 360
                                  ? 24
                                  : (screenWidth < 414 ? 28 : 32),
                            ),
                          ),
                          if (context
                              .watch<CartProvider>()
                              .shoppingCart
                              .isNotEmpty)
                            Positioned(
                              top: -8,
                              right: -8,
                              child: CircleAvatar(
                                backgroundColor: Utils.pacificblue,
                                radius: screenWidth < 360 ? 8 : 10,
                                child: Text(
                                  context
                                      .watch<CartProvider>()
                                      .shoppingCart
                                      .length
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth < 360 ? 8 : 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: TSizes.spaceBtwSections),

                // Explore section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Explore',
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context,
                            22,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllProduct(),
                            ),
                          );
                        },
                        child: Text(
                          'See All',
                          style: GoogleFonts.poppins(
                            fontSize: ResponsiveUtils.getResponsiveFontSize(
                              context,
                              14,
                            ),
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: TSizes.spaceBtwSections / 2),

                // Products horizontal scroll
                SizedBox(
                  height: ResponsiveUtils.getResponsiveHeight(context, 0.42),
                  child: Consumer<ProductProvider>(
                    builder: (context, value, child) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding / 2,
                        ),
                        itemCount: value.shirts.length,
                        itemBuilder: (context, index) {
                          return Products(product: value.shirts[index]);
                        },
                      );
                    },
                  ),
                ),

                SizedBox(height: TSizes.spaceBtwSections / 2),

                // Best Selling section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Best Selling',
                        style: GoogleFonts.poppins(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(
                            context,
                            22,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllProduct(),
                            ),
                          );
                        },
                        child: Text(
                          'See All',
                          style: GoogleFonts.poppins(
                            fontSize: ResponsiveUtils.getResponsiveFontSize(
                              context,
                              14,
                            ),
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwSections),

                // Best Selling widget
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllProduct()),
                    );
                  },
                  child: const BestSelling(),
                ),

                SizedBox(height: verticalSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
