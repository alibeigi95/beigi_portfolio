import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../models/stat.dart';
import '../../../provider/theme.dart';
import '../../../utils/constants.dart';
import '../../../utils/screen_helper.dart';

final List<Stat> stats = [
  // Stat(count: "43", text: "Clients"),
  Stat(count: "3+", text: "Projects"),
  Stat(count: "5+", text: "Years IT\nExperience"),
  Stat(count: "1", text: "Years Flutter\nExperience"),
];

class PortfolioStats extends StatelessWidget {
  const PortfolioStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth, context),
        tablet: _buildUi(kTabletMaxWidth, context),
        mobile: _buildUi(getMobileMaxWidth(context), context),
      ),
    );
  }

  Widget _buildUi(double width, BuildContext context) {
    return ResponsiveWrapper(
      maxWidth: width,
      minWidth: width,
      defaultScale: false,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
          return Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: stats
                .map(
                  (stat) => Consumer(
                    builder: (context, ref, _) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        // Just use the helper here really
                        width: ScreenHelper.isMobile(context)
                            ? constraint.maxWidth / 2.0 - 20
                            : (constraint.maxWidth / 4.0 - 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              stat.count,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 32.0,
                                color: ref.watch(themeProvider).isDarkMode
                                    ? Colors.white
                                    : MyThemes.scaffoldBackgroundColor,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              stat.text,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: kCaptionColor,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}