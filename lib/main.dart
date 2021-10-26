import 'package:flutter/material.dart';
import './web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String password = '';
  int res = 0;
  String message = '';
  bool showpass = true;
  void updatemessae(int res) {
    setState(() {
      if (res == 0) {
        message = 'Youre password is secure go on with your password';
      } else if (res == -100) {
        message = 'Please enter the non empty password ';
      } else if (res == -1) {
        message = 'Please Check your Internet connection';
      } else {
        message =
            'please change your password since it has been pwned $res times';
      }
    });
  }

  void getData(String password) async {
    if (password != '') {
      res = await getPawnedData(password);
    } else {
      res = -100;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    updatemessae(res);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.green.shade200,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.green),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.yellow, //  <-- dark color
          textTheme:
              ButtonTextTheme.primary, //  <-- this auto selects the right color
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("PassChecker.com"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  decoration: const InputDecoration(
                      labelText: 'Please enter your password here'),
                  onChanged: (value) {
                    password = value;
                  },
                  onSubmitted: getData,
                  obscureText: showpass,
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        showpass = !showpass;
                      });
                    },
                    icon: !showpass
                        ? const Icon(Icons.remove_red_eye)
                        : const Icon(Icons.lock)),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () => getData(password),
                  child: const Text('Check my password security'),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(message),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
