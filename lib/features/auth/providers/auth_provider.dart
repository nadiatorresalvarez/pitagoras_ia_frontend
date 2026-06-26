import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../core/providers/session_provider.dart';
import '../../../core/services/session_manager.dart';
import '../../../data/dto/auth_dto.dart';
import '../../../data/models/auth_model.dart';
import '../../../data/repositories/auth_repository.dart';

/// Coordina autenticación y persistencia de sesión.
class AuthProvider {
  AuthProvider({
    required AuthRepository repository,
    required SessionManager sessionManager,
  })  : _repository = repository,
        _sessionManager = sessionManager;

  final AuthRepository _repository;
  final SessionManager _sessionManager;

  Future<AuthSession> register(RegisterRequestDto request) async {
    final session = await _repository.register(request);
    await _persistSession(session);
    return session;
  }

  Future<AuthSession> login(LoginRequestDto request) async {
    final session = await _repository.login(request);
    await _persistSession(session);
    return session;
  }

  Future<AuthUser> getMe() => _repository.getMe();

  Future<bool> hasSession() => _sessionManager.hasSession();

  Future<void> logout() => _sessionManager.clearSession();

  Future<void> _persistSession(AuthSession session) async {
    await _sessionManager.saveAccessToken(session.accessToken);
    await _sessionManager.saveTokenType(session.tokenType);
    await _sessionManager.saveStudentId(session.user.studentId);
    await _sessionManager.saveUserEmail(session.user.email);
    await _sessionManager.saveUserFullName(session.user.fullName);
  }
}

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider(
    repository: ref.watch(authRepositoryProvider),
    sessionManager: ref.watch(sessionManagerProvider),
  );
});
