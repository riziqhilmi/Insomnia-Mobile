import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../widgets/custom_button.dart';
import '../screens/reset_password.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({
    super.key,
    required this.email,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  Timer? _timer;
  int _remainingSeconds = 120; // 2 minutes
  String _formattedTime = "02:00";

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingSeconds--;
          _formattedTime = formatTime(_remainingSeconds);
        });
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void resendOTP() {
    // Implement your resend OTP logic here
    setState(() {
      _remainingSeconds = 120;
      _formattedTime = "02:00";
    });
    startTimer();

    // Show snackbar to confirm OTP was resent
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP baru telah dikirim ke ${widget.email}'),
        backgroundColor: Color(0xFF392F5A),
      ),
    );
  }

  void verifyOTP() {
    // Collect all digits
    String completeOTP =
        _otpControllers.map((controller) => controller.text).join();

    // Check if OTP is complete
    if (completeOTP.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mohon masukkan kode OTP lengkap'),
          backgroundColor: Colors.red.shade700,
        ),
      );
      return;
    }

    // Here you would call your verification API
    // For now, we'll just show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verifikasi OTP berhasil!'),
        backgroundColor: Colors.green.shade700,
      ),
    );

    // Navigate to the next screen after verification
    // Navigator.of(context).pushReplacement(...);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121421),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                // App bar with back button
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF1C2031),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                // Sleep themed illustration
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF3B3878),
                          Color(0xFF292561),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF8E97FD).withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.nightlight_round,
                            size: 100,
                            color: Color(0xFF8E97FD).withOpacity(0.7),
                          ),
                          Positioned(
                            top: 50,
                            right: 55,
                            child: Icon(
                              Icons.star,
                              size: 24,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          Positioned(
                            top: 80,
                            left: 55,
                            child: Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40),

                // Title
                Center(
                  child: Text(
                    'Verifikasi Email',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                SizedBox(height: 12),

                // Instruction text
                Center(
                  child: Text(
                    'Kode verifikasi telah dikirim ke',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                ),

                SizedBox(height: 4),

                // Email display
                Center(
                  child: Text(
                    widget.email,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8E97FD),
                    ),
                  ),
                ),

                SizedBox(height: 50),

                // OTP input fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                    (index) => _buildOTPDigitField(index),
                  ),
                ),

                SizedBox(height: 50),

                // Timer and resend option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kirim ulang kode dalam ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                    Text(
                      _formattedTime,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8E97FD),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Resend button
                Center(
                  child: TextButton(
                    onPressed: _remainingSeconds > 0 ? null : resendOTP,
                    child: Text(
                      'Kirim Ulang Kode',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _remainingSeconds > 0
                            ? Colors.grey
                            : Color(0xFF8E97FD),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 50),

                // Verify button
                CustomButton(
                  text: 'Verifikasi',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const  ResetPasswordScreen (),
                      ),
                    );
                  },
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7583CA), Color(0xFF8E97FD)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOTPDigitField(int index) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Color(0xFF8E97FD),
              width: 2,
            ),
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.isNotEmpty) {
            // Move to next field if available
            if (index < 3) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
              // Auto verify when all fields are filled
              if (_otpControllers
                  .every((controller) => controller.text.isNotEmpty)) {
                // Optional: auto verify
                // verifyOTP();
              }
            }
          } else if (index > 0 && value.isEmpty) {
            // Move to previous field on backspace with empty field
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
