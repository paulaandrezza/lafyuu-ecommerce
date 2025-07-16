import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lafyuu/models/enums/Gender.dart';
import 'package:lafyuu/models/user/user_details.dart';
import 'package:lafyuu/presentation/build/account/build_on_tap_actions.dart';
import 'package:lafyuu/presentation/build/account/build_profile_info_items.dart';
import 'package:lafyuu/services/account/account_service.dart';
import 'package:lafyuu/theme/app_text_styles.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/profile/edit/edit_email_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/profile/edit/take_picture_page.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/profile/profile_info_item.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription>? _cameras;

class AccountProfilePage extends StatefulWidget {
  const AccountProfilePage({super.key});

  @override
  State<AccountProfilePage> createState() => _AccountProfilePageState();
}

class _AccountProfilePageState extends State<AccountProfilePage> {
  UserDetails? userDetails;
  bool isLoading = true;
  String? errorMessage;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
    _loadCameras();
    _loadCachedImage();
  }

  Future<void> _loadUserDetails() async {
    setState(() => isLoading = true);
    try {
      final user = await AccountService().get();
      setState(() {
        userDetails = user;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _loadCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
  }

  Future<void> _loadCachedImage() async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/profile_image.jpg');
    if (await file.exists()) {
      setState(() => _profileImage = file);
    }
  }

  Future<void> _openCamera() async {
    if (_cameras == null || _cameras!.isEmpty) return;

    final imagePath = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePicturePage(camera: _cameras!.first),
      ),
    );

    if (imagePath != null && imagePath is String) {
      final imageFile = File(imagePath);

      final dir = await getTemporaryDirectory();
      final newPath = '${dir.path}/profile_image.jpg';
      await imageFile.copy(newPath);

      setState(() => _profileImage = File(newPath));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Error: $errorMessage')),
      );
    }

    final profileInfoItems = buildProfileInfoItems(
      gender: userDetails?.gender.name ?? Gender.other.name,
      birthDate: DateFormat('yyyy-MM-dd').format(userDetails!.birthDate),
      email: userDetails!.email,
      phoneNumber: userDetails!.phoneNumber,
      onTapActions: buildOnTapActions(context, userDetails!),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: _openCamera,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          _profileImage != null
                              ? FileImage(_profileImage!)
                              : (userDetails?.profileImageUrl.isNotEmpty ??
                                  false)
                              ? NetworkImage(userDetails!.profileImageUrl)
                              : const AssetImage(
                                    'assets/images/blank_profile.png',
                                  )
                                  as ImageProvider,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                '/edit/fullName',
                                arguments: userDetails!.fullName,
                              ),
                          child: Text(
                            userDetails!.fullName,
                            style: AppTextStyles.h3,
                          ),
                        ),
                        Text(
                          '@${userDetails!.username}',
                          style: AppTextStyles.subtitle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: profileInfoItems.length,
                itemBuilder:
                    (context, index) =>
                        ProfileInfoItem(item: profileInfoItems[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
