import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:code_hunt/clues.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

const int _blackPrimaryValue = 0xFF000000;
const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'TechVenture 2K23 - Code Hunt',
      theme: ThemeData(
        primarySwatch: primaryBlack,
      ),
      home: const MyHomePage(title: 'TechVenture 2K23 - Code Hunt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int clueNumber = 0;
  bool hasWon = false;
  bool firstRun = true;
  List<int> huntPath = [];

  late DateTime timeoutTime;
  late DateTime clueStartTime;

  bool revealTimeReached = false;
  bool timeOutReached = false;

  late SharedPreferences prefs;
  bool prefsLoaded = false;

  void updateCurrentTime(DateTime currentTime) {
    if (currentTime.compareTo(timeoutTime) >= 0  && !timeOutReached) {
      setState(() {
        timeOutReached = true;
      });
      Vibration.vibrate(duration: 2000);
    }
    if (currentTime.difference(clueStartTime).inMinutes >= 10 && !revealTimeReached) {
      setState(() {
        revealTimeReached = true;
      });
    }
  }

  void startCodeHunt() {
    // huntPath stores the indexes of locations in the generated path
    huntPath.add(clues.length - 1);
    String prevCluster = clues.last['cluster'];

    Random random = Random();
    int ranIndex;

    while (huntPath.length != 4) {
      ranIndex = random.nextInt(clues.length);
      if (!huntPath.contains(ranIndex)) {
        if (clues[ranIndex]['cluster'] != prevCluster) {
          huntPath.insert(0, ranIndex);
          prevCluster = clues[ranIndex]['cluster'];
        }
      }
    }

    timeoutTime = DateTime.now().add(const Duration(hours: 1, minutes: 5));
    clueStartTime = DateTime.now();

    //Save Preferences
    savePrefs();

    setState(() {
      firstRun = false;
    });

  }

  void nextClue() {
    setState(() {
      if (clueNumber != 3) {
        clueNumber++;
        revealTimeReached = false;
        clueStartTime = DateTime.now();

        prefs.setInt('clueNumber', clueNumber);
        prefs.setString('clueStartTime', clueStartTime.toString());

      }
      else {
        hasWon = true;
        prefs.setBool('hasWon', hasWon);
      }
    });
  }

  void scanQRCode() async {
    String scanRes = await FlutterBarcodeScanner.scanBarcode(
        '#000000',
        "Cancel Scan",
        true,
        ScanMode.QR);


    if (scanRes == clues[huntPath[clueNumber]]['id'].toString()) {
      Fluttertoast.showToast(
          msg: "Clue Number ${clueNumber + 1} Solved!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Vibration.vibrate(duration: 200);

      nextClue();
    }
    else {
      Fluttertoast.showToast(
          msg: "Wrong QR Code!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Vibration.vibrate(duration: 500);
    }


  }

  void revealClue(BuildContext ctx) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("CLOSE"),
      onPressed: () {
        Navigator.pop(ctx);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Reveal Answer"),
      content: Text(
          (!revealTimeReached)?
          "Answer can only be revealed 10 minutes after the clue is presented."
              :
              "Solution: ${clues[huntPath[clueNumber]]['solution']}\nCluster: ${clues[huntPath[clueNumber]]['cluster']}"
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> readPrefs() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList('huntPath') == null) {
      setState(() {
        prefsLoaded = true;
      });
    }
    else {
      setState(() {
        firstRun = false;
        clueNumber = prefs.getInt('clueNumber')!;
        hasWon = prefs.getBool('hasWon')!;

        timeoutTime = DateTime.parse(prefs.getString('timeoutTime')!);
        clueStartTime = DateTime.parse(prefs.getString('clueStartTime')!);

        List<String> huntPathStringList = prefs.getStringList('huntPath')!;
        for (int i=0; i<huntPathStringList.length; i++) {
          huntPath.add(int.parse(huntPathStringList[i]));
        }

        prefsLoaded = true;
      });
    }

  }

  Future<void> savePrefs() async {
    prefs.setInt('clueNumber', clueNumber);
    prefs.setBool('hasWon', hasWon);

    prefs.setString('timeoutTime', timeoutTime.toString());
    prefs.setString('clueStartTime', clueStartTime.toString());

    List<String> huntPathString = [];
    for (int i=0; i<huntPath.length; i++) {
      huntPathString.add(huntPath[i].toString());
    }
    prefs.setStringList('huntPath', huntPathString);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readPrefs();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: (!prefsLoaded) ? const Center(
        child: CircularProgressIndicator(),
      ) :
          (firstRun)?
          Instructions(startCodeHunt: startCodeHunt)
      :   (!hasWon && !timeOutReached)?
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  (!hasWon)? Clock(timeoutTime: timeoutTime, updateCurrentTime: updateCurrentTime): const SizedBox(),
                  const SizedBox(width: 20,)
                ],
              ),
              const SizedBox(height: 50,),
              Text(
                (clueNumber != 3)? "Clue Number ${clueNumber + 1}" : "Final Clue",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              HighlightView(
                clues[huntPath[clueNumber]]['code'],
                language: 'cpp',
                theme: githubTheme,
                padding: const EdgeInsets.all(10),
                textStyle: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 50,),
              TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryBlack)),
                  onPressed: () {revealClue(context);},
                  child: const Text("Reveal Answer", style: TextStyle(color: Colors.white),)
              )
            ],
          )
      : Message(hasWon: hasWon),


      floatingActionButton: FloatingActionButton(
        onPressed: (firstRun || hasWon || timeOutReached)? () {} : scanQRCode,
        tooltip: 'Scan QR Code',
        child: const Icon(Icons.qr_code),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class Clock extends StatefulWidget {
  const Clock({super.key, required this.timeoutTime, required this.updateCurrentTime});

  final DateTime timeoutTime;
  final Function updateCurrentTime;

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {

  late Duration remainingTime;

  String getRemainingTime() {
    var now = DateTime.now();

    remainingTime = widget.timeoutTime.difference(now);

    String mins = "";
    if (remainingTime.inMinutes%60 < 10) {
      mins = "0${remainingTime.inMinutes%60}";
    }
    else {
      mins = "${remainingTime.inMinutes%60}";
    }

    String secs = "";
    if (remainingTime.inSeconds%60 < 10) {
      secs = "0${remainingTime.inSeconds%60}";
    }
    else {
      secs = "${remainingTime.inSeconds%60}";
    }

    String timeString = "0${remainingTime.inHours}:$mins:$secs";

    Future.delayed(const Duration(milliseconds: 100), () {
      widget.updateCurrentTime(now);
    });

    // The widget calls this function
    // The widget is waiting for this function to return the string
    // Therefore the widget is in building state
    // but the updatecurrenttime function setstates for parent widget

    //parent being rebuilt while child was already rebuilding.

    return timeString;
  }

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(const Duration(seconds: 1), builder: (context) {
      return Text(
        getRemainingTime(),
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: (remainingTime.inMinutes <= 9)? Colors.red : Colors.black
        ),
      );
    });
  }
}


