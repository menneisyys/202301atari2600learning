#bash
if  dasm cleanfullmem.asm -f3 -v0 -ocart.bin
then
        /Applications/Stella.app/Contents/MacOS/Stella -debug cart.bin 
fi
