import 'package:alex_grant_ai/screens/resetPassword.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ResetCodeScreen extends StatefulWidget {
  const ResetCodeScreen({Key? key}) : super(key: key);

  @override
  State<ResetCodeScreen> createState() => _ResetCodeScreenState();
}

class _ResetCodeScreenState extends State<ResetCodeScreen> {
  final List<TextEditingController> controllers = List.generate(
    4,
        (index) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(
    4,
        (index) => FocusNode(),
  );

  Timer? _timer;
  int _timeLeft = 45; // 45 seconds for resend timer
  bool _canResend = false;
  final String _correctOtp = "1234";
  String? _message; // Message to display at the top of the screen
  bool _isMessageVisible = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    _timer?.cancel();
    setState(() {
      _timeLeft = 45;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  String get timerText {
    return '${(_timeLeft / 60).floor()}:${(_timeLeft % 60).toString().padLeft(2, '0')}';
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
      _isMessageVisible = true;
    });

    // Automatically hide the message after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isMessageVisible = false;
      });
    });
  }

  void _verifyOtp() {
    String enteredOtp = controllers.map((controller) => controller.text).join();
    if (enteredOtp == _correctOtp) {
      _showMessage("✅ OTP Verified");

      // Delay navigation to show the message for 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>const ResetPasswordScreen(),
          ),
        );
      });
    } else {
      _showMessage("❌ Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Reset Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter the reset code',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter code sent to your email address',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                        (index) => Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            focusNodes[index + 1].requestFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Didn\'t receive the code? ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: _canResend
                            ? () {
                          startTimer();
                          _showMessage("✅ The OTP has been resent");
                        }
                            : null,
                        child: Text(
                          _canResend
                              ? 'Resend code'
                              : 'Resend code (${timerText})',
                          style: TextStyle(
                            color: _canResend
                                ? const Color(0xFF8E44AD)
                                : Colors.grey,
                            fontSize: 14,
                            decoration:
                            _canResend ? TextDecoration.underline : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8E44AD),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Top Message Container
          if (_isMessageVisible)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                color: Colors.green,
                child: Center(
                  child: Text(
                    _message ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
