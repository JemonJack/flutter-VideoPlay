import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'ChewieDemo.dart';

const String Video_URL = 'https://www.runoob.com/try/demo_source/mov_bbb.mp4';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(),
      home: ChewieVideoDemo(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoPlayerController _controller;
  Future _initFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(Video_URL);
    _controller.setLooping(true);
    _initFuture = _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder(
          future: _initFuture,
          builder: (context, snapshot){
            print(snapshot.connectionState);
            if(snapshot.hasError) print(snapshot.error);
            if(snapshot.connectionState == ConnectionState.done){
              return AspectRatio(
                // aspectRatio: 16/9,
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        SizedBox(height: 30,),
        RaisedButton(
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          onPressed: (){
            setState(() {
              if(_controller.value.isPlaying){
                _controller.pause();
              }else{
                _controller.play();
              }
            });
          },
        ),
      ],
    );
  }
}
