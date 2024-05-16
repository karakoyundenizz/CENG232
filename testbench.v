		`timescale 1ns / 1ps

		module testbench(
			 );
			 reg [1:0] mode; // Modes: 01 for Entrance, 00 for Exit, 10 for Search, 11 for List
			 reg [5:0] userID; // Format: [AreaID(2 bits)][UserID(4 bits)]
			 reg clk;
			 wire [1:0] selectedAreaId; // Shows user-selected area
			 wire [5:0] numberOfInsideUser; // Number of users inside
			 wire [5:0] listOutput; // Lists the IDs of students in the area
			 wire AlreadyInside; // Indicates if a student is inside
			 wire NotInside;  // Indicates if a student is not inside

			integer grade,i, gradeLocal;

			 reg caseFailed;

	 
			 reg [15:0] accum;
			 
			// Instantiate the Unit Under Test (UUT)
			lab4_2 uut(
				mode, 
				userID,
				clk,
				selectedAreaId,
				numberOfInsideUser,
				listOutput,
				AlreadyInside,
				NotInside
			);
		// At 5, 15, 25, .. clk will change 0->1
			// At 10, 20, 30, .. clk will change 1->0
			 initial clk = 0;
			always #2 clk = ~clk;

			 always@(posedge clk) accum = accum + 1;

			initial begin

				  accum = 0;
				  $display("Starting Testbench");


				 /////////////////////////////////////
				 //////// TESTS FOR entrance mode ///////
				 /////////////////////////////////////

				grade=0;
				  caseFailed = 1;

				#1;
				  caseFailed = 0;
				mode=2'b01;
				userID=6'b000001;
				#3;
				  gradeLocal = 0;
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);

				if (selectedAreaId == 2'b00) gradeLocal = gradeLocal+2;            else caseFailed = 1;
				if (numberOfInsideUser == 1) gradeLocal = gradeLocal+2;   else caseFailed = 1;
				  if (AlreadyInside==0) gradeLocal = gradeLocal+1;            else caseFailed = 1;
				if (NotInside==0) gradeLocal = gradeLocal+1;                 else caseFailed = 1;

				  if(caseFailed) begin $display("Failed Case 1"); gradeLocal = gradeLocal >> 2; end
				  grade = grade + gradeLocal;
		 
			
			
			
			
				#1;
				  caseFailed = 0;
				mode=2'b01;
				userID=6'b110010;
			  
				#3; 
				  gradeLocal = 0;
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);
			
				if (selectedAreaId == 2'b11) gradeLocal = gradeLocal+2;            else caseFailed = 1;
				if (numberOfInsideUser == 1) gradeLocal = gradeLocal+1;   else caseFailed = 1;
				  if (AlreadyInside==0) gradeLocal = gradeLocal+1;            else caseFailed = 1;
				if (NotInside==0) gradeLocal = gradeLocal+1;                 else caseFailed = 1;

				  if(caseFailed) begin $display("Failed Case 2"); gradeLocal = gradeLocal >> 2; end
				  grade = grade + gradeLocal;



				#1;
				  caseFailed = 0;
				mode=2'b01;
				userID=6'b000011;
		  
				#3; 
				  gradeLocal = 0;
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);
			
				if (selectedAreaId == 2'b00) gradeLocal = gradeLocal+2;            else caseFailed = 1;
				if (numberOfInsideUser == 2) gradeLocal = gradeLocal+1;   else caseFailed = 1;
				  if (AlreadyInside==0) gradeLocal = gradeLocal+1;            else caseFailed = 1;
				if (NotInside==0) gradeLocal = gradeLocal+1;                 else caseFailed = 1;

				  if(caseFailed) begin $display("Failed Case 3"); gradeLocal = gradeLocal >> 2; end
				  grade = grade + gradeLocal;





				#1;
				  caseFailed = 0;
				mode=2'b01;
				userID=6'b000011;
			 
				#3;  
				  gradeLocal = 0;
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);
			
				if (selectedAreaId == 2'b00) gradeLocal = gradeLocal+2;            else caseFailed = 1;
				if (numberOfInsideUser == 2) gradeLocal = gradeLocal+1;   else caseFailed = 1;
				  if (AlreadyInside==1) gradeLocal = gradeLocal+1;            else caseFailed = 1;
				if (NotInside==0) gradeLocal = gradeLocal+1;                 else caseFailed = 1;

				  if(caseFailed) begin $display("Failed Case 4"); gradeLocal = gradeLocal >> 2; end
				  grade = grade + gradeLocal;


		 


		  
			 
		 
		 
		 // RESERVE THE WHOLE LOUD AREA	
				 for (i=2;i<=16;i=i+1)begin 
					#1;
					// Set the inputs
				//	selectedArea = 0'b00;
							mode=2'b01;
									userID=i;
		  
		  
				#3;  
				end
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);


		  // RESERVE THE WHOLE LOUD AREA	
				 for (i=2;i<=16;i=i+1)begin 
					#1;
					// Set the inputs
				//	selectedArea = 0'b00;
							mode=2'b01;
									userID=i;
		 
		  
				#3;  
				
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);

				end



					/////////////////////////////////////
				 //////// TESTS FOR exit mode ///////
				 /////////////////////////////////////
		 

			
				#1;
				  caseFailed = 0;
				mode=2'b00;
				userID=6'b000001;
				#3;
				  gradeLocal = 0;
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);

				if (selectedAreaId == 2'b00) gradeLocal = gradeLocal+2;            else caseFailed = 1;
				if (numberOfInsideUser == 14) gradeLocal = gradeLocal+2;   else caseFailed = 1;
				  if (AlreadyInside==0) gradeLocal = gradeLocal+1;            else caseFailed = 1;
				if (NotInside==0) gradeLocal = gradeLocal+1;                 else caseFailed = 1;

				  if(caseFailed) begin $display("Failed Case 5"); gradeLocal = gradeLocal >> 2; end
				  grade = grade + gradeLocal;
		  




		 
			
				#1;
				  caseFailed = 0;
				mode=2'b00;
				userID=6'b110101;
				#3;
				  gradeLocal = 0;
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);

				if (selectedAreaId == 2'b11) gradeLocal = gradeLocal+2;            else caseFailed = 1;
				if (numberOfInsideUser == 1) gradeLocal = gradeLocal+2;   else caseFailed = 1;
				  if (AlreadyInside==0) gradeLocal = gradeLocal+1;            else caseFailed = 1;
				if (NotInside==1) gradeLocal = gradeLocal+1;                 else caseFailed = 1;

				  if(caseFailed) begin $display("Failed Case 6"); gradeLocal = gradeLocal >> 2; end
				  grade = grade + gradeLocal;
				  
				  
				  
			
				#1;
				  caseFailed = 0;
				mode=2'b00;
				userID=6'b100101;
				#3;
				  gradeLocal = 0;
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);

				if (selectedAreaId == 2'b10) gradeLocal = gradeLocal+2;            else caseFailed = 1;
				if (numberOfInsideUser == 0) gradeLocal = gradeLocal+2;   else caseFailed = 1;
				  if (AlreadyInside==0) gradeLocal = gradeLocal+1;            else caseFailed = 1;
				if (NotInside==1) gradeLocal = gradeLocal+1;                 else caseFailed = 1;

				  if(caseFailed) begin $display("Failed Case 7"); gradeLocal = gradeLocal >> 2; end
				  grade = grade + gradeLocal;




				/////////////////////////////////////
				 //////// TESTS FOR search mode ///////
				 /////////////////////////////////////
				#1;
				  caseFailed = 0;
				mode=2'b10;
				userID=6'b000001;
				#3;
				  gradeLocal = 0;
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);

			
				  if (AlreadyInside==0) gradeLocal = gradeLocal+1;            else caseFailed = 1;
				if (NotInside==1) gradeLocal = gradeLocal+1;                 else caseFailed = 1;

				  if(caseFailed) begin $display("Failed Case 1"); gradeLocal = gradeLocal >> 2; end
				  grade = grade + gradeLocal; 
				  
		 
		  
				#1;
				  caseFailed = 0;
				mode=2'b10;
				userID=6'b000011;
				#3;
				  gradeLocal = 0;
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);

			
				  if (AlreadyInside==1) gradeLocal = gradeLocal+1;            else caseFailed = 1;
				if (NotInside==0) gradeLocal = gradeLocal+1;                 else caseFailed = 1;

				  if(caseFailed) begin $display("Failed Case 1-*"); gradeLocal = gradeLocal >> 2; end
				  grade = grade + gradeLocal;
		 
		 
				  //***
				  
				  
				  
				  
				  
				  /////////////////////////////////////
				 //////// TESTS FOR exit mode ///////
				 /////////////////////////////////////
		 

				#1;
				  caseFailed = 0;
				mode=2'b00;
				userID=6'b000101;
				#3;
				  gradeLocal = 0;
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);

				if (selectedAreaId == 2'b00) gradeLocal = gradeLocal+2;            else caseFailed = 1;
				if (numberOfInsideUser == 13) gradeLocal = gradeLocal+2;   else caseFailed = 1;
				  if (AlreadyInside==0) gradeLocal = gradeLocal+1;            else caseFailed = 1;
				if (NotInside==0) gradeLocal = gradeLocal+1;                 else caseFailed = 1;

				  if(caseFailed) begin $display("Failed Case 1"); gradeLocal = gradeLocal >> 2; end
				  grade = grade + gradeLocal;


				#1;
				  caseFailed = 0;
				mode=2'b00;
				userID=6'b000111;
				#3;
				  gradeLocal = 0;
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);

				if (selectedAreaId == 2'b00) gradeLocal = gradeLocal+2;            else caseFailed = 1;
				if (numberOfInsideUser == 12) gradeLocal = gradeLocal+2;   else caseFailed = 1;
				  if (AlreadyInside==0) gradeLocal = gradeLocal+1;            else caseFailed = 1;
				if (NotInside==0) gradeLocal = gradeLocal+1;                 else caseFailed = 1;

				  if(caseFailed) begin $display("Failed Case 1"); gradeLocal = gradeLocal >> 2; end
				  grade = grade + gradeLocal;
		  
		  
			#1;
				  caseFailed = 0;
				mode=2'b00;
				userID=6'b001000;
				#3;
				  gradeLocal = 0;
			  $display("Values before checks: mode==%0d, userID ==%0d, selectedAreaId=%0d, numberOfInsideUser=%0d, AlreadyInside=%0d, NotInside=%0d ", mode, userID,  selectedAreaId, numberOfInsideUser, AlreadyInside, NotInside);

				if (selectedAreaId == 2'b00) gradeLocal = gradeLocal+2;            else caseFailed = 1;
				if (numberOfInsideUser == 11) gradeLocal = gradeLocal+2;   else caseFailed = 1;
				  if (AlreadyInside==0) gradeLocal = gradeLocal+1;            else caseFailed = 1;
				if (NotInside==0) gradeLocal = gradeLocal+1;                 else caseFailed = 1;

				  if(caseFailed) begin $display("Failed Case 1dsf"); gradeLocal = gradeLocal >> 2; end
				  grade = grade + gradeLocal;
		 
			
		 
				   
				  
				  
			 /////////////////////////////////////
				 //////// TESTS FOR list mode ///////
				 /////////////////////////////////////
				  
						// Will added later.
		  
		 

				$display("Result %d",grade);
				$finish;

			end

		endmodule