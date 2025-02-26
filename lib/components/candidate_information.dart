import 'package:flutter/material.dart';

Widget buildBottomSheet(BuildContext context, ScrollController scrollController,
    double bottomSheetOffset) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(40),
    child: SingleChildScrollView(
      controller: scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: NetworkImage("https://placehold.co/100x100"),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      const SizedBox(width: 13),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("https://placehold.co/30x30"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'PASIA, Juan Dela Cruz',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'Metropolis',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              SizedBox(
                                width: double.infinity,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'UNITE',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Metropolis',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ' Partylist - College of Computing and Information Sciences',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Metropolis',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 34),
                Container(
                  width: double.infinity,
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Platform Overview',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 21),
          const SizedBox(
            width: double.infinity,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Experience / Achievements',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Metropolis',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 21),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'CCIS - Student Council',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              width: double.infinity,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Vice President for Internal Affairs',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(
                        width: double.infinity,
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Jan 2023 - Jan 2024',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Color(0xFF5E5E5E),
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 17),
                Container(
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFC9C9C9),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'UMak Computer Society',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              width: double.infinity,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'President',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(
                        width: double.infinity,
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Jan 2022 - Jan 2023',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Color(0xFF5E5E5E),
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 17),
                Container(
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFC9C9C9),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'CCIS Hackathon 2022',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              width: double.infinity,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Champion',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(
                        width: double.infinity,
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Nov 2022',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Color(0xFF5E5E5E),
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      padding: WidgetStatePropertyAll(const EdgeInsets.all(20)),
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.transparent)),
                  icon: Icon(
                    Icons.arrow_left,
                    color: Colors.black,
                  ),
                ),
                Expanded(flex: 1, child: Container()),
                Container(
                  child: TextButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                          backgroundColor:
                              WidgetStatePropertyAll(Color(0xFF132255))),
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                      iconAlignment: IconAlignment.end,
                      label: Text(
                        "Vote for XXXXX",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
