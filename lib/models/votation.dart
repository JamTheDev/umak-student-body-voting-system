class Votation {
  final String positionId;
  final String electionId;
  final String candidateId;
  final String castedOn;

  Votation({
    required this.positionId,
    required this.electionId,
    required this.candidateId,
    required this.castedOn,
  });

  factory Votation.fromMap(Map<String, dynamic> map) {
    return Votation(
      positionId: map['position_id'],
      electionId: map['election_id'],
      candidateId: map['candidate_id'],
      castedOn: map['casted_on'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'position_id': positionId,
      'election_id': electionId,
      'candidate_id': candidateId,
      'casted_on': castedOn,
    };
  }

  factory Votation.fromJson(dynamic json) {
    return Votation(
      positionId: json['position_id'],
      electionId: json['election_id'],
      candidateId: json['candidate_id'],
      castedOn: json['casted_on'],
    );
  }
}
