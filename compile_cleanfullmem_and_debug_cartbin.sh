#bash
if  dasm cleanfullmem.asm -f3 -v0 -ocart.bin
then
        /Applications/Stella.app/Contents/MacOS/Stella cart.bin #-debug
fi
