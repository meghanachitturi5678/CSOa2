.global equal_halfsum          #making equal_halfsum global
equal_halfsum:                 #%rdi=n
cmpq $0,%rdi                   #compare n:0
jg .L100                       #if(n>0),jump to loop L100
jmp .L102                      #else jump to L102
 
.L100:                         #loop
cmpq $22,%rdi                  #compare n:22
jle .L101                      #if(n<=20),jump to loop L101
jmp .L102                      #else jump to L102

.L102:                         #loop
                               #%rax=return
movq $-1,%rax                  #return=-1
ret                            #return -1

.L101:                         #loop
                               #%rsi=temp
                               #%r8=top,8(%rsp)=top1,16(%rsp)=top2,24(%rsp)=top3
pushq	%r8                    #push top into stack
subq	$32, %rsp              #decrement %rsp by 32
movq	$13, 8(%rsp)           #top1=13
movq	%rdi, 16(%rsp)         #top2=n
movq	%rsi, 24(%rsp)         #top3=temp
movq	24(%rsp), %rax         #return=top3
cmpq	16(%rsp), %rax         #compare return:top2
jg	.L1                    #if(top2>return),jump to loop L1   
movq	16(%rsp), %rax         #else return=top2
negq	%rax                   #negating top2
cmpq	%rax, 24(%rsp)         #compare top3:return
jge	.L2                    #if(return>=top3),jump to loop L2
jmp .L1                        #else jump to loop L1

.L1:                           #loop
movq	$0, %rax               #return=0
jmp	.L9                    #jump to loop L9

.L2:                           #loop
cmpq	$1, 16(%rsp)           #compare top2:1
jne	.L5                    #if(top2!=1),jump to loop L5
cmpq	$0, 24(%rsp)           #else compare top3:0
je	.L3                    #if(top3==0),jump to loop L3
cmpq	$1, 24(%rsp)           #else compare top3:1
je	.L4                    #if(top3==1),jump to loop L4
cmpq	$-1, 24(%rsp)          #else compare top3:-1
je	.L4                    #if(top3==-1),jump to loop L4
jmp .L5                        #else jump to loop L5

.L3:                           #loop
movq	$2, %rax               #return=2
jmp	.L9                    #jump to loop L9

.L4:                           #loop
movq	$1, %rax               #return =1
jmp	.L9                    #jump to loop L9

.L5:                           #loop
movq 16(%rsp), %rdi            #n=top2
subq $1, %rdi                  #n=n-1
movq 24(%rsp), %rsi            #temp=top3
addq $1, %rsi                  #temp=temp+1
call equal_halfsum             #call equal_halfsum which returns return
movq %rax, %r8                 #top=return
jmp .L6                        #jump to loop L6

.L6:                           #loop
movq 16(%rsp), %rdi            #n=top2
subq $1, %rdi                  #n=n-1
movq 24(%rsp), %rsi            #temp=top3
call equal_halfsum             #call equal_halfsum which returns return
addq %rax, %rax                #return=return+return
addq %rax, %r8                 #top=top+return
jmp .L7                        #jump to loop L7

.L7:                           #loop
movq 16(%rsp), %rdi            #n=top2
subq $1, %rdi                  #n=n-1
movq 24(%rsp), %rsi            #temp=top3
subq $1, %rsi                  #temp=temp-1
call equal_halfsum             #call equal_halfsum which returns return
addq %r8, %rax                 #return=return+top
jmp .L8                        #jump to loop L8

.L8:                           #loop
cqto                           #convert quadword to octword
idivq 8(%rsp)                  #return=return/top1,remainder=%rdx
movq %rdx, %rax                #return=remainder

.L9:
addq  $32, %rsp                #increment %rsp by 32
popq %r8                       #pop top from stack
ret                            #return return
    
