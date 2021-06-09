class UserData{
  static String name;
  static String email;
  static String picture;
  static bool isLogin;
  bool isLogout;
  // String name;
  // String email;
  // String picture;
  // UserData({this.name, this.email, this.picture});

  void setLogin(bool status, Map user){
    isLogin = status;
    name = user['name'];
    email = user['email'];
    picture = user['picture']['data']['url'];
  }

  String getName(){
    return name;
  }

  String getEmail(){
    return email;
  }

  String getPicture(){
    return picture;
  }

  void setLogout(bool status){
    isLogout = status;
  }

  bool checkLogin(){
    if(isLogout == true){
      return false;
    }else {
      if (isLogin == true) {
        return true;
      } else {
        return false;
      }
    }
  }
}