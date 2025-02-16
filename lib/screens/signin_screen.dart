import 'package:flutter/material.dart';

import 'package:groomingo/styles/colors.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
                  child: Center(
                    child: Image.asset(
                      'assets/images/common/temp_logo.png', // 로고 이미지 경로
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                // 이메일 입력 인풋
                TextFormField(
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // 로그인 로직 추가
                    }
                  },
                  child: Text('로그인'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor_500,
                    foregroundColor: Colors.white,
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
