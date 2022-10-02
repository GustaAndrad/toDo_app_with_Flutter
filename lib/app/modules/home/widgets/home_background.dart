import 'dart:ui';

import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  const HomeBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 0.8,
                image: NetworkImage(
                    'https://static.wikia.nocookie.net/afca1f5b-149d-44e7-bd53-9dfeef2ca674/scale-to-width/755'),
                fit: BoxFit.cover),
          ),
        ),
        ClipRRect(
          // Clip it cleanly.
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.black.withOpacity(0.1),
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    );
  }
}
