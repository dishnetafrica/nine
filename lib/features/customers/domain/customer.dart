class Customer {
  const Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.plan,
    required this.balance,
    required this.updatedAt,
  });

  final String id;
  final String name;
  final String phone;
  final String plan;
  final double balance;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'plan': plan,
        'balance': balance,
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Customer.fromJson(Map<dynamic, dynamic> json) => Customer(
        id: json['id'] as String,
        name: json['name'] as String,
        phone: json['phone'] as String,
        plan: json['plan'] as String,
        balance: (json['balance'] as num).toDouble(),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );
}
