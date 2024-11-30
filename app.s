.equ SYSCALL_WRITE, 64
.equ FD_STDOUT, 1
.equ SYSCALL_EXIT, 93
.equ STATUS_SUCCESS, 0

.global _start
.text
_start:
    li a7, SYSCALL_WRITE   # syscall number for write
    li a0, FD_STDOUT       # file descriptor (1 = stdout)
    la a1, message         # address of string to print
    li a2, 14              # length of string
    ecall

    li a7, SYSCALL_EXIT    # syscall number for exit
    li a0, STATUS_SUCCESS  # exit status
    ecall

.data
message: .string "Hello, RISC-V\n"
