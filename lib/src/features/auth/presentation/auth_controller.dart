import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/user.dart';
import '../data/auth_repository.dart';
import '../../../core/services/auth_service.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<User?> build() {
    // Check if user is already logged in
    _loadStoredUser();
    return const AsyncValue.data(null);
  }

  Future<void> _loadStoredUser() async {
    try {
      final authService = await ref.read(authServiceProvider.future);
      final storedUser = authService.getUser();
      if (storedUser != null) {
        state = AsyncValue.data(storedUser);
      }
    } catch (e) {
      // Ignore errors loading stored user
    }
  }

  Future<bool> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final authRepo = ref.read(authRepositoryProvider);
      final result = await authRepo.login(email, password);
      
      final authService = await ref.read(authServiceProvider.future);
      if (result['token'] != null) {
        await authService.saveToken(result['token']);
      }
      if (result['user'] != null) {
        await authService.saveUser(result['user']);
        state = AsyncValue.data(result['user']);
      }
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final authRepo = ref.read(authRepositoryProvider);
      final result = await authRepo.register(name, email, password);
      
      final authService = await ref.read(authServiceProvider.future);
      if (result['token'] != null) {
        await authService.saveToken(result['token']);
      }
      if (result['user'] != null) {
        await authService.saveUser(result['user']);
        state = AsyncValue.data(result['user']);
      }
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }

  Future<void> logout() async {
    final authService = await ref.read(authServiceProvider.future);
    await authService.clearAuth();
    state = const AsyncValue.data(null);
  }

  bool get isLoggedIn => state.value != null;
}

@riverpod
User? currentUser(Ref ref) {
  final state = ref.watch(authControllerProvider);
  return state.value;
}

@riverpod
bool isLoggedIn(Ref ref) {
  return ref.watch(currentUserProvider) != null;
}
