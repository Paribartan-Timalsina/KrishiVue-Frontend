import 'dart:isolate';
import 'dart:io';
import 'package:krishivue/pages/previewpage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../tflite/classifier.dart';
import '../tflite/recognition.dart';
import '../tflite/stats.dart';
import '../tflite/camera_view_singleton.dart';
import '../utils/isolate_utils.dart';
import 'package:flutter/cupertino.dart';
/// [CameraView] sends each frame for inference
class CameraView extends StatefulWidget {
    /// Constructor
  const CameraView(this.resultsCallback, this.statsCallback);
  /// Callback to pass results after inference to [HomeView]
  final Function(List<Recognition> recognitions) resultsCallback;

  /// Callback to inference stats to [HomeView]
  final Function(Stats stats) statsCallback;


  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  /// List of available cameras
  List<CameraDescription>? cameras;
  

  /// Controller
CameraController? cameraController = null;


  /// true when inference is ongoing
  bool? predicting;
bool _isRearCameraSelected = true;
  /// Instance of [Classifier]
  Classifier? classifier;

  /// Instance of [IsolateUtils]
  IsolateUtils? isolateUtils;

  @override
  void initState()  {
    super.initState();
     initStateAsync();
  }

  void initStateAsync() async {
    WidgetsBinding.instance.addObserver(this);

    // Spawn a new isolate
    isolateUtils = IsolateUtils();
    await isolateUtils!.start();
cameras = await availableCameras();
    // Camera initialization
    initializeCamera(cameras![0]);

    // Create an instance of classifier to load model and labels
    classifier = Classifier();

    // Initially predicting = false
    predicting = false;
  }




  /// Initializes the camera by setting [cameraController]
  Future initializeCamera(CameraDescription cameraDescription) async {
   // cameras = await availableCameras();
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    
    if(cameras!=null){
      print("Hello these are the cameras");
      print(cameras);
    }
if (cameras == null) {
  print("no cameras available");
    return; // No cameras available
  }
    // cameras[0] for rear-camera
      // cameraController =
      //   CameraController(cameras![0], ResolutionPreset.high);
print(cameraController);
    cameraController!.initialize().then((_) async {
      //Stream of image passed to [onLatestImageAvailable] callback
      await cameraController?.startImageStream(onLatestImageAvailable);

      /// previewSize is size of each image frame captured by controller
      ///
      /// 352x288 on iOS, 240p (320x240) on Android with ResolutionPreset.low
      Size? previewSize = cameraController?.value.previewSize;

      /// previewSize is size of raw input image to the model
      CameraViewSingleton.inputImageSize = previewSize;

      // the display width of image on screen is
      // same as screenWidth while maintaining the aspectRatio
      Size screenSize = MediaQuery.of(context).size;
      CameraViewSingleton.screenSize = screenSize;
      CameraViewSingleton.ratio = screenSize.width / previewSize!.height;
    }
    );
  }

 Future takePicture() async {
  
    try {
      
      XFile picture = await cameraController!.takePicture();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewPage(
                    picture: picture,
                  )));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }


Future initCamera(CameraDescription cameraDescription) async {
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    
    try {
      await cameraController!.initialize().then((_) {
        if (!mounted) return;
        setState(() {
          
        },);
        cameraController!.startImageStream((onLatestImageAvailable) {
           // cameraImage = img;
            //runObjectDetection(img);
    });
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }
 @override
Widget build(BuildContext context) {
  // Return an empty container or a loading indicator while the camera is not initialized
  if (cameraController == null || !cameraController!.value.isInitialized) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  return Container(
  child: Column(
    children: <Widget>[
      Expanded(
        child: AspectRatio(
          aspectRatio: cameraController!.value.aspectRatio,
          child: Container(
             height: MediaQuery.of(context).size.height * 0.10,
            width: MediaQuery.of(context).size.width * 1,
            child: CameraPreview(cameraController!)
            ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width * 1,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            color: Colors.black,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 40,
                  icon: Icon(
                    _isRearCameraSelected
                        ? CupertinoIcons.switch_camera
                        : CupertinoIcons.switch_camera_solid,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isRearCameraSelected = !_isRearCameraSelected;
                    });
                    initializeCamera(cameras![_isRearCameraSelected ? 0 : 1]);
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: takePicture,
                  iconSize: 50,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: Icon(Icons.circle, color: Colors.white),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    ],
  ),
);

}


  /// Callback to receive each frame [CameraImage] perform inference on it
  onLatestImageAvailable(CameraImage cameraImage) async {
    if (classifier!.interpreter != null && classifier!.labels != null) {
      // If previous inference has not completed then return
      if (predicting!) {
        return;
      }

      setState(() {
        predicting = true;
      });

      var uiThreadTimeStart = DateTime.now().millisecondsSinceEpoch;

      // Data to be passed to inference isolate
      var isolateData = IsolateData(
          cameraImage, classifier!.interpreter.address, classifier!.labels);

      // We could have simply used the compute method as well however
      // it would be as in-efficient as we need to continuously passing data
      // to another isolate.

      /// perform inference in separate isolate
      Map<String, dynamic> inferenceResults = await inference(isolateData);

      var uiThreadInferenceElapsedTime =
          DateTime.now().millisecondsSinceEpoch - uiThreadTimeStart;

      // pass results to HomeView
      widget.resultsCallback(inferenceResults["recognitions"]);

      // pass stats to HomeView
      widget.statsCallback((inferenceResults["stats"] as Stats)
        ..totalElapsedTime = uiThreadInferenceElapsedTime);

      // set predicting to false to allow new frames
      setState(() {
        predicting = false;
      });
    }
  }

  /// Runs inference in another isolate
  Future<Map<String, dynamic>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolateUtils!.sendPort!
        .send(isolateData..responsePort = responsePort.sendPort);
    var results = await responsePort.first;
    return results;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        cameraController!.stopImageStream();
        break;
      case AppLifecycleState.resumed:
        if (!cameraController!.value.isStreamingImages) {
          await cameraController!.startImageStream(onLatestImageAvailable);
        }
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController!.dispose();
    super.dispose();
  }
}

