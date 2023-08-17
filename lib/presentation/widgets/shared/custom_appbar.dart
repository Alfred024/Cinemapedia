import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie,
                color: colors.primary,
              ),
              const Text('Cinemapedia'),
              const Spacer(),
              IconButton(
                  color: colors.primary,
                  onPressed: () {},
                  icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
    );
  }
}
