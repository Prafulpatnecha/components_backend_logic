
GlobalKey homeSectionKey = GlobalKey();

void scrollToRecentSection() {
  Scrollable.ensureVisible(
    homeSectionKey.currentContext!,
    duration: const Duration(milliseconds: 800),
    curve: Curves.easeInOut,
  );
}