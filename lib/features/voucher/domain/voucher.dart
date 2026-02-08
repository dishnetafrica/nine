class Voucher {
  const Voucher({
    required this.code,
    required this.profile,
    required this.createdAt,
    required this.qrPayload,
    this.syncedToMikroTik = false,
  });

  final String code;
  final String profile;
  final DateTime createdAt;
  final String qrPayload;
  final bool syncedToMikroTik;

  Voucher copyWith({bool? syncedToMikroTik}) {
    return Voucher(
      code: code,
      profile: profile,
      createdAt: createdAt,
      qrPayload: qrPayload,
      syncedToMikroTik: syncedToMikroTik ?? this.syncedToMikroTik,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'profile': profile,
        'createdAt': createdAt.toIso8601String(),
        'qrPayload': qrPayload,
        'syncedToMikroTik': syncedToMikroTik,
      };

  factory Voucher.fromJson(Map<dynamic, dynamic> json) => Voucher(
        code: json['code'] as String,
        profile: json['profile'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        qrPayload: json['qrPayload'] as String,
        syncedToMikroTik: json['syncedToMikroTik'] as bool? ?? false,
      );
}
