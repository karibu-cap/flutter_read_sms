class SMS {
  /// The stored key ref for the [body] property.
  static const keyBody = 'body';

  /// The stored key ref for the [sender] property.
  static const keySender = 'sender';

  /// The stored key ref for the [timeReceived] property.
  static const keyTimeReceived = 'timeReceived';

  /// The body of the message received
  final String body;

  /// Senders contact
  final String sender;

  /// The time when sms is received
  final DateTime timeReceived;

  /// Constructs a new [SMS] from [Map] object.
  SMS.fromJson(Map<String, dynamic> json)
      : body = json[keyBody],
        sender = json[keySender],
        timeReceived = DateTime.fromMillisecondsSinceEpoch(
          int.parse(json[keyTimeReceived] as String),
        );
}
