// lib/core/dependencies.dart

// Flutter Core
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';

// State Management - Hide conflicting class
export 'package:get/get.dart' hide MultipartFile;
export 'package:get/get_core/get_core.dart';
export 'package:get/get_navigation/get_navigation.dart';

// Firebase
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:firebase_storage/firebase_storage.dart';

// Authentication
export 'package:google_sign_in/google_sign_in.dart';

// Networking - Import with prefix
export 'package:http/http.dart' show MultipartFile;

// Media
export 'package:image_picker/image_picker.dart';
export 'package:cached_network_image/cached_network_image.dart';

// Utilities
export 'package:intl/intl.dart' hide TextDirection;