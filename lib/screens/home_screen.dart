  // ignore_for_file: prefer_const_constructors

  import 'dart:io';
  import 'package:flutter/material.dart';
  import 'package:image_picker/image_picker.dart';
  import 'package:three_60/image_rotation.dart';
  import 'package:path_provider/path_provider.dart';
  import 'package:share/share.dart';



  class HomeScreen extends StatefulWidget {
    const HomeScreen({Key? key, required String title}) : super(key: key);

    @override
    // ignore: library_private_types_in_public_api
    _HomeScreenState createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    final List<File> _images = [];

    Future<void> _getImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _images.add(File(pickedFile.path));
        });
      }
    }

  int _rotationCount = 0;
  Future<void> _rotateImages() async {
    for (var i = 0; i < _images.length; i++) {
      final rotatedImage = ImageRotation.rotate(_images[i], _rotationCount);
      setState(() {
        _images[i] = rotatedImage;
      });
    }

    setState(() {
      _rotationCount++;
    });
  }


    Future<void> _saveImages() async {
      for (var i = 0; i < _images.length; i++) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName = 'image_$i.jpg';
        final filePath = '${directory.path}/$fileName';
        await _images[i].copy(filePath);
      }
    }

    Future<void> _shareImages() async {
      for (var i = 0; i < _images.length; i++) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName = 'image_$i.jpg';
        final filePath = '${directory.path}/$fileName';
        await _images[i].copy(filePath);
        Share.shareFiles([filePath]);
      }
    }

    @override
    Widget build(BuildContext context) {
      const double gridSpacing = 4;
      final double gridItemWidth = MediaQuery.of(context).size.width / 2 - gridSpacing;
      final double gridItemHeight = gridItemWidth;
      return Scaffold(
        
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0.0,
          toolbarHeight: 80.0,
          title: Container(
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 3),
                blurRadius: 50,
              ),
            ],
          ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '360 ',
                          style: TextStyle(
                            fontSize: 26, 
                            fontWeight: FontWeight.normal,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Color.fromARGB(255, 37, 18, 18),
                          ),
                        ),
                        TextSpan(
                          text: ' - Multi Rotate',
                          style: TextStyle(
                            fontSize: 26, 
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            // ignore: prefer_const_literals_to_create_immutables
                            shadows: [
                              Shadow(
                                blurRadius: 3.0,
                                color: Colors.black,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Select, Rotate, Save and Share your Images below',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),


        body: Container(
          decoration: BoxDecoration(
            
          ),
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 42, vertical: 42),
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount
            (
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: gridItemWidth / gridItemHeight,
            ),

            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
              );
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: _getImage,
              tooltip: 'Add Images',
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 20),
            FloatingActionButton(
              onPressed: _rotateImages,
              tooltip: 'Rotate Images',
              child: const Icon(Icons.rotate_right),
            ),
            const SizedBox(width: 20),
            FloatingActionButton(
              onPressed: _saveImages,
              tooltip: 'Save Images',
              child: const Icon(Icons.save),
            ),
            const SizedBox(width: 20),
            FloatingActionButton(
              onPressed: _shareImages,
              tooltip: 'Share Images',
              child: const Icon(Icons.share),
            ),
          ],
        ),
      );
    }
  }