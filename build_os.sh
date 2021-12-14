mkdir obj
mkdir bin

echo "Compiling kernel..."
i386-elf-gcc -ffreestanding -m32 -g -c "src/kernel.cpp" -o "obj/kernel.o"
echo "Compiled kernel!"

echo "Assembling kernel_entry..."
nasm "src/kernel_entry.asm" -f elf -o "obj/kernel_entry.o"
echo "Assembled kernel_entry!"

echo "Linking full kernel..."
i386-elf-ld -o "bin/full_kernel.bin" -Ttext 0x1000 "obj/kernel_entry.o" "obj/kernel.o" --oformat binary --entry main
echo "Linked full kernel!"

echo "Assembling boot..."
nasm "src/boot.asm" -f bin -o "bin/boot.bin"
echo "Assembled boot!"

echo "Assembling zeros..."
nasm "src/zeros.asm" -f bin -o "bin/zeros.bin"
echo "Assembled zeros!"

echo "Putting everything together..."
cat "bin/boot.bin" "bin/full_kernel.bin" "bin/zeros.bin" > "bin/os.bin"
echo "Building OS finished!"
