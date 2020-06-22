import 'package:flutter/material.dart';
import 'package:week1/enums/userRole.dart';

class UserModel {
  String fullName;
  String email;
  String mobile;
  String imgUrl;
  UserRole userRole;

  UserModel(
      {this.fullName,
      this.email,
      this.mobile,
      this.imgUrl,
      this.userRole});
}
