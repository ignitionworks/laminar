Feature: Codifying policy
  Codifying policy involves specifying concerns, routes, assertions and any conditions between

  Feature: Warning when assertion only have one valid value
    Given the following policies exists:
      | Concern           | Route       | Assertion                       |
      | Disaster Recovery | No Risk     | No impact on customer           |
      |                   | Some Risk   | Potential impact is limited     |
      |                   | Crisis Risk | Potential impact is significant |
    And the following conditions exists:
      | No impact on customer ⊕ Potential impact is limited ⊕ Potential impact is significant = 1 |
      | No impact on customer = Potential impact is limited                                       |
    When the policy is evaluated
    Then it fails with warnings:
      | No impact on customer can only be 0       |
      | Potential impact is limited can only be 0 |
#  I think this can be solved by looking at the solutions the SAT solver has found and seeing what inputs never change

  Feature: Can see if a set of subset of concerns are ambiguously infer the remaining assertions
    Given the following policies exists:
      | Concern           | Route       | Assertion                       |
      | Disaster Recovery | No Risk     | No impact on customer           |
      |                   | Some Risk   | Potential impact is limited     |
      |                   | Crisis Risk | Potential impact is significant |
    And the following conditions exists:
      | No impact on customer ⊕ Potential impact is limited ⊕ Potential impact is significant = 1 |
    And the following specialised policies exists:
      | Copy change       | No changes  | No copy changes       |
      |                   | Changes     | Copy changes          |
      | Database change   | No changes  | No database migration |
      |                   | Changes     | Database migration    |
    And the following conditions exists:
      | Copy changes = ¬No copy changes                                              |
      | Database migration = ¬No database migration                                  |
      | Copy Changes = Potential impact is limited + Potential impact is significant |
      | Database Migration = Potential impact is significant                         |
    When the following concerns are tested for completeness:
      | Copy change     |
      | Database change |
    Then the following assertions should be marked as ambiguous:
      | Potential impact is limited     |
      | Potential impact is significant |

----
  | Concern           | Route       | Assertion                       |
  | Disaster Recovery | No Risk     | No impact on customer           |
  |                   | Some Risk   | Potential impact is limited     |
  |                   | Crisis Risk | Potential impact is significant |

  1. A + B + C

----

  Copy changes = ¬No copy changes
  Database migration = ¬No database migration

  1. A = ~B
  2. 1 = A ⊕ B
  3. 1 = (~A + ~B) & (A + B)

  1 = (FALSE + ~B) & (TRUE + B)
  1 = ~B

  alternatively, subsitute B as ~A

----

  No impact on customer ⊕ Potential impact is limited ⊕ Potential impact is significant = 1

  1. 1 = A ⊕ B ⊕ C & ~(A & B & C)
  2. 1 = (~A + ~B) & (~A + ~C) & (A + B + C) & (~B + ~C)

----

  No impact on customer = Potential impact is limited

  1. A = B
  2. 1 = (A & B) + (~A & ~B)
  3. 1 = (~A + B) & (A + ^B)

----

  Copy Changes = Potential impact is limited + Potential impact is significant

  1. A = B + C
  2. 1 = (A & B) + (A & C)
  2. 1 = A & (B + C)

----

  Copy changes = ¬No copy changes
  A = ~B
  CNF (~A + ~B) & (A + B)
  DIMAC
  -1 -2 0
  1 2 0

  Database migration = ¬No database migration
  C = ~D
  CNF (~C + ~D) & (C + D)
  DIMAC
  -3 -4 0
  3 4 0

  No impact on customer ⊕ Potential impact is limited ⊕ Potential impact is significant = 1
  E ⊕ F ⊕ G & ~(E & F & G) = 1
  CNF (~E + ~F) & (~E + ~G) & (E + F + G) & (~F + ~G)
  DIMAC


  No impact on customer = Potential impact is limited
  E = F
  CNF (~A + B) & (A + ^B)
  DIMAC
  -1 2 0
  1 -2 0

  Copy Changes = Potential impact is limited + Potential impact is significant
  A = F + G
  CNF A & (F + G)
  DIMAC
  1 0
  6 7 0

----

  c complete dimac problem
  p cnf 7 12
  -1 -2 0
  1 2 0
  -3 -4 0
  3 4 0
  -5 -6 7 0
  -5 6 -7 0
  5 -6 -7 0
  5 6 7 0
  -1 2 0
  1 -2 0
  1 0
  6 7 0