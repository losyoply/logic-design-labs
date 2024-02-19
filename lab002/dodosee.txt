module GCD (
  input wire CLK,
  input wire RST_N,
  input wire [7:0] A,
  input wire [7:0] B,
  input wire START,
  output reg [7:0] Y,
  output reg DONE,
  output reg ERROR
);

wire found, err;
reg [7:0] reg_a, reg_b, next_a, next_b;
reg [7:0] big_one;
reg error_next;
reg [1:0] state, state_next;

parameter [1:0] IDLE = 2'b00;
parameter [1:0] CALC = 2'b01;
parameter [1:0] FINISH = 2'b10;

always@(posedge CLK or negedge RST_N)
  if(!RST_N) state <= IDLE;
  else state <= state_next;

always@(*) begin
  state_next = 2'bx;
  case(state)
    IDLE:if(start)  state_next <= CALC;
         else    state_next <= IDLE;	
    CALC:  if(reg_a!=reg_b) state_next <= CALC;
         else             state_next <= FINISH;
    FINISH:  state_next <= IDLE;
  endcase

//
always@(posedge CLK or negedge RST_N)
     if(!RST_N)begin
		Y   <= 0;
		reg_a <= 0;
		reg_b  <= 0;	
       		 DONE   <= 0;    
      end
     else begin
	    case(state)
        IDLE:begin
            if(start)begin
		       reg_a   <= A;
			 reg_b   <= B;             
             end
             DONE <= 0;
           end
	    CAL:if(reg_a != reg_b)begin
		     if(reg_a >reg_b)begin
			    reg_a <= reg_a-reg_b;
				reg_b <= reg_b;
			 end
			 else begin
			    reg_b <= reg_b-reg_a;
				reg_a <= reg_a;			 
              end
           end		
		FINISH:begin
            Y <= reg_b;
            DONE <= 1;
          end

		default:state_next<= IDLE;
	    endcase
      end	 
end

endmodule
