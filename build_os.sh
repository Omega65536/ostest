rm -d -f -r obj
rm -d -f -r bin
mkdir obj
mkdir bin

echo "\033[1;37mCompiling kernel.cpp"
i386-elf-gcc -ffreestanding -m32 -g -c "src/kernel.cpp" -o "obj/kernel.o"
echo "\033[1;32mCompiled kernel   "
echo

echo "\033[1;37mAssembling kernel_entry"
nasm "src/kernel_entry.asm" -f elf -o "obj/kernel_entry.o"
echo "\033[1;32mAssembled kernel_entry"
echo

echo "\033[1;37mLinking full kernel"
i386-elf-ld -o "bin/full_kernel.bin" -Ttext 0x1000 "obj/kernel_entry.o" "obj/kernel.o" --oformat binary --entry main
echo "\033[1;32mLinked full kernel"
echo

echo "\033[1;37mAssembling boot.asm"
nasm "src/boot.asm" -f bin -o "bin/boot.bin"
echo "\033[1;32mAssembled boot.asm"
echo

echo "\033[1;37mAssembling zeros.asm"
nasm "src/zeros.asm" -f bin -o "bin/zeros.bin"
echo "\033[1;32mAssembled zeros.asm"
echo

echo "\033[1;37mPutting everything together"
cat "bin/boot.bin" "bin/full_kernel.bin" "bin/zeros.bin" > "bin/os.bin"
echo "\033[1;32mFinished building OS"
