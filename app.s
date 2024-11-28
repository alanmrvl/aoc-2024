.global _start
.text
_start:
    li a7, 64         # syscall number for write
    li a0, 1          # file descriptor (1 = stdout)
    la a1, message    # address of string to print
    li a2, 14         # length of string
    ecall

    li a7, 93         # syscall number for exit
    li a0, 0          # exit status
    ecall

.data
message:
    .string "Hello, RISC-V\n"

