// import 'package:flutter/material.dart';

// void main() {
//   runApp(MusicApp());
// }

// class MusicApp extends StatelessWidget {
//   const MusicApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         useMaterial3: true,
//         primarySwatch: Colors.purple,
//       ),
//       darkTheme: ThemeData.dark(useMaterial3: true),
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text(
//             'Home',
//             style: TextStyle(color: Theme.of(context).primaryColorLight),
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: null,
//             icon: Icon(Icons.search),
//           ),
//         ],
//         leading: IconButton(
//           onPressed: () {
//             showModalBottomSheet(
//                 useSafeArea: true,
//                 context: context,
//                 builder: (ctx) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 20.0, top: 30),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 25,
//                               backgroundColor: Colors.white,
//                               child: Icon(Icons.person_3_rounded),
//                             ),
//                             SizedBox(
//                               width: 12,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Welcome,',
//                                   style: TextStyle(
//                                       color: Colors.grey, fontSize: 12),
//                                 ),
//                                 Text(
//                                   'User',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 )
//                               ],
//                             ),
//                             Spacer(),
//                             IconButton(onPressed: null, icon: Icon(Icons.edit))
//                           ],
//                         ),
//                         Text('Enjoy your music with,'),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Container(
//                               height: 100,
//                               width: 150,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.green.shade900,
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {},
//                                     icon: Icon(Icons.gamepad_outlined),
//                                   ),
//                                   Text('Games')
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               height: 100,
//                               width: 150,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.blue.shade900,
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {},
//                                     icon: Icon(Icons.quiz_outlined),
//                                   ),
//                                   Text('Quizes')
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         TextButton.icon(
//                             style: TextButton.styleFrom(
//                               foregroundColor: Colors.white,
//                             ),
//                             onPressed: () {},
//                             icon: Icon(Icons.settings),
//                             label: Text('Settings')),
//                         TextButton.icon(
//                             style: TextButton.styleFrom(
//                               foregroundColor: Colors.white,
//                             ),
//                             onPressed: () {},
//                             icon: Icon(Icons.equalizer_rounded),
//                             label: Text('Equilizer')),
//                         Center(child: Text('Made with Love')),
//                       ],
//                     ),
//                   );
//                 });
//           },
//           icon: Icon(Icons.home),
//         ),
//       ),0.0.

//       body: Column(children: []),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as https;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HOmeScreen(),
    );
  }
}

class HOmeScreen extends StatefulWidget {
  const HOmeScreen({super.key});

  @override
  State<HOmeScreen> createState() => _HOmeScreenState();
}

class _HOmeScreenState extends State<HOmeScreen> {
  bool isLoading = false;
  String temp = '';
  String weather = '';
  String weatherIcon = '';
  String city = '';

  void getWeather() async {
    if (city.isEmpty) {
      return;
    }
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=3195353da7066004a1e12c37f6a666a0&units=metric');
    try {
      setState(() {
        isLoading = true;
      });
      final response = await https.get(url);
      // print(jsonDecode(response.body));
      print(jsonDecode(response.body)['main']['temp']);
      print(jsonDecode(response.body)['weather'][0]['icon']);
      setState(() {
        isLoading = false;
        temp = jsonDecode(response.body)['main']['temp'].toString();
        weather = jsonDecode(response.body)['weather'][0]['description'];
        weatherIcon = jsonDecode(response.body)['weather'][0]['icon'];
      });
      print(jsonDecode(response.body)['weather'][0]['description']);
    } catch (e) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              content: Text('Please enter valid city name'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('Okay'),
                )
              ],
            );
          });
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/images/bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 15,
                                  // offset: Offset(-4, -4),
                                  spreadRadius: 5,
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 5,
                                  // offset: Offset(-4, -4),
                                  // spreadRadius: 5,
                                ),
                              ]),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                            cursorColor: Colors.black,
                            onSubmitted: (value) => getWeather(),
                            decoration: InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              hintText: 'Enter City',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            maxLength: 15,
                            onChanged: (value) {
                              city = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  if (weatherIcon.isNotEmpty)
                    Image.network(
                        'http://openweathermap.org/img/wn/$weatherIcon@2x.png'),
                  Text(
                    '$city'.substring(0, 1).toUpperCase() +
                        ' $city'.substring(2),
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    '$weather'.substring(0, 1).toUpperCase() +
                        ' $weather'.substring(2),
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '$temp \u2103',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  Spacer()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
