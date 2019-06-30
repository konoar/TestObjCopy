############################################
#
# ObjCopy Test
#   copyright 2019.06.25 konoar
#
############################################

SHELL		:= /bin/bash
TARGETBIN	:=./bin/testbin

.PHONY: clean run

run: $(TARGETBIN)
	@-$(TARGETBIN)

clean:
	@-rm $(TARGETBIN) src/data.inc

datas:
	@if [ -d objs ];																	\
	then																				\
		rm -rf objs;																	\
	fi
	@mkdir objs;
	@pushd data;																		\
		for f in $$(ls -1); do															\
			n=$$(echo $${f} | sed "s/\..*//");											\
			objcopy --readonly-text -I binary -O elf64-x86-64 -B i386 $${f} $${n}.o;	\
		done;																			\
	popd
	@mv data/*.o objs;
	@./list.sh > src/data.inc;

objs/main.o: src/main.c
	@gcc -c -o $@ $<

$(TARGETBIN): datas objs/main.o
	@if [ ! -d bin ];																	\
	then																				\
		mkdir bin;																		\
	fi
	@gcc -o $(TARGETBIN) objs/*.o

