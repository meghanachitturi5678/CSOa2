.global next_greater          #making next_greater global
next_greater:                 #%r8=temp1,%rdi=*A,%rsi=*B
                              #%rdx=n,%rsp=stack pointer,%r9=empty stack pointer
movq %rdx,%r8                 #temp2=n
movq %rsp,%r9                 #move stack pointer to base pointer
decq %r8                      #temp1=temp1-1
movq $-1,(%rsi,%r8,8)         #B[temp1]=-1
pushq (%rdi,%r8,8)            #push A[temp1] into stack
decq %r8                      #temp1=temp1-1
cmpq $0,%r8                   #compare temp1:0
jge .L1                       #if (temp1>=0),jump to loop L1
jmp .L7                       #else jump to L7

.L1:                          #loop
cmpq %rsp,%r9                 #compare base pointer and stack pointer
je .L2                        #if they are equal,jump to loop L2
jmp .L3                       #else jump to loop L3

.L2:                          #loop
movq $-1,(%rsi,%r8,8)         #B[temp1]=-1
pushq (%rdi,%r8,8)            #push A[temp1] into stack
decq %r8                      #temp1=temp1-1
cmpq $0,%r8                   #compare temp1:0
jge .L1                       #if(temp1>=0),jump to loop L1
jmp .L6                       #else jump to loop L7

.L3:                          #loop
                              #%r10=temp2
movq (%rsp),%r10              #temp2=top of stack
cmpq %r10,(%rdi,%r8,8)        #compare A[temp1]:top
jl .L4                        #if(A[temp1]<top),jump to loop L4
jmp .L5                       #else jump to loop L5

.L4:                          #loop
movq %r10,(%rsi,%r8,8)        #B[temp1]=temp2
pushq (%rdi,%r8,8)            #push A[temp1] into stack
decq %r8                      #temp1=temp1-1
cmpq $0,%r8                   #compare temp1:0
jge .L1                       #if(temp2>=0),jump to loop L1
jmp .L6                       #else jump to loop L7

.L5:                          #loop
                              #%r11=temp3
popq %r11                     #pop from stack
jmp .L1                       #jump to loop L1

.L6:                          #loop
cmpq %rsp,%r9                 #compare base pointer and stack pointer
jne .L7                       #if they are not equal,jump to loop L7

.L7:                          #loop
popq %r11                     #pop from stack
cmpq %rsp,%r9                 #compare base pointer and stack pointer
jne .L7                       #if they are not equal,jump to loop L7

