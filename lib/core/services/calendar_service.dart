import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/timezone.dart' as tz;

class CalendarService {
  final DeviceCalendarPlugin _plugin = DeviceCalendarPlugin();

  Future<bool> requestPermissions() async {
    final permissions = await _plugin.hasPermissions();
    if (permissions.isSuccess && (permissions.data ?? false)) return true;
    final request = await _plugin.requestPermissions();
    return request.isSuccess && (request.data ?? false);
  }

  Future<String?> addEvent({
    required String title,
    required DateTime eventDate,
    String? description,
  }) async {
    final hasPermission = await requestPermissions();
    if (!hasPermission) return 'Permissions refusées';

    final calendarsResult = await _plugin.retrieveCalendars();
    if (!calendarsResult.isSuccess || calendarsResult.data == null || calendarsResult.data!.isEmpty) {
      return 'Aucun calendrier trouvé';
    }

    // On cherche un calendrier qui n'est pas en lecture seule
    final calendar = calendarsResult.data!.firstWhere(
      (c) => !(c.isReadOnly ?? true),
      orElse: () => calendarsResult.data!.first,
    );

    final event = Event(calendar.id, title: title);
    event.start = tz.TZDateTime.from(eventDate, tz.local);
    event.end = tz.TZDateTime.from(eventDate.add(const Duration(hours: 1)), tz.local);
    event.description = description;
    event.allDay = true;

    final result = await _plugin.createOrUpdateEvent(event);
    if (result?.isSuccess ?? false) {
      return null; // Succès
    } else {
      return result?.errors.map((e) => e.errorMessage).join(', ') ?? 'Erreur inconnue';
    }
  }
}
