.data
    playerChoice: .asciiz "Your choice (0=Rock, 1=Paper, 2=Scissors): "
    computerChoice: .asciiz "Computer's choice: "
    result: .asciiz "You %s\n"

.text
.globl main
main:
    # Display prompt for player's choice
    li $v0, 4
    la $a0, playerChoice
    syscall
    
    # Read player's choice
    li $v0, 5
    syscall
    move $t0, $v0  # Save player's choice
    
    # Generate random computer choice (0=Rock, 1=Paper, 2=Scissors)
    li $t1, 3       # Number of choices
    li $v0, 42      # System call code for random number
    syscall
    move $t2, $v0   # Save random number (0, 1, or 2)
    
    # Display computer's choice
    li $v0, 4
    la $a0, computerChoice
    syscall
    
    # Display the player's and computer's choices
    move $a0, $t0
    li $v0, 1
    syscall
    
    move $a0, $t2
    li $v0, 1
    syscall
    
    # Determine the winner
    beq $t0, $t2, tie    # If choices are the same, it's a tie
    
    # Player chooses Rock
    beq $t0, 0, check_paper
    # Player chooses Paper
    beq $t0, 1, check_scissors
    # Player chooses Scissors
    beq $t0, 2, check_rock
    
check_paper:
    beq $t2, 0, win
    j lose

check_scissors:
    beq $t2, 1, win
    j lose

check_rock:
    beq $t2, 2, win
    j lose

win:
    # Display win message
    la $a0, result
    li $v0, 4
    la $t3, "win!\n"
    move $a1, $t3
    syscall
    j exit

lose:
    # Display lose message
    la $a0, result
    li $v0, 4
    la $t3, "lose!\n"
    move $a1, $t3
    syscall
    j exit

tie:
    # Display tie message
    la $a0, result
    li $v0, 4
    la $t3, "tie!\n"
    move $a1, $t3
    syscall

exit:
    # Exit the program
    li $v0, 10
    syscall

