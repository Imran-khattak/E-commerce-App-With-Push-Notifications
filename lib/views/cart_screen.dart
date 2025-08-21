import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:notifications/animation/fade_animation.dart';
import 'package:notifications/constants/image_strings.dart';
import 'package:notifications/constants/theme.dart';
import 'package:notifications/datass/services/send_notifications_service.dart';
import 'package:notifications/provider/cart_provider.dart';
import 'package:notifications/provider/notifications_controller.dart';
import 'package:notifications/provider/user_controller.dart';
import 'package:notifications/views/home_screeen.dart';
import 'package:notifications/views/home_ui.dart';
import 'package:notifications/widgets/cart_item.dart';
import 'package:notifications/widgets/payment_button.dart';
import 'package:notifications/widgets/popus/loaders.dart';
import 'package:notifications/widgets/popus/popups.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Utils.maincolor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: context.watch<CartProvider>().shoppingCart.isNotEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                top: size.height * 0.050,
                                right: 20,
                                bottom: size.height * 0.030,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  Text(
                                    'Cart',
                                    style: GoogleFonts.poppins(
                                      fontSize: size.width * 0.055,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.white,
                                        size: size.width * 0.080,
                                      ),
                                      Positioned(
                                        top: -25,
                                        bottom: 5,
                                        right: -3,
                                        child:
                                            context
                                                .watch<CartProvider>()
                                                .shoppingCart
                                                .isNotEmpty
                                            ? CircleAvatar(
                                                backgroundColor:
                                                    Utils.pacificblue,
                                                radius: 10,
                                                child: Text(
                                                  context
                                                      .watch<CartProvider>()
                                                      .shoppingCart
                                                      .length
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Consumer<CartProvider>(
                              builder: (context, value, child) {
                                return FadeAnimation(
                                  2,
                                  Column(
                                    children: value.shoppingCart
                                        .map(
                                          (cartItem) =>
                                              CartItem(cartModel: cartItem),
                                        )
                                        .toList(),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: size.height * 0.15),
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.grey,
                                  size: size.width * 0.20,
                                ),
                                SizedBox(height: size.height * 0.20),
                                Text(
                                  "Your cart is empty!",
                                  style: GoogleFonts.poppins(
                                    //fontSize: size.width*0.
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
            // SizedBox(
            //   height: size.height * 0.010,
            // ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (Widget child, Animation<double> animation) {
                // Slide transition for vertical movement
                final slideTransition = SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.0, 1.0),
                    end: Offset(0.0, 0.0),
                  ).animate(animation),
                  child: child,
                );

                // Fade transition for opacity
                final fadeTransition = FadeTransition(
                  opacity: animation,
                  child: slideTransition,
                );

                return fadeTransition;
              },
              child: context.watch<CartProvider>().hasSelectedItems()
                  ? Container(
                      key: const ValueKey<bool>(true),
                      height: size.height * 0.30,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Utils.spread,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 15,
                            spreadRadius: 1,
                            offset: Offset(4.0, 4.0),
                          ),
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 15,
                            spreadRadius: 1,
                            offset: Offset(-4.0, -4.0),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [Utils.maincolor, Utils.pacificblue],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: size.height * 0.040,
                          right: size.height * 0.040,
                          top: size.height * 0.025,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Selected Items',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                                ),
                                Text(
                                  "\$${context.watch<CartProvider>().selectedItemsTotal}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Utils.pacificblue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.010),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping Fee',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                                ),
                                Text(
                                  "\$${context.watch<CartProvider>().shippingCharge}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Utils.pacificblue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.015),
                            Container(
                              height: size.height * 0.0018,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: size.height * 0.020),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.015,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Price',
                                    style: GoogleFonts.poppins(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "\$${context.watch<CartProvider>().totalCart}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Utils.pacificblue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.020),
                            _buildCheckoutButton(context),
                            // Container(
                            //   height: size.height * 0.060,
                            //   width: size.width * 0.55,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(25),
                            //     color: Utils.pacificblue,
                            //   ),
                            //   child: Center(
                            //     child: Text(
                            //       "checkout",
                            //       style: GoogleFonts.poppins(
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 20,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            // PaymentButton(),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(key: ValueKey<bool>(true)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Consumer2<NotificationsController, UserController>(
        builder: (context, notController, userController, child) {
          return ElevatedButton(
            onPressed: () async {
              try {
                final cartProvider = Provider.of<CartProvider>(
                  context,
                  listen: false,
                );

                // Get first product for the notification (or you can modify this logic)
                final firstCartItem = cartProvider.shoppingCart.first;
                final totalItems = cartProvider.shoppingCart.length;
                final totalAmount = cartProvider.totalCart;

                // Create a summary of all products for richer notifications
                String productSummary = '';
                if (totalItems == 1) {
                  productSummary = firstCartItem.product.name;
                } else if (totalItems <= 3) {
                  productSummary = cartProvider.shoppingCart
                      .map((item) => item.product.name)
                      .join(', ');
                } else {
                  productSummary =
                      '${firstCartItem.product.name} and ${totalItems - 1} other items';
                }
                // Step 3: Start loading animation BEFORE processing
                TFullScreenLoader.openLoadingDialog(
                  context,
                  "We are processing your orders...",
                  TImages.docerAnimation,
                );
                // Create and save order notification
                await notController.createOrderNotification(
                  productName: productSummary, // More descriptive product info
                  productPrice: firstCartItem
                      .product
                      .price, // Access price through product
                  itemCount: totalItems,
                  totalAmount: totalAmount,
                  additionalData: {
                    'orderId': DateTime.now().millisecondsSinceEpoch.toString(),
                    'paymentMethod': 'card',

                    'customerEmail': userController.user.email ?? '',
                  },
                );

                // Send push notification
                await SendNotificationsService.sendNotifications(
                  token: userController.user.deviceToken,
                  title: "🎉 Order Confirmed!",
                  body:
                      "Your order for $totalItems items worth \$${totalAmount.toStringAsFixed(2)} has been placed successfully!",
                  data: {
                    'orderTotal': totalAmount.toString(),
                    'itemCount': totalItems.toString(),
                    'orderId': DateTime.now().millisecondsSinceEpoch.toString(),
                  },
                );

                // Show success message
                TLoaders.successSnackBar(
                  context: context,
                  title: 'Order Update',
                  message: 'Order placed successfully! 🎉',
                );

                // Clear cart after successful order
                //  cartProvider.clearSelectedItems(); // Only clear selected items
                cartProvider.clearCart();
                // Optional: Navigate to order confirmation page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreeen()),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to place order: ${e.toString()}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Utils.pacificblue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Text(
              'Checkout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }
}
