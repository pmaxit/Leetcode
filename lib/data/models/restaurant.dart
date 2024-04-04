import 'dart:ui';

class Restaurant{
  final String name;
  final String address;
  final String phone;
  final String image;
  final Color color;

  const Restaurant({
    required this.name,
    required this.address,
    required this.phone,
    required this.image,
    required this.color,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    name: json['name'],
    address: json['address'],
    phone: json['phone'],
    image: json['image'],
    color: Color(int.parse(json['color'])),
  );
  
}