import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:groomingo/routes/routes.dart';
import 'package:groomingo/models/user/user_repository.dart';
import 'package:groomingo/styles/colors.dart'
    as AppColors; // Colors 클래스를 AppColors로 가져오기

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 로고 이미지
                Container(
                  width: deviceWidth * 0.8, // 기기의 너비의 80%로 설정
                  height: 150,
                  child: Center(
                    child: Image.asset(
                      'assets/images/common/img_groomingo_logo_1.png', // 로고 이미지 경로
                      fit: BoxFit.contain, // 이미지 비율 유지
                    ),
                  ),
                ),
                SizedBox(height: 32),
                // 이메일 입력 인풋
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: '이메일',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력해주세요';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // 비밀번호 입력 인풋
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력해주세요';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                // 로그인 버튼
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final accessToken = await _userRepository.signIn(
                          _emailController.text,
                          _passwordController.text,
                        );
                        // 로그인 성공 처리
                        print('로그인 성공: $accessToken');

                        // accessToken 및 이메일 저장
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('accessToken', accessToken);
                        await prefs.setString('email', _emailController.text);

                        // 홈 화면으로 이동
                        context.go('/home');
                      } catch (e) {
                        // 로그인 실패 처리
                        if (e is DioException &&
                            e.response?.statusCode == 401) {
                          print('로그인 실패: 잘못된 이메일 또는 비밀번호입니다.');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('잘못된 이메일 또는 비밀번호입니다.')),
                          );
                        } else {
                          print('로그인 실패: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('로그인 실패: $e')),
                          );
                        }
                      }
                    }
                  },
                  child: Text('로그인'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.AppColors.primaryColor_500, // 버튼 배경색 설정
                    foregroundColor: Colors.white, // 텍스트 색상 설정
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    minimumSize: Size(double.infinity, 50),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // 이메일 찾기 | 비밀번호 찾기 | 회원가입 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // 이메일 찾기 로직 추가
                      },
                      child: Text('이메일 찾기'),
                    ),
                    Text(' | '),
                    TextButton(
                      onPressed: () {
                        // 비밀번호 찾기 로직 추가
                      },
                      child: Text('비밀번호 찾기'),
                    ),
                    Text(' | '),
                    TextButton(
                      onPressed: () {
                        // 회원가입 로직 추가
                      },
                      child: Text('회원가입'),
                    ),
                  ],
                ),
                SizedBox(height: 120),
                // 카카오로 시작하기 버튼
                ElevatedButton.icon(
                  onPressed: () {
                    // 카카오 로그인 로직 추가
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/login/kakao_logo.svg', // 카카오 로고 이미지 경로
                    width: 24,
                    height: 24,
                  ),
                  label: Text('카카오로 시작하기'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFEE500), // 카카오 버튼 배경색
                    foregroundColor: Colors.black, // 카카오 버튼 텍스트 색상
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    minimumSize: Size(double.infinity, 50),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
