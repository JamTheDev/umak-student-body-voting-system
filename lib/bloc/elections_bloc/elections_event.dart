part of 'elections_bloc.dart';

@immutable
sealed class ElectionsEvent {}

final class GetActiveElection extends ElectionsEvent {}
final class GetElections extends ElectionsEvent {}