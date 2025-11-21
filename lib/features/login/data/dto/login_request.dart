class LoginRequest {
  final String? username;
  final String? email;
  final String password;
  
  LoginRequest({
    this.username,
    required this.password,
    this.email,
  }) : assert(
          username != null || email != null,
          'Either username or email must be provided',
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'password': password,
    };
    
    if (username != null) {
      json['username'] = username;
    }
    if (email != null) {
      json['email'] = email;
    }
    
    return json;
  }
}