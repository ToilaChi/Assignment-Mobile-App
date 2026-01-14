import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/auth_service.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? _userInfo;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() {
    setState(() {
      _userInfo = _authService.getUserInfo();
    });
  }

  Future<void> _signOut() async {
    try {
      await _authService.signOut();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error signing out: $e')));
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_userInfo == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green.shade400, Colors.teal.shade400],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Success Icon
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
                    Icons.check_circle_outline,
                    size: 80,
                    color: Colors.green.shade600,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Login Successful!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.circle, size: 12, color: Colors.greenAccent),
                      SizedBox(width: 8),
                      Text(
                        'User Online',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // User Info Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Picture & Name
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: _userInfo!['photoURL'] != null
                                  ? NetworkImage(_userInfo!['photoURL'])
                                  : null,
                              child: _userInfo!['photoURL'] == null
                                  ? const Icon(Icons.person, size: 40)
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _userInfo!['displayName'] ?? 'No Name',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  if (_userInfo!['email'] != null)
                                    Text(
                                      _userInfo!['email'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),

                        // User Details
                        const Text(
                          'Account Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _InfoRow(
                          icon: Icons.fingerprint,
                          label: 'User ID',
                          value: _userInfo!['uid'],
                          onCopy: () => _copyToClipboard(_userInfo!['uid']),
                        ),
                        if (_userInfo!['email'] != null)
                          _InfoRow(
                            icon: Icons.email,
                            label: 'Email',
                            value: _userInfo!['email'],
                            onCopy: () => _copyToClipboard(_userInfo!['email']),
                          ),
                        if (_userInfo!['phoneNumber'] != null)
                          _InfoRow(
                            icon: Icons.phone,
                            label: 'Phone',
                            value: _userInfo!['phoneNumber'],
                            onCopy: () =>
                                _copyToClipboard(_userInfo!['phoneNumber']),
                          ),
                        _InfoRow(
                          icon: Icons.verified_user,
                          label: 'Email Verified',
                          value: _userInfo!['isEmailVerified'] ? 'Yes' : 'No',
                          valueColor: _userInfo!['isEmailVerified']
                              ? Colors.green
                              : Colors.orange,
                        ),
                        if (_userInfo!['creationTime'] != null)
                          _InfoRow(
                            icon: Icons.calendar_today,
                            label: 'Created',
                            value: _formatDateTime(_userInfo!['creationTime']),
                          ),
                        if (_userInfo!['lastSignInTime'] != null)
                          _InfoRow(
                            icon: Icons.access_time,
                            label: 'Last Sign In',
                            value: _formatDateTime(
                              _userInfo!['lastSignInTime'],
                            ),
                          ),

                        // Provider Info
                        if (_userInfo!['providerData'] != null &&
                            (_userInfo!['providerData'] as List)
                                .isNotEmpty) ...[
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 16),
                          const Text(
                            'Sign-in Methods',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...(_userInfo!['providerData'] as List)
                              .map(
                                (provider) => _ProviderChip(
                                  providerId: provider['providerId'],
                                ),
                              )
                              .toList(),
                        ],

                        const SizedBox(height: 24),

                        // Sign Out Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _signOut,
                            icon: const Icon(Icons.logout),
                            label: const Text(
                              'Sign Out',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade400,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  String _formatDateTime(String dateTimeStr) {
    final dt = DateTime.parse(dateTimeStr);
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final VoidCallback? onCopy;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: valueColor ?? Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          if (onCopy != null)
            IconButton(
              icon: Icon(Icons.copy, size: 18, color: Colors.grey.shade600),
              onPressed: onCopy,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}

class _ProviderChip extends StatelessWidget {
  final String providerId;

  const _ProviderChip({required this.providerId});

  IconData _getProviderIcon() {
    if (providerId.contains('google')) return Icons.g_mobiledata;
    if (providerId.contains('apple')) return Icons.apple;
    if (providerId.contains('facebook')) return Icons.facebook;
    if (providerId.contains('phone')) return Icons.phone;
    return Icons.login;
  }

  Color _getProviderColor() {
    if (providerId.contains('google')) return Colors.red;
    if (providerId.contains('apple')) return Colors.black;
    if (providerId.contains('facebook')) return const Color(0xFF1877F2);
    if (providerId.contains('phone')) return Colors.green;
    return Colors.blue;
  }

  String _getProviderName() {
    if (providerId.contains('google')) return 'Google';
    if (providerId.contains('apple')) return 'Apple';
    if (providerId.contains('facebook')) return 'Facebook';
    if (providerId.contains('phone')) return 'Phone';
    return providerId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _getProviderColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _getProviderColor().withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getProviderIcon(), size: 20, color: _getProviderColor()),
          const SizedBox(width: 8),
          Text(
            _getProviderName(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _getProviderColor(),
            ),
          ),
        ],
      ),
    );
  }
}
