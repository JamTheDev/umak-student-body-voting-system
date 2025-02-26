import 'package:umakvotingapp/supabase/database/row.dart';
import 'package:umakvotingapp/supabase/database/table.dart';

import '../database.dart';

class CandidatesTable extends SupabaseTable<CandidatesRow> {
  @override
  String get tableName => 'candidates';

  @override
  CandidatesRow createRow(Map<String, dynamic> data) =>
      CandidatesRow(data);
}

class CandidatesRow extends SupabaseDataRow {
  CandidatesRow(super.data);

  @override
  SupabaseTable get table => CandidatesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get electionId => getField<String>('election_id');
  set electionId(String? value) => setField<String>('election_id', value);

  String? get positionId => getField<String>('position_id');
  set positionId(String? value) => setField<String>('position_id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String? get platform => getField<String>('platform');
  set platform(String? value) => setField<String>('platform', value);

  String? get profilePicture => getField<String>('profile_picture');
  set profilePicture(String? value) => setField<String>('profile_picture', value);

  String? get partylistId => getField<String>('partylist_id');
  set partylistId(String? value) => setField<String>('partylist_id', value);

  String? get collegeId => getField<String>('college_id');
  set collegeId(String? value) => setField<String>('college_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

}
