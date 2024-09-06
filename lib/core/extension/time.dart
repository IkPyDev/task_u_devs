extension TimeExtensions on String {
  DateTime _parseTimestamp() {
    final timestamp = int.tryParse(this);
    return timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : DateTime.now();
  }

  String get dayString => _parseTimestamp().day.toString().padLeft(2, '0');
  String get monthString => _parseTimestamp().month.toString().padLeft(2, '0');
  String get yearString => _parseTimestamp().year.toString();
  String get hourString => _parseTimestamp().hour.toString().padLeft(2, '0');
  String get minuteString => _parseTimestamp().minute.toString().padLeft(2, '0');

  String timeDifferenceFromNow() {
    final dateTime = _parseTimestamp();
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes == 0) {
      return "now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays < 30) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return "$months months ago";
    } else {
      final years = (difference.inDays / 365).floor();
      return "$years years ago";
    }
  }
}

extension TimeExtensionsForInt on int {
  DateTime get _dateTime => DateTime.fromMillisecondsSinceEpoch(this);

  String get dayString => _dateTime.day.toString().padLeft(2, '0');
  String get monthString => _dateTime.month.toString().padLeft(2, '0');
  String get yearString => _dateTime.year.toString();
  String get hourString => _dateTime.hour.toString().padLeft(2, '0');
  String get minuteString => _dateTime.minute.toString().padLeft(2, '0');

  String timeDifferenceFromNow() {
    final now = DateTime.now();
    final difference = now.difference(_dateTime);

    if (difference.inMinutes == 0) {
      return "now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays < 30) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return "$months months ago";
    } else {
      final years = (difference.inDays / 365).floor();
      return "$years years ago";
    }
  }
}
