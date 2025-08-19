import 'package:demo_ecommerce/core/models/products/categorie_model.dart';
import 'package:demo_ecommerce/features/home/controller/cubit/home_cubit.dart';
import 'package:demo_ecommerce/features/home/view/screens/home_screen.dart';
import 'package:demo_ecommerce/features/home/view/widgets/category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySection extends StatefulWidget {
   const CategorySection({super.key, required this.categories});

  final List<Category> categories;

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  int selectedCategoryId = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: HomeConstants.categoryHeight,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length + 1, // +1 for "All" category
        itemBuilder: (context, index) {
          if (index == 0) {
            return CategoryItem(
              onTap: () => _handleCategoryTap(context, Category(id: 0, name: 'All')),
              category: Category(id: 0, name: 'All'),
              isSelected: selectedCategoryId == 0,
            );
          }
          return CategoryItem(
            category: widget.categories[index - 1],
            isSelected: widget.categories[index - 1].id == selectedCategoryId,
            onTap: () => _handleCategoryTap(context, widget.categories[index - 1]),
          );
        },
      ),
    );
  }

    void _handleCategoryTap(BuildContext context, Category category) {
    HapticFeedback.selectionClick();
    selectedCategoryId = category.id ?? 0;
    setState(() {});
    context.read<HomeCubit>().loadFeaturedProducts(category.id ?? 1);
  }
}

