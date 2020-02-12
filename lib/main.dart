import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<String> imgListTwo = ['1', '2', '3', '4'];

void main() => runApp(MyApp());

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

final List child = map<Widget>(
  imgListTwo,
      (index, i) {
      return Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(children: <Widget>[
            Image.asset('images/house/' + (index+1).toString() + '.jpg', fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'No. $index image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ]),
        ),
      );

  },
).toList();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => RandomWords(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => HousePage(),
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),


    );
  }
}
class HousePage extends StatefulWidget {
  @override
  HousePageState createState() => HousePageState();
}

class HousePageState extends State<HousePage> {
  var ttext = '';

  void _updateRange(String str) {
   setState(() {
     ttext = str;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: ListTile(
            title: Text('Домик на 4 человека'),
          )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CarouselSlider(
              items: child,
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
            ),
            Text('Выбранная дата: $ttext'),
            new MaterialButton(
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  final List<DateTime> picked = await DateRagePicker.showDatePicker(
                      context: context,
                      initialFirstDate: new DateTime.now(),
                      initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
                      firstDate: new DateTime(2015),
                      lastDate: new DateTime(DateTime.now().year + 2)
                  );
                  if (picked != null) {
                    if (picked.length > 1) {
                      _updateRange(new DateFormat.yMMMd().format(picked[0]).toString() + ' - ' + new DateFormat.yMMMd().format(picked[1]).toString());
                    } else {
                      _updateRange(new DateFormat.yMMMd().format(picked[0]).toString());
                    }

                  }
                },
                child: new Text("Забронировать")
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text('Сутки считаются с 12.00 до 14.00 следующего дня, соответственно, заезд в сектор не позднее 12.00, выезд из сектора не позднее 14.00. Въезд на территорию базы отдыха с 06.00 до 20.00. Если рыболов приехал позже 12.00, то сутки будут считаться уже идущими и закончатся в 14.00 следующего дня.  Минимальное нахождение в секторе двое суток. Стоимость посещения: 500руб./ сутки с человека. Сопровождающие женщины, дети до 12 лет могут находиться на водоеме  бесплатно.', style: Theme.of(context).textTheme.caption)),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.lightBlueAccent,
              child: Text('На главную'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

//RaisedButton(
//textColor: Colors.white,
//color: Colors.lightBlueAccent,
//child: Text('Вернуться на главную'),
//onPressed: () {
//Navigator.pop(context);
//},
//)

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: Image.asset('images/logo.png'),
          title: Text('База отдыха - Сабурово'),
        )

      ),
      body: _build_cards(),
    );
  }

  Future navigateToSubPage(context) async {
//    Navigator.push(context, MaterialPageRoute(builder: (context) => HousePage()));
    Navigator.pushNamed(context, '/second');
  }

  Widget _build_cards() {
    return ListView(
      children:  <Widget>[
        Card(child: ListTile(title: Text('Домики на 4 места'), dense: true)),

        Card(
          child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('images/house_1.jpg'),
            radius: 30,),
          title: Text('Домик'),
          subtitle: Text('4 места'),
          trailing: Icon(Icons.more_vert),
          ),
        ),


        GestureDetector (
          child: Card(
            child:
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/house_1.jpg'),
                  radius: 30,),
                title: Text('Домик'),
                subtitle: Text('4 места'),
                trailing: Icon(Icons.more_vert),
              ),
          ),
          onTap: () { navigateToSubPage(context); },
        ),

        Card(child: ListTile(title: Text('Домики на 6 мест'), dense: true)),

        Card(
          child: ListTile(
            leading: CircleAvatar(
                backgroundImage: AssetImage('images/house_1.jpg'),
                radius: 30,),
            title: Text('Домик'),
            subtitle: Text('6 мест'),
            trailing: Icon(Icons.more_vert),
          ),
        ),

        Card(child: ListTile(title: Text('Остров'), dense: true)),

        Card(
          child: ListTile(
            leading: CircleAvatar(
                backgroundImage: AssetImage('images/island.jpg'),
                radius: 30,),
            title: Text('Остров'),
            subtitle: Text('10 мест'),
            trailing: Icon(Icons.more_vert),
          ),
        ),

      ],
    );
  }


  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
