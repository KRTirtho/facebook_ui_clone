import 'package:flutter/material.dart';

const double kPopupRadius = 10;

enum PostActionValues {
  save,
  turnOnNotifications,
  hide,
  embed,
  snooze,
  unfollow,
  support
}
enum ReactionPopup { open, close }
enum ReactionStatus { like, love, care, haha, wow, sad, angry }

abstract class FBReactIcon {
  FBReactIcon._();
  static const String like = "assets/images/fb_like.png";
  static const String love = "assets/images/fb_love.png";
  static const String care = "assets/images/fb_care.png";
  static const String wow = "assets/images/fb_wow.png";
  static const String haha = "assets/images/fb_haha.png";
  static const String sad = "assets/images/fb_sad.png";
  static const String angry = "assets/images/fb_angry.png";
}
