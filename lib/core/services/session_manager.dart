import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/storage_keys.dart';

/// Persistencia segura de credenciales y datos de sesión.
///
/// Sin lógica de negocio: solo lectura/escritura de claves.
class SessionManager {
  SessionManager({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            );

  final FlutterSecureStorage _storage;

  Future<String?> getAccessToken() =>
      _storage.read(key: StorageKeys.accessToken);

  Future<void> saveAccessToken(String token) =>
      _storage.write(key: StorageKeys.accessToken, value: token);

  Future<String?> getTokenType() => _storage.read(key: StorageKeys.tokenType);

  Future<void> saveTokenType(String tokenType) =>
      _storage.write(key: StorageKeys.tokenType, value: tokenType);

  Future<int?> getStudentId() async {
    final value = await _storage.read(key: StorageKeys.studentId);
    if (value == null) return null;
    return int.tryParse(value);
  }

  Future<void> saveStudentId(int? studentId) async {
    if (studentId == null) {
      await _storage.delete(key: StorageKeys.studentId);
      return;
    }
    await _storage.write(
      key: StorageKeys.studentId,
      value: studentId.toString(),
    );
  }

  Future<String?> getUserEmail() => _storage.read(key: StorageKeys.userEmail);

  Future<void> saveUserEmail(String? email) async {
    if (email == null) {
      await _storage.delete(key: StorageKeys.userEmail);
      return;
    }
    await _storage.write(key: StorageKeys.userEmail, value: email);
  }

  Future<String?> getUserFullName() =>
      _storage.read(key: StorageKeys.userFullName);

  Future<void> saveUserFullName(String? fullName) async {
    if (fullName == null) {
      await _storage.delete(key: StorageKeys.userFullName);
      return;
    }
    await _storage.write(key: StorageKeys.userFullName, value: fullName);
  }

  Future<int?> getStudentExamId() async {
    final value = await _storage.read(key: StorageKeys.studentExamId);
    if (value == null) return null;
    return int.tryParse(value);
  }

  Future<void> saveStudentExamId(int studentExamId) => _storage.write(
        key: StorageKeys.studentExamId,
        value: studentExamId.toString(),
      );

  Future<void> clearStudentExamId() =>
      _storage.delete(key: StorageKeys.studentExamId);

  Future<bool> hasSession() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> clearSession() async {
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.tokenType);
    await _storage.delete(key: StorageKeys.studentId);
    await _storage.delete(key: StorageKeys.userEmail);
    await _storage.delete(key: StorageKeys.userFullName);
    await _storage.delete(key: StorageKeys.studentExamId);
  }
}
