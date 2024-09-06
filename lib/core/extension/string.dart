extension FirstSentence on String {
  String? getFirstSentence() {
    if (contains('.')) {
      return substring(0, indexOf('.'));
    } else {
      return null;
    }
  }

}

extension TimeAgo on int? {
  String? timeAgo() {
    DateTime postTime = DateTime.fromMillisecondsSinceEpoch(this?? 0);
    DateTime currentTime = DateTime.now();

    Duration difference = currentTime.difference(postTime);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    return '${days > 0 ? "$days day${days > 1 ? 's' : ''}, " : ""}'
        '${hours > 0 ? "$hours hour${hours > 1 ? 's' : ''}, " : ""}'
        '${minutes > 0 ? "$minutes minute${minutes > 1 ? 's' : ''}" : ""} ago';
  }
}
