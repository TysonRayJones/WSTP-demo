
# convert templates to C
WSTP/wsprep Package/my_templates.tm -o Package/my_templates.tm.c

# compile C source
gcc -IWSTP -IPackage -c Package/my_backend.c
gcc -IWSTP -IPackage -c Package/my_templates.tm.c

# link with WSTP, to create my_exec (MacOS args)
gcc -o my_exec my_backend.o my_templates.tm.o -lm -lc++ WSTP/libWSTPi4.36.a -framework Foundation

# tidy up
rm *.o
rm Package/my_templates.tm.c