import 'dart:async';
import 'dart:isolate';
import 'package:krishivue/pages/previewpage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../models/recognition.dart';
import '../models/screen_params.dart';
import '../service/detector_service.dart';
import '../ui/box_widget.dart';
import '../ui/stats_widget.dart';
import 'package:flutter/cupertino.dart';
/// [DetectorWidget] sends each frame for inference
class DetectorWidget extends StatefulWidget {
  /// Constructor
  const DetectorWidget({super.key});

  @override
  State<DetectorWidget> createState() => _DetectorWidgetState();
}

class _DetectorWidgetState extends State<DetectorWidget>
    with WidgetsBindingObserver {
  /// List of available cameras
 List<CameraDescription>? cameras;
bool _isRearCameraSelected = true;
  /// Controller
  CameraController? _cameraController;

  // use only when initialized, so - not null
  get _controller => _cameraController;

  /// Object Detector is running on a background [Isolate]. This is nullable
  /// because acquiring a [Detector] is an asynchronous operation. This
  /// value is `null` until the detector is initialized.
  Detector? _detector;
  StreamSubscription? _subscription;

  /// Results to draw bounding boxes
  List<Recognition>? results;

  /// Realtime stats
  Map<String, String>? stats;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initStateAsync();
  }

  void _initStateAsync() async {
    cameras = await availableCameras();
    // initialize preview and CameraImage stream
    _initializeCamera(cameras![0]);
    // Spawn a new isolate
    Detector.start().then((instance) {
      setState(() {
        _detector = instance;
        _subscription = instance.resultsStream.stream.listen((values) {
          setState(() {
            results = values['recognitions'];
            stats = values['stats'];
          });
        });
      });
    });
  }

  /// Initializes the camera by setting [_cameraController]
  void _initializeCamera(CameraDescription cameraDescription) async {
   // cameras = await availableCameras();
    // cameras[0] for back-camera
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.low,
      enableAudio: false,
    )..initialize().then((_) async {
        await _controller.startImageStream(onLatestImageAvailable);
        setState(() {});

        /// previewSize is size of each image frame captured by controller
        ///
        /// 352x288 on iOS, 240p (320x240) on Android with ResolutionPreset.low
        ScreenParams.previewSize = _controller.value.previewSize!;
      });
  }

  Future takePicture() async {
  
    try {
      
      XFile picture = await _cameraController!.takePicture();
      
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

  @override
  Widget build(BuildContext context) {
    // Return empty container while the camera is not initialized
    if (_cameraController == null || !_controller.value.isInitialized) {
      return const SizedBox.shrink();
    }

    var aspect = 1 / _controller.value.aspectRatio;

    return Stack(
      children: [
        AspectRatio(
          aspectRatio: aspect,
          child: CameraPreview(_controller),
        ),
        // Stats
       // _statsWidget(),
        // Bounding boxes
        AspectRatio(
          aspectRatio: aspect,
          child: _boundingBoxes(),
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
                      _initializeCamera(cameras![_isRearCameraSelected ? 0 : 1]);
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
    );
  }

  Widget _statsWidget() => (stats != null)
      ? Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white.withAlpha(150),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: stats!.entries
                    .map((e) => StatsWidget(e.key, e.value))
                    .toList(),
              ),
            ),
          ),
        )
      : const SizedBox.shrink();

  /// Returns Stack of bounding boxes
  Widget _boundingBoxes() {
    if (results == null) {
      return const SizedBox.shrink();
    }
    return Stack(
        children: results!.map((box) => BoxWidget(result: box)).toList());
  }

  /// Callback to receive each frame [CameraImage] perform inference on it
  void onLatestImageAvailable(CameraImage cameraImage) async {
    _detector?.processFrame(cameraImage);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
        _cameraController?.stopImageStream();
        _detector?.stop();
        _subscription?.cancel();
        break;
      case AppLifecycleState.resumed:
        _initStateAsync();
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    _detector?.stop();
    _subscription?.cancel();
    super.dispose();
  }
}
