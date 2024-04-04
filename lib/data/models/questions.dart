import 'dart:ui';

import 'package:flutter/material.dart';

class Question{
  final int id;
  final String question;
  final String answer;
  final String image;
  final Color color;
  final int difficulty;
  final String frontCard;
  final String backCard;
  // created at 
  final DateTime createdAt = DateTime.now();
  final DateTime updatedAt = DateTime.now();

  Question({
    required this.id,
    required this.question,
    required this.answer,
    required this.image,
    required this.color,
    required this.difficulty,
    required this.frontCard,
    required this.backCard,

  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'answer': answer,
    'image': image,
    'color': color.value.toString(),
    'difficulty': difficulty,
    'front_card': frontCard,
    'back_card': backCard,
  };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json['id'],
    question: json['question'] ?? '',
    answer: json['answer'] ?? '',
    image: json['image'] ?? '',
    difficulty: json['difficulty'] ?? 0,
    frontCard: json['front_card'] ?? '',
    backCard: json['back_card'] ?? '',
    color: Colors.black12,
  );
}