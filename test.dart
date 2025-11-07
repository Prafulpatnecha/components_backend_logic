// enum TaskDifficulty { low, medium, high }


// class TaskProgress {
//   int lowCount = 0;
//   int mediumCount = 0;
//   int highCount = 0;


//   int get lowPoints => (3 + lowCount).clamp(3, 10);
//   int get mediumPoints => (5 + mediumCount).clamp(5, 20);
//   int get highPoints => (10 + highCount * 2).clamp(10, 30);
// }


// class DailyTaskManager {
//   int totalPoints = 0;
//   int currentStreak = 0;
//   DateTime? lastDate;
//   TaskProgress progress = TaskProgress();

//   Map<String, bool> tasksCompletedToday = {
//     "low": false,
//     "medium": false,
//     "high": false,
//   };

//   void resetDaily() {
//     tasksCompletedToday = {
//       "low": false,
//       "medium": false,
//       "high": false,
//     };
//   }

//   void checkAndUpdateStreak(DateTime today) {
//     if (lastDate == null) {
//       currentStreak = 1;
//     } else if (isSameDate(lastDate!.add(Duration(days: 1)), today)) {
//       currentStreak++;
//     } else if (!isSameDate(lastDate!, today)) {
//       currentStreak = 1;
//     }
//     lastDate = today;
//   }

//   void completeTask(TaskDifficulty difficulty, DateTime today, int dayNum) {
//     if (lastDate == null || !isSameDate(lastDate!, today)) {
//       resetDaily();
//     }

//     final key = difficulty.name;
//     if (tasksCompletedToday[key]!) {
//       print("⚠️ Already completed $key task today.");
//       return;
//     }

//     checkAndUpdateStreak(today);

//     int points = 0;

//     switch (difficulty) {
//       case TaskDifficulty.low:
//         points = progress.lowPoints;
//         progress.lowCount++;
//         break;
//       case TaskDifficulty.medium:
//         points = progress.mediumPoints;
//         progress.mediumCount++;
//         break;
//       case TaskDifficulty.high:
//         points = progress.highPoints;
//         progress.highCount++;
//         break;
//     }

//     totalPoints += points;
//     if (totalPoints > 200) totalPoints = 200;

//     tasksCompletedToday[key] = true;

//     print("════════════════════════════════════════════");
//     print("📅 Day $dayNum - Task: ${difficulty.name.toUpperCase()}");
//     print("➕ Earned: $points points");
//     print("💯 Total Points: $totalPoints");
//     print("🔥 Streak: $currentStreak days\n");
//   }

//   bool isSameDate(DateTime a, DateTime b) =>
//       a.year == b.year && a.month == b.month && a.day == b.day;
// }

// void main() {
//   final taskManager = DailyTaskManager();

//   // 🔁 13-day repeat pattern
//   final List<TaskDifficulty> pattern = [
//     TaskDifficulty.low,
//     TaskDifficulty.medium,
//     TaskDifficulty.high,
//     TaskDifficulty.medium,
//     TaskDifficulty.low,
//     TaskDifficulty.high,
//     TaskDifficulty.high,
//     TaskDifficulty.low,
//     TaskDifficulty.medium,
//     TaskDifficulty.low,
//     TaskDifficulty.medium,
//     TaskDifficulty.high,
//     TaskDifficulty.high,
//   ];

//   // 🔄 Simulate 60 days
//   int totalDaysToSimulate = 100;
//   DateTime today = DateTime.now().subtract(Duration(days: totalDaysToSimulate));

//   for (int i = 0; i < totalDaysToSimulate; i++) {
//     today = today.add(Duration(days: 1));
//     int patternIndex = i % pattern.length;
//     TaskDifficulty task = pattern[patternIndex];
//     taskManager.completeTask(task, today, i + 1);
//   }

//   print("🏁 FINAL TOTAL POINTS: ${taskManager.totalPoints}");
//   print("🏆 FINAL STREAK: ${taskManager.currentStreak} days");
// }


void main() {
  // 13-day repeat pattern
  final List<String> pattern = [
    "low", "medium", "high", "medium", "low", "high", "high",
    "low", "medium", "low", "medium", "high", "high"
  ];

  // Point counters
  int lowCount = 0;
  int mediumCount = 0;
  int highCount = 0;

  // Loop through 60 days
  int lowValue = 3;
  int mediumValue = 5;
  int highValue = 10;
  for (int day = 0; day < 200; day++) {
    String task = pattern[day % pattern.length];
    int points = 0;

    if (task == "low") {
      points = (lowValue + lowCount).clamp(lowValue, 30);
      lowCount++;
      if(points == 30){
        lowCount = 0;
        lowValue = lowValue+1;
      }
    } else if (task == "medium") {
      points = (mediumValue + mediumCount).clamp(mediumValue, 60);
      mediumCount++;
      if(points == 60){
        mediumCount = 0;
        mediumValue = mediumValue+1;
      }
    } else if (task == "high") {
      points = (highValue + highCount * 2).clamp(highValue, 120);
      highCount++;
      if(points == 120){
        highCount = 0;
        highValue = highValue+1;
      }
    }
    //! demo
    // else if (task == "high") {
    //   points = (10 + highCount * 2).clamp(10, 120);
    //   highCount++;
    //   if(points == 30){
    //     lowCount = 0;
    //     highValue = highValue+1;
    //   }
    // }

    print("📅 Day ${day + 1} - Task: ${task.toUpperCase()} ➕ Earned: $points points");
  }
}
