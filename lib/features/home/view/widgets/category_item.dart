import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_ecommerce/core/models/products/categorie_model.dart';
import 'package:demo_ecommerce/features/home/view/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
    this.isSelected = false,
    required this.onTap,
  });

  final Category category;
  final bool isSelected;
 final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: AnimatedContainer(
          duration: HomeConstants.animationDuration,
          width: 80,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).cardColor,
            borderRadius: HomeConstants.defaultBorderRadius,
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey.withValues(alpha: 0.2),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCategoryImage(),
              const SizedBox(height: 4),
              _buildCategoryName(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryImage() {
    if (category.image != null && category.image!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CachedNetworkImage(
          imageUrl: category.image!,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          fadeInDuration: Duration.zero,
          memCacheWidth: 64,
          memCacheHeight: 64,
          placeholder: (context, url) => Container(
            width: 32,
            height: 32,
            color: Colors.grey[100],
            child: const Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 1.5),
              ),
            ),
          ),
          errorWidget: (context, url, error) => _buildDefaultIcon(),
        ),
      );
    }
    return _buildDefaultIcon();
  }

  Widget _buildDefaultIcon() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        CupertinoIcons.tag,
        color: isSelected ? Colors.white : Colors.grey[600],
        size: 18,
      ),
    );
  }

  Widget _buildCategoryName(BuildContext context) {
    return Text(
      category.name ?? 'Category',
      style: TextStyle(
        fontSize: 11,
        color: isSelected
            ? Colors.white
            : Theme.of(context).textTheme.bodyMedium?.color,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      ),
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }


}

