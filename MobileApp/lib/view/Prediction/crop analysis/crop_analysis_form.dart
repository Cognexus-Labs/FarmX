import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../constants/colors.dart';
import '../../../widgets/button.dart';
import 'controller.dart';

class CropAnalysisForm extends StatelessWidget {
  const CropAnalysisForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CropAnalysisController c = Get.put(CropAnalysisController());
    return GetBuilder<CropAnalysisController>(builder: (c) {
      return Scaffold(
          appBar: AppBar(
              title: Text(" Select Image",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600))),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {
                      _showImageSelectionDialog(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r))),
                      height: 200,
                      width: 200,
                      child: c.selectedImage.value.isEmpty
                          ? const Text('No image selected.')
                          : Image.file(File(c.selectedImage.value)),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Threshold",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                  Slider(
                    value: c.value,
                    min: 0.0,
                    max: 1.0,
                    label: c.value.toString(),
                    divisions: 10,
                    onChanged: (double newValue) {
                      c.updateValue(newValue);
                    },
                  ),
                  SizedBox(height: 20.h),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: ToggleButtonWidget()),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Language",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                      onTap: () {
                        Get.bottomSheet(const SelectLanguage());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                        height: 50.h,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(c.selectedLang.value.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600)),
                            const Spacer(),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      )),
                  SizedBox(height: 70.h),
                  button("Proceed to Analyse", () {
                    c.fetchAnalysis();
                  }, white, mainGreen, mainGreen, 50.h, double.infinity)
                ],
              ),
            ),
          ));
    });
  }
}

Future<void> _showImageSelectionDialog(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return const ImageSelectionDialog();
    },
  );
}

class ImageSelectionDialog extends StatefulWidget {
  const ImageSelectionDialog({Key? key}) : super(key: key);

  @override
  _ImageSelectionDialogState createState() => _ImageSelectionDialogState();
}

class _ImageSelectionDialogState extends State<ImageSelectionDialog> {
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    CropAnalysisController c = Get.put(CropAnalysisController());
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      _imageFile = File(pickedFile!.path);
      c.selectImage(_imageFile!.path);
    });
    Navigator.pop(context);
  }

  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey[200],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                child: const Text(
                  'Take a Photo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: const Text(
                  'Choose from Gallery',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CropAnalysisController c = Get.put(CropAnalysisController());
    return GetBuilder<CropAnalysisController>(builder: (c) {
      return Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        height: 0.7.sh,
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.center,
                child: Text("Language",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                    itemCount: c.languages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          c.selectLanguage(c.languages[index]);
                          c.updateIndex(index);
                          Get.back();
                        },
                        title: Text(c.languages[index].name ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600)),
                        trailing: Radio(
                          value: index,
                          groupValue: c.selectedIndex.value,
                          onChanged: (value) {},
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ToggleButtonWidget extends StatefulWidget {
  const ToggleButtonWidget({Key? key}) : super(key: key);

  @override
  _ToggleButtonWidgetState createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    CropAnalysisController c = Get.put(CropAnalysisController());
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Use Gemini:',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: black, fontSize: 14.sp, fontWeight: FontWeight.w600)),
        Switch(
          value: _isToggled,
          onChanged: (value) {
            c.updateUseGemini(_isToggled ? 0 : 1);
            setState(() {
              _isToggled = value;
            });
          },
        ),
      ],
    );
  }
}
