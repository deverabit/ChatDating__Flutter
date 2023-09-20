import 'dart:convert';

import 'package:dating_app/app/core/network_handler/dio_client.dart';
import 'package:dating_app/injection_container.dart';
import 'package:dating_app/presentation/auth/presentation/bloc/user_info_bloc/interest_bloc.dart';
import 'package:dio/dio.dart';

abstract class AuthInfoRemoteDataSource {
  Future<Response> createUserProfile(CreateUserProfile event);
}

class AuthInfoRemoteDataSourceImpl extends AuthInfoRemoteDataSource {
  final DioClient dioClient = serviceLocator<DioClient>();

  @override
  Future<Response> createUserProfile(CreateUserProfile event) async {
    final userProfile = {
      'email': event.email,
      'gender': event.gender,
      'interests': event.interests,
      'about': event.about,
    };
    final data = jsonEncode(userProfile);
    return await dioClient.dio.post(
      '/user/userProfile',
      data: data,
    );
  }
}
