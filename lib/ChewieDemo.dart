import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class ChewieVideoDemo extends StatefulWidget {
  @override
  _ChewieVideoDemoState createState() => _ChewieVideoDemoState();
}

class _ChewieVideoDemoState extends State<ChewieVideoDemo> {
  TargetPlatform _platform;
  VideoPlayerController _controller1;
  VideoPlayerController _controller2;
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _controller1 = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _controller2 = VideoPlayerController.network('https://www.sample-videos.com/video123/mp4/480/asdasdas.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _controller1,
      aspectRatio: 4 / 3,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _chewieController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChewieDemo'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
          FlatButton(
            onPressed: (){
              _chewieController.enterFullScreen();
            },
            child: Text('全屏'),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: (){
                    setState(() {
                      _chewieController.dispose();
                      _controller2.pause();
                      _controller2.seekTo(Duration(seconds: 0));
                      _chewieController = ChewieController(
                        videoPlayerController: _controller1,
                        aspectRatio: 3 / 2,
                        autoPlay: true,
                        looping: true,
                      );
                    });
                  },
                  child: Padding(
                    child: Text('Video 1'),
                    padding: EdgeInsets.symmetric(vertical:16.0),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: (){
                    _chewieController.dispose();
                    _controller1.pause();
                    _controller1.seekTo(Duration(seconds: 0));
                    _chewieController =  ChewieController(
                      videoPlayerController: _controller2,
                      aspectRatio: 3 / 2,
                      autoPlay: true,
                      looping: true
                    );
                  },
                  child: Padding(
                    child: Text('Video 2'),
                    padding: EdgeInsets.symmetric(vertical:16.0),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _platform = TargetPlatform.android;
                    });
                  },
                  child: Padding(
                    child: Text("Android controls"),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _platform = TargetPlatform.iOS;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("iOS controls"),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}