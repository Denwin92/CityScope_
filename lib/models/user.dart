class CityScopeUser {
  String id = '';
  String email = '';
  String name = '';
  String surname = '';
  String number = '';
  String password = '';
  String confirmPassword = '';



  CityScopeUser();

  CityScopeUser.fromJson(Map<String, dynamic> json){
    id = json ['id'];
    email = json ['email'];
    name = json  ['name'];
    number = json ['number'];
  }

  Map<String,dynamic> toJson() => {
    "email": email,
    "name": name,
    "id" : "",
    "number": number

  };

  bool get passwordMatches{

    return password == confirmPassword;

  }
}

