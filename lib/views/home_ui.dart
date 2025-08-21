// // Updated HomeScreen with modern UI design
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:notifications/constants/theme.dart';
// import 'package:notifications/datass/services/notifications.dart';
// import 'package:notifications/model/product_model.dart';
// import 'package:notifications/provider/cart_provider.dart';
// import 'package:notifications/provider/notifications_controller.dart';
// import 'package:notifications/provider/product_provider.dart';
// import 'package:notifications/views/cart_screen.dart';
// import 'package:notifications/views/notifications_page.dart';
// import 'package:notifications/views/product_details_screen.dart';
// import 'package:notifications/views/profile_screen.dart';
// import 'package:notifications/widgets/best_selling.dart';
// import 'package:notifications/widgets/notifications.dart';
// import 'package:notifications/widgets/products.dart';
// import 'package:provider/provider.dart';
// import 'all_product.dart';

// class HomeScreeen extends StatefulWidget {
//   const HomeScreeen({super.key});

//   @override
//   State<HomeScreeen> createState() => _HomeScreeenState();
// }

// class _HomeScreeenState extends State<HomeScreeen> {
//   final NotificationsServices services = NotificationsServices();

//   @override
//   void initState() {
//     super.initState();
//     _initializeNotifications();
//   }

//   void _initializeNotifications() async {
//     try {
//       services.requestNotificationPermission();
//       services.initNotifications(context);
//       final token = await services.getDeviceToken();
//       print("Device Token: $token");
//     } catch (e) {
//       print("Error initializing notifications: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double screenWidth = size.width;
//     double screenHeight = size.height;

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Utils.maincolor, // Dark background like the image
//         body: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Top bar with menu and profile
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 15,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Menu icon
//                     Container(
//                       width: 45,
//                       height: 45,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF3C4043),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(
//                         Icons.menu,
//                         color: Colors.white,
//                         size: 22,
//                       ),
//                     ),

//                     // Profile with notification badge
//                     GestureDetector(
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => ProfilePage()),
//                       ),
//                       child: Container(
//                         width: 45,
//                         height: 45,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: const Icon(
//                           Icons.person,
//                           color: Color(0xFF2A2D3E),
//                           size: 22,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: screenHeight * 0.02),

//               // Search bar and cart - Modern glass effect
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     // Search bar with glassmorphism
//                     Expanded(
//                       child: Container(
//                         height: 55,
//                         decoration: BoxDecoration(
//                           color: Utils.maincolor,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.1),
//                             width: 1,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 20,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: TextField(
//                           style: const TextStyle(color: Colors.white),
//                           decoration: InputDecoration(
//                             prefixIcon: const Icon(
//                               CupertinoIcons.search,
//                               color: Colors.white70,
//                               size: 20,
//                             ),
//                             hintText: 'Search',
//                             hintStyle: GoogleFonts.poppins(
//                               color: Colors.white60,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                             ),
//                             border: InputBorder.none,
//                             contentPadding: const EdgeInsets.symmetric(
//                               vertical: 17,
//                               horizontal: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(width: 15),

//                     // Cart with modern badge
//                     Stack(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CartScreen(),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             width: 55,
//                             height: 55,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF4A9EFF),
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: const Color(
//                                     0xFF4A9EFF,
//                                   ).withOpacity(0.3),
//                                   blurRadius: 15,
//                                   offset: const Offset(0, 8),
//                                 ),
//                               ],
//                             ),
//                             child: const Icon(
//                               Icons.shopping_cart_outlined,
//                               color: Colors.white,
//                               size: 22,
//                             ),
//                           ),
//                         ),
//                         if (context
//                             .watch<CartProvider>()
//                             .shoppingCart
//                             .isNotEmpty)
//                           Positioned(
//                             top: -2,
//                             right: -2,
//                             child: Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: const BoxDecoration(
//                                 color: Colors.red,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Text(
//                                 context
//                                     .watch<CartProvider>()
//                                     .shoppingCart
//                                     .length
//                                     .toString(),
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: screenHeight * 0.04),

//               // Explore section
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Explore',
//                       style: GoogleFonts.poppins(
//                         fontSize: 28,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => AllProduct()),
//                         );
//                       },
//                       child: Text(
//                         'See All',
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           color: Colors.white60,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: screenHeight * 0.025),

