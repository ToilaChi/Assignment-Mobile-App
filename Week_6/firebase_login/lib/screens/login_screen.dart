import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  // Phone authentication
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? _verificationId;
  bool _showOtpField = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  Future<void> _handleSignIn(Future<dynamic> Function() signInMethod) async {
    _setLoading(true);
    try {
      final result = await signInMethod();
      if (result != null && mounted) {
        Navigator.pushReplacementNamed(context, '/success');
      }
    } catch (e) {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          '/failed',
          arguments: e.toString(),
        );
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _signInWithGoogle() async {
    await _handleSignIn(() => _authService.signInWithGoogle());
  }

  Future<void> _signInWithApple() async {
    await _handleSignIn(() => _authService.signInWithApple());
  }

  Future<void> _signInWithFacebook() async {
    await _handleSignIn(() => _authService.signInWithFacebook());
  }

  Future<void> _sendOTP() async {
    if (_phoneController.text.isEmpty) {
      _showSnackBar('Please enter phone number');
      return;
    }

    String phoneNumber = _phoneController.text.trim();
    if (!phoneNumber.startsWith('+')) {
      phoneNumber = '+84${phoneNumber.replaceFirst('0', '')}';
    }

    _setLoading(true);

    await _authService.signInWithPhone(
      phoneNumber: phoneNumber,
      codeSent: (verificationId) {
        setState(() {
          _verificationId = verificationId;
          _showOtpField = true;
          _isLoading = false;
        });
        _showSnackBar('OTP sent successfully');
      },
      verificationFailed: (error) {
        _setLoading(false);
        _showSnackBar('Failed to send OTP: $error');
      },
    );
  }

  Future<void> _verifyOTP() async {
    if (_otpController.text.isEmpty || _verificationId == null) {
      _showSnackBar('Please enter OTP');
      return;
    }

    _setLoading(true);
    try {
      final result = await _authService.verifyOTP(
        verificationId: _verificationId!,
        smsCode: _otpController.text.trim(),
      );

      if (result != null && mounted) {
        Navigator.pushReplacementNamed(context, '/success');
      }
    } catch (e) {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          '/failed',
          arguments: e.toString(),
        );
      }
    } finally {
      _setLoading(false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.purple.shade400],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo/Title
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: 60,
                      color: Colors.blue.shade600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Sign in to continue',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 50),

                  // Login Card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          // Google Sign In
                          _SocialLoginButton(
                            onPressed: _isLoading ? null : _signInWithGoogle,
                            icon: Icons.g_mobiledata,
                            label: 'Continue with Google',
                            backgroundColor: Colors.white,
                            textColor: Colors.black87,
                            borderColor: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 12),

                          // Apple Sign In
                          _SocialLoginButton(
                            onPressed: _isLoading ? null : _signInWithApple,
                            icon: Icons.apple,
                            label: 'Continue with Apple',
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                          ),
                          const SizedBox(height: 12),

                          // Facebook Sign In
                          _SocialLoginButton(
                            onPressed: _isLoading ? null : _signInWithFacebook,
                            icon: Icons.facebook,
                            label: 'Continue with Facebook',
                            backgroundColor: const Color(0xFF1877F2),
                            textColor: Colors.white,
                          ),
                          const SizedBox(height: 24),

                          // Divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(color: Colors.grey.shade400),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Phone Number Input
                          if (!_showOtpField) ...[
                            TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                hintText: '+84 123 456 789',
                                prefixIcon: const Icon(Icons.phone),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _sendOTP,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: Colors.blue.shade600,
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : const Text(
                                        'Send OTP',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ],

                          // OTP Input
                          if (_showOtpField) ...[
                            TextField(
                              controller: _otpController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              decoration: InputDecoration(
                                labelText: 'Enter OTP',
                                hintText: '123456',
                                prefixIcon: const Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _verifyOTP,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: Colors.green.shade600,
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : const Text(
                                        'Verify OTP',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _showOtpField = false;
                                  _verificationId = null;
                                  _otpController.clear();
                                });
                              },
                              child: const Text('Change Phone Number'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const _SocialLoginButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: textColor),
        label: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
