rm -d -f -r obj
rm -d -f -r bin
mkdir obj
mkdir bin

echo "Compiling kernel.cpp"
i386-elf-gcc -ffreestanding -m32 -g -c "src/kernel.cpp" -o "obj/kernel.o"
echo "Compiled kernel   "
echo

echo "Assembling kernel_entry"
nasm "src/kernel_entry.asm" -f elf -o "obj/kernel_entry.o"
echo "Assembled kernel_entry"
echo

echo "Linking full kernel"
i386-elf-ld -o "bin/full_kernel.bin" -Ttext 0x1000 "obj/kernel_entry.o" "obj/kernel.o" --oformat binary --entry main
echo "Linked full kernel"
echo

echo "Assembling boot.asm"
nasm "src/boot.asm" -f bin -o "bin/boot.bin"
echo "Assembled boot.asm"
echo

echo "Assembling zeros.asm"
nasm "src/zeros.asm" -f bin -o "bin/zeros.bin"
echo "Assembled zeros.asm"
echo

echo "Putting everything together"
cat "bin/boot.bin" "bin/full_kernel.bin" "bin/zeros.bin" > "bin/os.bin"
echo "Finished building OS"
