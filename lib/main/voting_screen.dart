import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umakvotingapp/backend/supabase/database/database.dart';
import 'package:umakvotingapp/bloc/election_candidates/election_candidates_bloc.dart';
import 'package:umakvotingapp/bloc/elections_bloc/elections_bloc.dart';
import 'package:umakvotingapp/bloc/supabase_connection/supabase_connection_bloc.dart';
import 'package:umakvotingapp/components/candidate_information.dart';
import 'package:umakvotingapp/components/voting_reminder_dialog.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<SupabaseConnectionBloc>(context)
        .add(OnSupabaseConnect(null, null));
  }

  void showVotingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => VotingReminderDialog(),
    );
  }

  @override
  Widget build(BuildContext rootContext) {
    ;
    return Scaffold(
      body: BlocListener<SupabaseConnectionBloc, SupabaseConnectionState>(
        listener: (context, state) {
          if (state is SupabaseConnectionFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }

          if (state is SupabaseConnectionConnected) {
            // Future.delayed(Duration.zero, () => showVotingDialog(context));
            BlocProvider.of<ElectionsBloc>(context).add(GetActiveElection());
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Connected to the server.'),
              ),
            );
          }
        },
        child: BlocBuilder<SupabaseConnectionBloc, SupabaseConnectionState>(
          builder: (context, state) {
            if (state is SupabaseConnectionConnecting) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF132255), Color(0xFF1D267D)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 4,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Loading, please wait...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Existing UI when not loading
            return BlocConsumer<ElectionsBloc, ElectionsState>(
              listener: (context, state) {
                if (state is ActiveElectionLoaded) {
                  BlocProvider.of<ElectionCandidatesBloc>(context)
                      .add(GetElectionCandidates(state.activeElection.id, 0));
                }
              },
              builder: (context, state) {
                if (state is ElectionsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return state is ElectionsLoaded
                    ? Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 41, vertical: 25),
                                    decoration: const BoxDecoration(
                                        color: Color(0xFF132255)),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                width: 222,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          'UMak University Student Council',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Metropolis',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          'For President',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontFamily:
                                                                'Metropolis',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 50),
                                              SizedBox(
                                                width: 100,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 17,
                                                          vertical: 5),
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: const Color(
                                                            0xFFFFF600),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: const Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '02:59',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Metropolis',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    const SizedBox(
                                                      width: double.infinity,
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: Text(
                                                          'Time Remaining',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 8,
                                                            fontFamily:
                                                                'Metropolis',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 17),
                                  BlocBuilder(
                                    builder: (context, state) {
                                      if (state is ElectionCandidatesLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (state is ElectionCandidatesLoaded) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          width: double.infinity,
                                          child: ListBody(
                                            children: state.electionCandidates!
                                                .map(
                                                  (candidate) =>
                                                      CandidateListItem(
                                                    candidate: candidate,
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  ElectionCandidatesBloc>(
                                                              context)
                                                          .add(
                                                              GetElectionCandidateDetails(
                                                                  candidate
                                                                      .id));
                                                    },
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        );
                                      }

                                      return Container();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 114),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 38, vertical: 24),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 145),
                                  SizedBox(
                                    width: 144,
                                    height: 46,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 144,
                                            height: 46,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFF132255),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(999),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 37,
                                          top: 11,
                                          child: SizedBox(
                                            width: 71,
                                            height: 24,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  width: 47,
                                                  child: SizedBox(
                                                    width: 47,
                                                    child: Text(
                                                      'Next',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Metropolis',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: const Icon(
                                                    Icons.arrow_right_sharp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container();
              },
            );
          },
        ),
      ),
    );
  }
}

class CandidateListItem extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isSelected;
  final CandidatesRow candidate;

  const CandidateListItem({
    super.key,
    this.onPressed,
    this.isSelected = false,
    required this.candidate,
  });

  @override
  State<CandidateListItem> createState() => _CandidateListItemState();
}

class _CandidateListItemState extends State<CandidateListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: ShapeDecoration(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const SizedBox(
                    width: 223,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'PASIA, Juan Dela Cruz',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'UNITE Partylist',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Radio(
              value: true,
              groupValue: widget.isSelected,
              onChanged: (value) {
                widget.onPressed?.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}
