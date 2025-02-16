import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "constants/shared_pref_keys.dart";

Future<void> main() async {
  await dotenv.load(fileName: "../.env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? supabaseUrl = prefs.getString(supabaseUrlKey);
  String? supabaseAnonCode = prefs.getString(supabaseAnonKey);

  if (supabaseUrl != null || supabaseAnonCode != null) {
    await Supabase.initialize(
      url: supabaseUrl!,
      anonKey: supabaseAnonCode!,
    );
  }

  runApp(const MainLandingPage());
}

class MainLandingPage extends StatefulWidget {
  const MainLandingPage({super.key});

  @override
  State<MainLandingPage> createState() => _MainLandingPageState();
}

class _MainLandingPageState extends State<MainLandingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authenticateDevice();
  }

  Future<void> _authenticateDevice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? supabaseUrl = prefs.getString(supabaseUrlKey);
    String? supabaseAnonCode = prefs.getString(supabaseAnonKey);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      ensureScreenSize: true,
      builder: (_, child) {
        return MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "images/UMakBlueBG.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                      child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: Image.asset(
                                "images/UMakLogo.png",
                                width: 70,
                                height: 70,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: Image.asset(
                                "images/CSOA.png",
                                width: 70,
                                height: 70,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: Image.asset(
                                "images/CCIS.png",
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "U",
                                      style: TextStyle(
                                        fontSize: 22.spMin,
                                        fontFamily: "Marcellus",
                                        color: Colors.white,
                                        shadows: [
                                          const Shadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 3.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextSpan(
                                      text: "NIVERSITY OF ",
                                      style: TextStyle(
                                        fontSize: 18.spMin,
                                        fontFamily: "Marcellus",
                                        color: Colors.white,
                                        shadows: [
                                          const Shadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 3.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextSpan(
                                      text: "M",
                                      style: TextStyle(
                                        fontSize: 22.spMin,
                                        fontFamily: "Marcellus",
                                        color: Colors.white,
                                        shadows: [
                                          const Shadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 3.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextSpan(
                                      text: "AKATI",
                                      style: TextStyle(
                                        fontSize: 18.spMin,
                                        fontFamily: "Marcellus",
                                        color: Colors.white,
                                        shadows: [
                                          const Shadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 3.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Text(
                              "Student Body Voting System",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Metropolis",
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 1.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(),
                          flex: 1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 50,
                          child: TextButton(
                            onPressed: () {},
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Color.fromRGBO(65, 93, 214, 1)),
                            ),
                            child: Text(
                              "Authenticate Device",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Metropolis",
                                fontWeight: FontWeight.bold,
                                fontSize: 16.spMin,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        Color.fromRGBO(65, 93, 214, 1),
                                      ),
                                    ),
                                    child: Text(
                                      "Scan Backend URL",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Metropolis",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.spMin,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {},
                                    style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        Color.fromRGBO(65, 93, 214, 1),
                                      ),
                                    ),
                                    child: Text(
                                      "Scan Anon Code",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Metropolis",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.spMin,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Developed by Jam Emmanuel Villarosa",
                            style: TextStyle(
                              color: Colors.white70,
                              fontFamily: "Metropolis",
                              fontSize: 12.spMin,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
