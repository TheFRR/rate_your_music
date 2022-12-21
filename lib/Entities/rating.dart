class Rating {
  double Value = 0;
  String UserID = "";

  Rating(double value, String userID) {
    Value = value;
    UserID = userID;
  }

  Map<String, dynamic> toMap() {
    return {
      'value': Value,
      'userID': UserID,
    };
  }

  Rating._({required this.Value, required this.UserID});

  factory Rating.fromJson(Map<String, dynamic> data) {
    return Rating._(
        Value: data['value'] as double, UserID: data['userID'] as String);
  }
}
