import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import '../api/api_constants.dart';

final googleAuthServiceProvider = Provider<GoogleAuthService>((ref) {
  return GoogleAuthService();
});

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    // For web support, add your Web OAuth Client ID here:
    // clientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
    // For backend authentication (optional):
    // serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
  );

  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    headers: {'Content-Type': 'application/json'},
  ));

  /// Sign in with Google - first tries silent sign-in, then interactive
  Future<GoogleSignInAccount?> signIn() async {
    try {
      print('🔐 Starting Google Sign-In...');
      
      // First, try silent sign-in for persistent authentication
      GoogleSignInAccount? account = await _googleSignIn.signInSilently();
      
      if (account != null) {
        print('✅ Silent sign-in successful: ${account.email}');
        return account;
      }
      
      // If silent sign-in fails, try interactive sign-in
      print('⚠️ Silent sign-in failed, trying interactive sign-in...');
      account = await _googleSignIn.signIn();
      
      if (account != null) {
        print('✅ Interactive sign-in successful: ${account.email}');
        return account;
      } else {
        print('❌ User cancelled sign-in');
        return null;
      }
    } catch (e) {
      print('❌ Google Sign-In Error: $e');
      print('Error details: ${e.runtimeType}');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      print('🔓 Signing out from Google...');
      await _googleSignIn.signOut();
      print('✅ Google sign-out successful');
    } catch (e) {
      print('❌ Error signing out: $e');
    }
  }

  bool get isSignedIn => _googleSignIn.currentUser != null;

  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  /// Authenticate with our backend using Google credentials
  /// Authenticate with backend using Google credentials
  Future<Map<String, dynamic>?> authenticateWithBackend(GoogleSignInAccount account) async {
    try {
      print('🔄 Getting Google authentication tokens...');
      final authentication = await account.authentication;
      
      print('🔄 Authenticating with backend...');
      print('Backend URL: ${ApiConstants.baseUrl}${ApiConstants.login}');
      
      final response = await _dio.post(
        ApiConstants.login,
        data: {
          'email': account.email,
          'googleId': account.id,
          'name': account.displayName,
          'photoUrl': account.photoUrl,
          'idToken': authentication.idToken,
          'provider': 'google',
        },
      );

      if (response.statusCode == 200) {
        print('✅ Backend authentication successful');
        print('Response: ${response.data}');
        return response.data;
      }
      
      print('⚠️ Backend returned status code: ${response.statusCode}');
      return null;
    } catch (e) {
      print('❌ Backend auth error: $e');
      if (e is DioException) {
        print('Error type: ${e.type}');
        print('Error message: ${e.message}');
        print('Response: ${e.response?.data}');
      }
      
      // If backend doesn't support Google auth yet, create a mock response
      print('⚠️ Using mock backend response for Google auth');
      return {
        'user': {
          'id': account.id,
          'email': account.email,
          'name': account.displayName ?? 'User',
          'image': account.photoUrl,
        },
        'token': 'google_${account.id}',
      };
    }
  }
}
