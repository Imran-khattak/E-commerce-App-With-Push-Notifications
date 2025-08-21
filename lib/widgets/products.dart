// Updated Products Widget
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:notifications/animation/fade_animation.dart';
import 'package:notifications/constants/theme.dart';
import 'package:notifications/model/product_model.dart';
import 'package:notifications/provider/cart_provider.dart';
import 'package:notifications/provider/product_provider.dart';
import 'package:notifications/views/product_details_screen.dart';
import 'package:notifications/widgets/hero_widget.dart';
import 'package:notifications/widgets/responsive/responsive_utils.dart';
import 'package:notifications/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  final ProductModel product;

  const Products({super.key, required this.product});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    // Responsive card dimensions
    double cardWidth = screenWidth < 360
        ? screenWidth * 0.48
        : screenWidth < 414
        ? screenWidth * 0.52
        : screenWidth * 0.55;
    double cardHeight = ResponsiveUtils.getResponsiveHeight(context, 0.30);
    double imageHeight = cardHeight * 0.9;

    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth < 360 ? 6 : 10,
        vertical: 5,
      ),
      width: cardWidth,
      child: FadeAnimation(
        2,
        Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Utils.maincolor,
                  borderRadius: BorderRadius.circular(15),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  //   colors: [Utils.shadee, Utils.shadee],
                  // ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(4.0, 4.0),
                    ),
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(-4.0, -4.0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image and favorite button
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(
                              screenWidth < 360 ? 8.0 : 12.0,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsScreen(
                                            product: widget.product,
                                          ),
                                    ),
                                  );
                                },
                                child: HeroWidget(
                                  tag: 'product-image-${widget.product.id}',
                                  child: SizedBox(
                                    height: imageHeight,
                                    width: double.infinity,
                                    child: Image.asset(
                                      widget.product.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (widget.product.isAvailable)
                            Positioned(
                              top: screenWidth < 360 ? 12 : 18,
                              right: screenWidth < 360 ? 12 : 18,
                              child: LikeButton(
                                isLiked: widget.product.isFavorite,
                                onTap: (bool isLiked) async {
                                  productProvider.toggleFavorite(
                                    widget.product,
                                  );
                                  return !isLiked;
                                },
                                animationDuration: const Duration(
                                  milliseconds: 1000,
                                ),
                                circleColor: const CircleColor(
                                  start: Color(0xFFFF5722),
                                  end: Color(0xFFF44336),
                                ),
                                bubblesColor: const BubblesColor(
                                  dotPrimaryColor: Color(0xFFFFC107),
                                  dotSecondaryColor: Color(0xFFFF9800),
                                  dotThirdColor: Color(0xFFFF5722),
                                  dotLastColor: Color(0xFFF44336),
                                ),
                                likeBuilder: (bool isLiked) {
                                  return CircleAvatar(
                                    backgroundColor: Colors.red[400],
                                    radius: screenWidth < 360 ? 12 : 16,
                                    child: Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border_rounded,
                                      color: Colors.white,
                                      size: screenWidth < 360 ? 14 : 18,
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Product info section
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        // padding: EdgeInsets.symmetric(
                        //   horizontal: screenWidth < 360 ? 8.0 : 12.0,
                        //   vertical: 4.0,
                        // ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Product name
                            Flexible(
                              child: Text(
                                widget.product.name,
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      ResponsiveUtils.getResponsiveFontSize(
                                        context,
                                        14,
                                      ),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 5),

                            // Availability status
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: widget.product.isAvailable
                                      ? const Color(0xff03b680)
                                      : Colors.redAccent,
                                  radius: screenWidth < 360 ? 3 : 5,
                                ),
                                SizedBox(width: screenWidth < 360 ? 3 : 5),
                                Flexible(
                                  child: Text(
                                    widget.product.isAvailable
                                        ? "Available"
                                        : "Out of stock",
                                    style: GoogleFonts.poppins(
                                      fontSize:
                                          ResponsiveUtils.getResponsiveFontSize(
                                            context,
                                            11,
                                          ),
                                      color: widget.product.isAvailable
                                          ? const Color(0xff03b680)
                                          : Colors.redAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Price and add to cart
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "\$${widget.product.price}",
                                    style: GoogleFonts.poppins(
                                      color: Utils.pacificblue,
                                      fontSize:
                                          ResponsiveUtils.getResponsiveFontSize(
                                            context,
                                            15,
                                          ),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (widget.product.isAvailable)
                                  GestureDetector(
                                    onTap: () {
                                      context.read<CartProvider>().addToCart(
                                        widget.product,
                                      );
                                      showTopSnackBar(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: screenWidth < 360 ? 12 : 16,
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: screenWidth < 360 ? 16 : 20,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
