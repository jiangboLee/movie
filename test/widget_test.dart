import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

enum Actions { Increment }

int counterReducer(int state, action) {
  if (action == Actions.Increment) {
    return state + 1;
  }
  return state;
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final store = new Store(counterReducer, initialState: 0);

  @override
  Widget build(BuildContext context) {

    return new StoreProvider(
      store: store,
      child: new Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              new StoreConnector<int, String>(
                builder: (context, count) => new Text(
                  count,
                  style: Theme.of(context).textTheme.display1,
                ),
                converter: (store) => store.state.toString(),
              ),
            ],
          ),
        ),
        floatingActionButton: new StoreConnector<int, VoidCallback>(
          builder: (context, callback) => new FloatingActionButton(
            onPressed: callback,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          converter: (store) {
            return () => store.dispatch(Actions.Increment);
          },
        ),
      ),
    );
  }
}
