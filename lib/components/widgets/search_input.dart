import 'dart:ui';

import 'package:crust_and_co/components/widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.shade200.withOpacity(0.2),
          ),
          child: Center(
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                const Space(
                  widthFactor: 2,
                ),
                Expanded(
                  child: TextFormField(
                    onTapOutside: ((event) => FocusScope.of(context).unfocus()),
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                        hintText: 'Search for pizzas',
                        hintStyle: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300),
                        isDense: true,
                        border: InputBorder.none),
                  ),
                ),
                const Space(),
                const Icon(
                  CupertinoIcons.cart,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ));
  }
}
