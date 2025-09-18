import 'package:flutter/material.dart';

class Timehelper {



  String getTimeAgo(String dateString) {
    try {
 
      final DateTime createdDate = DateTime.parse(dateString);
      final DateTime now = DateTime.now();
      

      final Duration difference = now.difference(createdDate);
      
      return _formatDuration(difference);
    } catch (e) {
      debugPrint('Error parsing date: $e');
      return 'Unknown';
    }
  }
  
  
 String _formatDuration(Duration duration) {
    if (duration.isNegative) {
      return 'Just now';
    }
    
    final int seconds = duration.inSeconds;
    final int minutes = duration.inMinutes;
    final int hours = duration.inHours;
    final int days = duration.inDays;
    final int weeks = (days / 7).floor();
    final int months = (days / 30).floor();
    final int years = (days / 365).floor();
    
    if (years > 0) {
      return years == 1 ? '1 year ago' : '$years years ago';
    } else if (months > 0) {
      return months == 1 ? '1 month ago' : '$months months ago';
    } else if (weeks > 0) {
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (days > 0) {
      return days == 1 ? '1 day ago' : '$days days ago';
    } else if (hours > 0) {
      return hours == 1 ? '1 hour ago' : '$hours hours ago';
    } else if (minutes > 0) {
      return minutes == 1 ? '1 minute ago' : '$minutes minutes ago';
    } else if (seconds > 30) {
      return '$seconds seconds ago';
    } else {
      return 'Just now';
    }
  }
}
