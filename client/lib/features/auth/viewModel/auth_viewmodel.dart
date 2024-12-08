import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repositeries/auth_remote_respositery.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  final AuthRemoteRepositery _authRemoteRepositery = AuthRemoteRepositery();
  @override
  AsyncValue<UserModel>? build() {
    return null;
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepositery.signup(
      name: name,
      email: email,
      password: password,
    );

    final val = switch (res) {
      fpdart.Left(value: final l) => state =
          AsyncValue.error(l, StackTrace.current),
      fpdart.Right(
        value: final r,
      ) =>
        state = AsyncValue.data(r),
    };
    print(val);
  }
}
