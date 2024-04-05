enum TaskFilter {
  today,
  tomorrow,
  week;

  String get description {
    switch (this) {
      case TaskFilter.today:
        return 'DE HOJE';
      case TaskFilter.tomorrow:
        return 'DE AMANHÃ';
      case TaskFilter.week:
        return 'DA SEMANA';
    }
  }
}
