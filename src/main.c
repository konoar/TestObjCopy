/********************************************************

   main.c
     copyright 2019.06.25 Konoar
 
 ********************************************************/
#include <unistd.h>

#define KSDATA(_a_,_b_,_c_) extern char _binary_##_a_##_start[];
#include "data.inc"
#undef  KSDATA

enum ksData
{
#define KSDATA(_a_,_b_,_c_) KSDATA_##_a_,
#include "data.inc"
#undef  KSDATA
	KSDATA_MAX
};

const char *ksDataName[KSDATA_MAX] =
{
#define KSDATA(_a_,_b_,_c_) _c_,
#include "data.inc"
#undef  KSDATA
};

const int ksDataSize[KSDATA_MAX] =
{
#define KSDATA(_a_,_b_,_c_) _b_,
#include "data.inc"
#undef  KSDATA
};

char *ksDataBin[KSDATA_MAX] =
{
#define KSDATA(_a_,_b_,_c_) _binary_##_a_##_start,
#include "data.inc"
#undef  KSDATA
};

#define KSPRINT(_name_)					\
	write(1, 							\
		ksDataBin [KSDATA_##_name_],	\
		ksDataSize[KSDATA_##_name_])

int main(int argc, const char* argv[])
{

	KSPRINT(index1_html);
	KSPRINT(index2_html);
	return 0;

}

