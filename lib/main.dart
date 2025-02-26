import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umakvotingapp/bloc/election_candidates/election_candidates_bloc.dart';
import 'package:umakvotingapp/bloc/elections_bloc/elections_bloc.dart';
import 'package:umakvotingapp/bloc/supabase_connection/supabase_connection_bloc.dart';
import 'package:umakvotingapp/components/qr_scanner.dart';
import "constants/shared_pref_keys.dart";
import 'package:fluttertoast/fluttertoast.dart';
import "main/voting_screen.dart";
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

Future<void> main() async {
  await dotenv.load(fileName: "../.env");
  checkSupabaseConnection(null, null);

  runApp(const MainLandingPage());
}

Future<bool> checkSupabaseConnection(
    String? supabaseUrl, String? supabaseAnonCode) async {
  developer.log("triggered.");
  try {
    if (supabaseUrl == null || supabaseAnonCode == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      supabaseUrl = prefs.getString(supabaseUrlKey);
      supabaseAnonCode = prefs.getString(supabaseAnonKey);
      print(supabaseUrl);
      print(supabaseAnonCode);
      if (supabaseUrl == null || supabaseAnonCode == null) {
        return false;
      }
    }

    try {
      Supabase.instance;
      Fluttertoast.showToast(
          msg:
              "Supabase Connection Settings are already set. You can now scan your Student ID to vote.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      developer.log("supabase has not been initialized yet.");
      Fluttertoast.showToast(
          msg:
              "Connecting to Supabase...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonCode,
      );
      return true;
    }

    developer.log("success!");
    return true;
  } catch (e) {
    developer.log("failed! ${e.toString()}");
    return false;
  }
}

class MainLandingPage extends StatefulWidget {
  const MainLandingPage({super.key});

  @override
  State<MainLandingPage> createState() => _MainLandingPageState();
}

class _MainLandingPageState extends State<MainLandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      ensureScreenSize: true,
      builder: (bContext, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SupabaseConnectionBloc>(
              create: (context) => SupabaseConnectionBloc(),
            ),
            BlocProvider<ElectionCandidatesBloc>(
                create: (context) => ElectionCandidatesBloc()),
            BlocProvider<ElectionsBloc>(create: (context) => ElectionsBloc()),
          ],
          child: MaterialApp(
            title: "UMak Voting App",
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: "/",
            routes: {
              "/": (context) => const HomeScaffold(),
              "/voting": (context) => const VotingScreen(),
            },
          ),
        );
      },
    );
  }
}

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  late final Future checkConnection;
  late final Future<bool> supabaseConnection;
  @override
  void initState() {
    supabaseConnection = checkSupabaseConnection(null, null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
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
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Image.asset(
                            "images/UMakLogo.png",
                            width: 70,
                            height: 70,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Image.asset(
                            "images/CSOA.png",
                            width: 70,
                            height: 70,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
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
                                    shadows: const [
                                      Shadow(
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
                                    shadows: const [
                                      Shadow(
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
                                    shadows: const [
                                      Shadow(
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
                                    shadows: const [
                                      Shadow(
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
                    const Expanded(child: SizedBox(), flex: 1),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 50,
                      child: FutureBuilder(
                        future: supabaseConnection,
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          return TextButton(
                            onPressed: snapshot.data != null && snapshot.data!
                                ? () async {
                                    var data = await scanQrCode(context);
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString(studentId, data);
                                  }
                                : null,
                            style: ButtonStyle(backgroundColor:
                                WidgetStateProperty.resolveWith<Color>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.disabled)) {
                                  return const Color.fromARGB(255, 39, 56, 131);
                                }
                                return const Color.fromRGBO(65, 93, 214, 1);
                              },
                            ), textStyle:
                                WidgetStateProperty.resolveWith<TextStyle>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.disabled)) {
                                  return TextStyle(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontFamily: "Metropolis",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.spMin,
                                  );
                                }
                                return TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Metropolis",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.spMin,
                                );
                              },
                            )),
                            child: Text(
                              "Scan Student ID",
                              style: TextStyle(
                                color: snapshot.hasData && snapshot.data!
                                    ? Colors.white
                                    : Colors.white24,
                                fontFamily: "Metropolis",
                                fontWeight: FontWeight.bold,
                                fontSize: 16.spMin,
                              ),
                            ),
                          );
                        },
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
                                onPressed: () async {
                                  var data = await scanQrCode(context);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(
                                      supabaseUrlKey,
                                      data
                                          .toString()
                                          .replaceAll("https", "http"));
                                },
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
                                onPressed: () async {
                                  var data = await scanQrCode(context);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(supabaseAnonKey, data);
                                },
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
