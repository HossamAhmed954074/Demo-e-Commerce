import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_ecommerce/core/models/products/product.dart';
import 'package:demo_ecommerce/core/router/app_router.dart';
import 'package:demo_ecommerce/features/home/view/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: HomeConstants.defaultBorderRadius,
        ),
        child: InkWell(
          borderRadius: HomeConstants.defaultBorderRadius,
          onTap: () => _handleProductTap(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildProductImage(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildProductTitle(context),
                    const SizedBox(height: 4),
                    _buildPriceAndAction(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        child: Hero(
          tag: 'product_${product.id}',
          child: CachedNetworkImage(
            imageUrl: _getImageUrl(),
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            fadeInDuration: Duration.zero,
            memCacheWidth: 300, // Optimize memory usage
            memCacheHeight: 300,
            placeholder: (context, url) => _buildImagePlaceholder(),
            errorWidget: (context, url, error) => _buildImageError(),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Colors.grey[100],
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildImageError() {
    return Container(
      color: Colors.grey[50],
      child: const Center(
        child: Icon(CupertinoIcons.photo, color: Colors.grey, size: 32),
      ),
    );
  }

  Widget _buildProductTitle(BuildContext context) {
    return Text(
      product.title ?? 'Unknown Product',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.titleStyle,
    );
  }

  Widget _buildPriceAndAction(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '\$${(product.price ?? 0).toStringAsFixed(2)}',
            style: context.priceStyle,
          ),
        ),
        Material(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => _handleAddToCart(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                CupertinoIcons.plus,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getImageUrl() {
    if (product.images?.isNotEmpty ?? false) {
      return product.images!.first;
    }
    return '';
  }

  void _handleProductTap(BuildContext context) {
    HapticFeedback.lightImpact();
    // Navigate to product details
    context.pushNamed(AppRouter.productDetailsName,extra: product);
  }

  void _handleAddToCart(BuildContext context) {
    HapticFeedback.mediumImpact();
    // Add to cart logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} added to cart'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'VIEW CART',
          onPressed: () {
            // Navigate to cart
          },
        ),
      ),
    );
  }
}