//               // Products with elevated cards
//               SizedBox(
//                 height: 320,
//                 child: Consumer<ProductProvider>(
//                   builder: (context, value, child) {
//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       itemCount: value.shirts.length,
//                       itemBuilder: (context, index) {
//                         return ModernProductCard(product: value.shirts[index]);
//                       },
//                     );
//                   },
//                 ),
//               ),

//               SizedBox(height: screenHeight * 0.04),

//               // Best Selling section
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Best Selling',
//                       style: GoogleFonts.poppins(
//                         fontSize: 28,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => AllProduct()),
//                         );
//                       },
//                       child: Text(
//                         'See All',
//                         style: GoogleFonts.poppins(
//                           fontSize: 16,
//                           color: Colors.white60,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: screenHeight * 0.025),

//               // Modern Best Selling Card
//               const ModernBestSellingCard(),

//               SizedBox(height: screenHeight * 0.03),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Modern Product Card Widget
// class ModernProductCard extends StatefulWidget {
//   final ProductModel product;

//   const ModernProductCard({super.key, required this.product});

//   @override
//   State<ModernProductCard> createState() => _ModernProductCardState();
// }

// class _ModernProductCardState extends State<ModernProductCard> {
//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       width: 180,
//       child: Column(
//         children: [
//           // Main card with elevation
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFF3C4043),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     blurRadius: 20,
//                     offset: const Offset(0, 8),
//                   ),
//                   BoxShadow(
//                     color: Colors.white.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(-5, -5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Image with favorite button
//                   Expanded(
//                     flex: 3,
//                     child: Stack(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 10,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => ProductDetailsScreen(
//                                       product: widget.product,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Image.asset(
//                                 widget.product.image,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Favorite button with modern design
//                         if (widget.product.isAvailable)
//                           Positioned(
//                             top: 18,
//                             right: 18,
//                             child: GestureDetector(
//                               onTap: () {
//                                 productProvider.toggleFavorite(widget.product);
//                               },
//                               child: Container(
//                                 width: 32,
//                                 height: 32,
//                                 decoration: BoxDecoration(
//                                   color: widget.product.isFavorite
//                                       ? Colors.red
//                                       : Colors.white.withOpacity(0.9),
//                                   shape: BoxShape.circle,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.1),
//                                       blurRadius: 8,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Icon(
//                                   widget.product.isFavorite
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   color: widget.product.isFavorite
//                                       ? Colors.white
//                                       : Colors.grey[600],
//                                   size: 18,
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),

//                   // Product info
//                   Expanded(
//                     flex: 2,
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 widget.product.name,
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 16,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Description',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 12,
//                                   color: Colors.white60,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),

//                           // Price and add button
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 '\$${widget.product.price}',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 18,
//                                   color: const Color(0xFF4A9EFF),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               if (widget.product.isAvailable)
//                                 GestureDetector(
//                                   onTap: () {
//                                     context.read<CartProvider>().addToCart(
//                                       widget.product,
//                                     );
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: const Text('Added to cart!'),
//                                         backgroundColor: const Color(
//                                           0xFF4A9EFF,
//                                         ),
//                                         behavior: SnackBarBehavior.floating,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             10,
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: Container(
//                                     width: 32,
//                                     height: 32,
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFF4A9EFF),
//                                       shape: BoxShape.circle,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: const Color(
//                                             0xFF4A9EFF,
//                                           ).withOpacity(0.3),
//                                           blurRadius: 8,
//                                           offset: const Offset(0, 4),
//                                         ),
//                                       ],
//                                     ),
//                                     child: const Icon(
//                                       Icons.add,
//                                       color: Colors.white,
//                                       size: 18,
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Modern Best Selling Card
// class ModernBestSellingCard extends StatelessWidget {
//   const ModernBestSellingCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF3C4043),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//           BoxShadow(
//             color: Colors.white.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(-5, -5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Product image
//           Container(
//             width: 70,
//             height: 70,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.asset('assets/nike.jpg', fit: BoxFit.cover),
//             ),
//           ),

//           const SizedBox(width: 16),

//           // Product details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Shoes',
//                   style: GoogleFonts.poppins(
//                     fontSize: 18,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Lorem Ipsum',
//                   style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     color: Colors.white60,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   '\$125.00',
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: const Color(0xFF4A9EFF),
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Arrow button
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: const Icon(
//               Icons.arrow_forward,
//               color: Color(0xFF2A2D3E),
//               size: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
