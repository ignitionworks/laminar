Feature: Building a declaration
  Change producing teams need to build a declaration so that they can understand what they need to do to by compliant
  with the organisations policies

  Background:
    Given the following policies exists:
      | Concern           | Route       | Assertion                        |
      | Disaster Recovery | No Risk     | gNo impact on customer           |
      |                   | Some Risk   | gPotential impact is limited     |
      |                   | Crisis Risk | gPotential impact is significant |
    And the following conditions exists:
      | gNo impact on customer ⊕ gPotential impact is limited ⊕ gPotential impact is significant = 1 |
    And the following specialised policies exists:
      | Copy change       | No changes  | tNo copy changes       |
      |                   | Changes     | tCopy changes          |
      | Database change   | No changes  | tNo database migration |
      |                   | Changes     | tDatabase migration    |
    And the following conditions exists:
      | tCopy changes = ¬tNo copy changes                                       |
      | tDatabase migration = ¬tNo database migration                           |
    And the following connectors exist:
#      | tCopy changes & tNo database migration -> gPotential impact is limited = 1 |
      | tNo copy changes & tNo database migration -> gNo impact on customer = 1 |
      | tDatabase migration -> gPotential impact is significant = 1             |

  Feature: Selecting simple specialised assertions
    These assertions do not have any direct link to the Disaster Recovery assertions. This is troublesome as the
    conditions should have no precedence and so why would 'No impact on customer' be inferred
    When the following assertions are declared:
      | tNo copy changes       |
      | tNo database migration |
    Then the following assertions are inferred:
      | gNo impact on customer |

  Feature: Incomplete selection
    Not enough assertions are selected to create a solution
    When the following assertions are declared:
      | Copy changes    |
    Then the following concerns should not be accepted:
      | Database change |

  Feature: Selecting specialised assertions with inference and no ambiguity
    These assertions have a direct link to the Disaster Recovery assertions.
    When the following assertions are declared:
      | Copy changes       |
      | Database migration |
    Then the following assertions are inferred:
      | Potential impact is significant |

  Feature: Selecting specialised assertions with inference potential ambiguity
    These assertions have a direct link to the Disaster Recovery assertions.
    When the following assertions are declared:
      | Copy changes          |
      | No database migration |
    Then the following assertions are inferred:
      | Potential impact is limited |

  Feature: Contradictory selection
    These assertions contradict conditions
    When the following assertions are declared:
      | No copy changes |
      | Copy changes    |
    Then the declaration is invalid with contradiction between:
      | No copy changes |
      | Copy changes    |



  A = ¬B
  C = ¬D
  E = B ∧ D ∨
  1 = E ⊕ F ⊕ G
  G = C




    A = ¬B
    C = ¬D

    E = ¬A ∧ ¬C
    1 = (¬A ∧ ¬C) ⊕ F ⊕ C


    1 = ¬(0 ∨ 0) ⊕ F ⊕ 0  therefore F = 0
    1 = ¬(0 ∨ 1) ⊕ F ⊕ 1  therefore F = 0
    1 = ¬(1 ∨ 0) ⊕ F ⊕ 0  therefore F = 1
    1 = ¬(1 ∨ 1) ⊕ F ⊕ 1  therefore F = 0

    1 = ¬(A ∨ C) ⊕ F ⊕ C
    G = C

  c d s m l

  0 0 1 0 0
  1 0 0 1 0
  0 1 0 0 1
  1 1 0 0 1

  _d -> _l
  c -> m + l
  d -> l