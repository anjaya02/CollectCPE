import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(75.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 40.0,
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(22),
        ),
      ),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors
            .transparent,
        elevation: 0,
        title: Center(
          child: Image.asset(
            'assets/slt.png',
            fit: BoxFit.contain,
            height: 55.0,
          ),
        ),
      ),
    );
  }
}
