String getMonthName(int month) {
  List<String> monthNames = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];
  return monthNames[month - 1];
}

String getWeekdayName(int date) {
  // Haftaning kunlari ro'yxati (ingliz tilida)
  List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  // Haftaning kuni indeksi va ro'yxatdan olish
  return weekdays[date - 1];
}