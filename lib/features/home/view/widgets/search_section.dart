import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key, required this.onClear});

  final VoidCallback onClear;

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _focusNode.hasFocus
              ? Theme.of(context).primaryColor
              : Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onSubmitted: _handleSubmit,
        onChanged: _handleTextChange,
        decoration: InputDecoration(
          hintText: 'Search products...',
          hintStyle: TextStyle(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, child) {
              if (value.text.isEmpty) return const SizedBox.shrink();

              return IconButton(
                onPressed: _clearSearch,
                icon: Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              );
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 20.0,
          ),
        ),
      ),
    );
  }

  void _handleSubmit(String value) {
    if (value.trim().isEmpty) {
      widget.onClear();
    } else {
      _focusNode.unfocus();
      // Implement search functionality here
    }
  }

  void _handleTextChange(String value) {
    // Implement real-time search or debouncing here
    if (value.trim().isEmpty) {
      widget.onClear();
    }
  }

  void _clearSearch() {
    _controller.clear();
    widget.onClear();
    _focusNode.unfocus();
    HapticFeedback.lightImpact();
  }
}

