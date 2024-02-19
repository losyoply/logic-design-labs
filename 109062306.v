module Comparator_4bits (A, B, A_lt_B, A_gt_B, A_eq_B);
// declare input signals
input [4-1:0] A;
input [4-1:0] B;

// declare output signals
output A_lt_B, A_gt_B, A_eq_B;

// here is your design
 wire e0, e1, e2, e3, Al0, Al1, Al2, Al3, B10, Bl1, Bl2, Bl3, E1, E2, ALA1, ALA2, ALA3, BLN1, BLN2;
Compare1 cp0(A[0], B[0], e0, Al0, Bl0);
Compare1 cp1(A[1], B[1], e1, Al1, Bl1);
Compare1 cp2(A[2], B[2], e2, Al2, Bl2);
Compare1 cp3(A[3], B[3], e3, Al3, Bl3);
//EQUAL
and and1( A_eq_B, e0, e1,e2,e3 );
//ALARGER
and and2( ALA1, Al2, e3 );
and and3( ALA2, e2, e3,Al1 );
and and4( ALA3, e2, e1,e3,Al0 );
or or5(A_gt_B, Al3, ALA1,ALA2, ALA3);
//BLARGER
not not6(BLN1, A_gt_B);
not not7(BLN2, A_eq_B);
and and8( A_lt_B, BLN1, BLN2 );
endmodule

module Compare1 (A, B, Equal, Alarger, Blarger);
input A, B;
output Equal, Alarger, Blarger;
 wire EA1, EN1, EN2 ,EA2, AN1, BN1;
//EQ
and and9(EA1, A, B);
not not10(EN1, A);
not not11(EN2, B);
and and12(EA2, EN1, EN2);
or or13(Equal, EA1, EA2);
//AL
not not14(AN1, B);
and and15(Alarger, A, AN1);
//BL
not not16(BN1, A);
and and17(Blarger, BN1, B);
endmodule




