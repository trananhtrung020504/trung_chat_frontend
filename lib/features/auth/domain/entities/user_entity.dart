class UserEntity {
  final String id;
  final String email;
  final String username;
  final String token;

  UserEntity({required this.username, required this.id, required this.email,  this.token = ''});
}