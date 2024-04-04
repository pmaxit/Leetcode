import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/questions.dart';
import '../../../services/db_services.dart';


class HomeState extends Equatable {
  final bool isLoading;
  final Iterable<Question> questions;
  final String? error;

  const HomeState._({
    this.isLoading = false,
    this.questions = const [],
    this.error,
  });

  // copyWIth
  HomeState copyWith({
    bool? isLoading,
    Iterable<Question>?  questions,
    String? error,
  }) {
    return HomeState._(
      isLoading: isLoading ?? this.isLoading,
      questions: questions ?? this.questions,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, questions, error];
}