class Instructions extends StatelessWidget {
  const Instructions({super.key, required this.startCodeHunt});

  final Function startCodeHunt;

  void confirmStart(BuildContext ctx) {
    // set up the button
    Widget yesButton = TextButton(
      child: const Text("YES"),
      onPressed: () {
        startCodeHunt();
        Navigator.pop(ctx);
      },
    );

    Widget noButton = TextButton(
      child: const Text("NO"),
      onPressed: () {
        Navigator.pop(ctx);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Start Code Hunt"),
      content: const Text("Are you sure you have read the instructions and would like to begin the Code Hunt?"),
      actions: [
        yesButton,
        noButton
      ],
    );

    // show the dialog
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 30,),
        const Text(
          "Instructions",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            '''
1) Deduce the output of the clue (C code) to get the name of a location

2) Go to the aforementioned location.

3) Find the QR Code at that location.

4) Scan the QR Code to get the next Clue.

5) To Scan a QR Code press the Circular Floating Button visible in the bottom right corner.

6) Each team is expected to solve three clues and a final clue to win the code hunt.

7) Time remaining until Code Hunt concludes is displayed in the top right corner of the screen.
 
NOTE: In the case a team is finding it difficult to determine the output of a code, they can reveal the output 10 minutes after the code is presented on their screen.
''',
          ),
        ),

        TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryBlack)),
            onPressed: () {confirmStart(context);},
            child: const Text("Start Code Hunt", style: TextStyle(color: Colors.white),)
        )

      ],
    );
  }
}


class Message extends StatelessWidget {
  const Message({super.key, required this.hasWon});

  final bool hasWon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50,),
          Text(
          (hasWon)?"You Completed the Code Hunt!" : "You ran out of time!",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          Icon(
            (hasWon)? Icons.flag: Icons.timer_off_outlined,
            color: (hasWon)? Colors.green: Colors.red,
            size:50,)
        ],
      ),
    );
  }
}


