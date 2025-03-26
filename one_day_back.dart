void main() {
  DateTime dateTime = DateTime.now();
  
  DateTime oneDayBack = dateTime.subtract(Duration(days: 1));

  print('Current DateTime: $dateTime');
  print('One day back: $oneDayBack');
}