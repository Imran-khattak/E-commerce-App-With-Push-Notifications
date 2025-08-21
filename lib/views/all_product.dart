import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';
import 'package:local_hero_transform/local_hero_transform.dart';
import 'package:notifications/animation/fade_animation.dart';
import 'package:notifications/constants/theme.dart';
import 'package:notifications/model/product_model.dart';
import 'package:notifications/provider/cart_provider.dart';
import 'package:notifications/provider/product_provider.dart';
import 'package:notifications/views/cart_screen.dart';
import 'package:notifications/views/product_details_screen.dart';
import 'package:notifications/widgets/hero_widget.dart';
import 'package:notifications/widgets/snackbar.dart';
import 'package:provider/provider.dart';

enum ViewShape { grid, list }

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ValueNotifier<ViewShape> _viewNotifier;

  @override
  void initState() {
    super.initState();
    _viewNotifier = ValueNotifier(ViewShape.grid);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _viewNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final List<ProductModel> allProducts = [
      ...productProvider.shirts,
      ...productProvider.shoes,
      ...productProvider.pants,
    ];

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Utils.maincolor,
        appBar: AppBar(
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          backgroundColor: Utils.maincolor,
          title: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 18,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Best Selling',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: size.width * 0.050,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildViewSwitchButton(),
                    const SizedBox(width: 10),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartScreen(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: size.width * 0.090,
                          ),
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
                                  backgroundColor: Utils.pacificblue,
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
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: LocalHero(
          controller: _tabController,
          pages: [
            ProductGridView(products: allProducts, basePageContext: context),
            ProductListView(products: allProducts, basePageContext: context),
          ],
        ),
      ),
    );
  }

  Widget _buildViewSwitchButton() {
    return ValueListenableBuilder(
      valueListenable: _viewNotifier,
      builder: (context, value, child) {
        return ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 35, height: 35),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: RawMaterialButton(
              onPressed: () => _switchBetweenGridAndList(),
              elevation: 0,
              visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white24, width: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: Utils.pacificblue,
              child: Icon(
                _tabController.index == 0
                    ? Icons.view_agenda_outlined
                    : Icons.grid_view_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  void _switchBetweenGridAndList() {
    if (_viewNotifier.value == ViewShape.grid) {
      _tabController.animateTo(1);
      _viewNotifier.value = ViewShape.list;
    } else {
      _tabController.animateTo(0);
      _viewNotifier.value = ViewShape.grid;
    }
  }
}

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.products,
    required this.basePageContext,
  });

  final List<ProductModel> products;
  final BuildContext basePageContext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.65,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            index: index,
            isGridView: true,
            onTap: () => _navigateToDetails(basePageContext, products[index]),
          );
        },
      ),
    );
  }
}

class ProductListView extends StatelessWidget {
  const ProductListView({
    super.key,
    required this.products,
    required this.basePageContext,
  });

  final List<ProductModel> products;
  final BuildContext basePageContext;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            height: 120,
            child: ProductCard(
              product: products[index],
              index: index,
              isGridView: false,
              onTap: () => _navigateToDetails(basePageContext, products[index]),
            ),
          ),
        );
      },
    );
  }
}

void _navigateToDetails(BuildContext context, ProductModel product) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailsScreen(product: product),
    ),
  );
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.index,
    required this.isGridView,
    required this.onTap,
  });

  final ProductModel product;
  final int index;
  final bool isGridView;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);

    return Hero(
      tag: 'product-${product.id}',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Utils.maincolor,
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Utils.shadee, Utils.shadee],
            ),
            boxShadow: const [
              // Top-left shadow
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                spreadRadius: 1,
                offset: Offset(-4.0, -4.0),
              ),

              // Bottom-right shadow
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                spreadRadius: 1,
                offset: Offset(4.0, 4.0),
              ),
            ],
          ),
          child: isGridView
              ? _buildGridCard(context, size, productProvider)
              : _buildListCard(context, size, productProvider),
        ),
      ),
    );
  }

  Widget _buildGridCard(
    BuildContext context,
    Size size,
    ProductProvider productProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Flexible image section
        Expanded(
          flex: 4, // 80% of space
          child: _buildImageSection(context, size, productProvider, true),
        ),
        SizedBox(height: size.height * 0.010),
        // Product info (fixed height)
        _buildProductInfo(context, size, true),
        // Price/actions (fixed height)
        _buildPriceAndAction(context, size, true),
      ],
    );
  }

  Widget _buildListCard(
    BuildContext context,
    Size size,
    ProductProvider productProvider,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Image section
          Expanded(
            flex: 2,
            child: _buildImageSection(context, size, productProvider, false),
          ),
          const SizedBox(width: 15),
          // Info section
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProductInfo(context, size, false),
                _buildPriceAndAction(context, size, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(
    BuildContext context,
    Size size,
    ProductProvider productProvider,
    bool isGrid,
  ) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: isGrid ? 12 : 0,
            right: isGrid ? 12 : 0,
            top: isGrid ? 0 : 0, // Remove top padding
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              product.image,
              height: isGrid
                  ? null
                  : double.infinity, // Remove fixed height for grid
              width: double.infinity,
              fit: BoxFit.cover, // Ensure image fills space
            ),
          ),
        ),
        if (product.isAvailable)
          Positioned(
            top: isGrid ? 25 : 10,
            right: isGrid ? 18 : 5,
            child: LikeButton(
              isLiked: product.isFavorite,
              onTap: (bool isLiked) async {
                productProvider.toggleFavorite(product);
                return !isLiked;
              },
              animationDuration: const Duration(milliseconds: 1000),
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
                  radius: 13,
                  child: Icon(
                    size: 17,
                    isLiked ? Icons.favorite : Icons.favorite_border_rounded,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildProductInfo(BuildContext context, Size size, bool isGrid) {
    return Padding(
      padding: EdgeInsets.only(left: isGrid ? 15 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: GoogleFonts.poppins(
              fontSize: isGrid ? size.width * 0.030 : size.width * 0.035,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: isGrid ? 1 : 2,
          ),
          if (!isGrid) const SizedBox(height: 4),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: product.isAvailable
                    ? const Color(0xff03b680)
                    : Colors.redAccent,
                radius: 3,
              ),
              const SizedBox(width: 3),
              Text(
                product.isAvailable ? "Available" : "Out of stock",
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.025,
                  color: product.isAvailable
                      ? const Color(0xff03b680)
                      : Colors.redAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndAction(BuildContext context, Size size, bool isGrid) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isGrid ? 14 : 0,
        vertical: isGrid ? 10 : 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "\$ ${product.price}",
            style: GoogleFonts.poppins(
              color: Utils.pacificblue,
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (product.isAvailable)
            GestureDetector(
              onTap: () {
                context.read<CartProvider>().addToCart(product);
                showTopSnackBar(context);
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 13,
                child: Icon(Icons.add, color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }
}
