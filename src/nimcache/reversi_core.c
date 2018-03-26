/* Generated by Nim Compiler v0.18.0 */
/*   (c) 2018 Andreas Rumpf */
/* The generated code is subject to the original license. */
/* Compiled for: MacOSX, amd64, clang */
/* Command for C compiler:
   clang -c  -w  -I/Users/kaneko_takayuki/.choosenim/toolchains/nim-0.18.0/lib -o /Users/kaneko_takayuki/MyProgram/ReversiAI/src/nimcache/reversi_core.o /Users/kaneko_takayuki/MyProgram/ReversiAI/src/nimcache/reversi_core.c */
#define NIM_NEW_MANGLING_RULES
#define NIM_INTBITS 64

#include "nimbase.h"
#include <string.h>
#undef LANGUAGE_C
#undef MIPSEB
#undef MIPSEL
#undef PPC
#undef R3000
#undef R4000
#undef i386
#undef linux
#undef mips
#undef near
#undef powerpc
#undef unix
typedef struct tyTuple_GviMuKbe9c3Hsi9c4x4m9avrw tyTuple_GviMuKbe9c3Hsi9c4x4m9avrw;
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
struct tyTuple_GviMuKbe9c3Hsi9c4x4m9avrw {
NU64 Field0;
NU64 Field1;
};
struct TGenericSeq {
NI len;
NI reserved;
};
struct NimStringDesc {
  TGenericSeq Sup;
NIM_CHAR data[SEQ_DECL_SIZE];
};
typedef NimStringDesc* tyArray_nHXaesL0DJZHyVS07ARPRA[1];
N_LIB_PRIVATE N_NIMCALL(tyTuple_GviMuKbe9c3Hsi9c4x4m9avrw, init_board_GgkmOoopef2yi9byyRuy8XQ)(void);
static N_INLINE(void, nimFrame)(TFrame* s);
N_LIB_PRIVATE N_NOINLINE(void, stackOverflow_II46IjNZztN9bmbxUD8dt8g)(void);
static N_INLINE(void, popFrame)(void);
N_LIB_PRIVATE N_NIMCALL(NI, count_sWuXysMKxSvco7W0Yl9cUNw)(NU64 x);
N_LIB_PRIVATE N_NIMCALL(NU64, getPutBoard_FGEvbm3TxX9aBkFl77i7oKw)(NU64 me, NU64 op);
static N_INLINE(NI, addInt)(NI a, NI b);
N_NOINLINE(void, raiseOverflow)(void);
N_LIB_PRIVATE N_NIMCALL(NU64, getRevBoard_aAAC5Qi6feABFGOdegNgSw)(NU64 me, NU64 op, NU64 pos);
N_NIMCALL(NI, mulInt)(NI a, NI b);
N_LIB_PRIVATE N_NIMCALL(NimStringDesc*, dollar__rzAI8EMyNBAQwGODeohhAA)(NU64 x);
N_NIMCALL(void, echoBinSafe)(NimStringDesc** args, NI argsLen_0);
N_LIB_PRIVATE N_NIMCALL(tyTuple_GviMuKbe9c3Hsi9c4x4m9avrw, putStone_EFEi9aXdSta3HpRe4e2W67A)(NU64 black, NU64 white, NI pos_n, NIM_BOOL blackTurn);
extern TFrame* framePtr_HRfVMH3jYeBJz6Q6X9b6Ptw;
NIM_CONST tyTuple_GviMuKbe9c3Hsi9c4x4m9avrw init_board_VCKjuP4hnZg5bInuskklTw = {34628173824ULL,
68853694464ULL}
;
NIM_CONST tyTuple_GviMuKbe9c3Hsi9c4x4m9avrw TM_JSFJweKilXamd1oWnkcddg_2 = {34628173824ULL,
68853694464ULL}
;

static N_INLINE(void, nimFrame)(TFrame* s) {
	NI T1_;
	T1_ = (NI)0;
	{
		if (!(framePtr_HRfVMH3jYeBJz6Q6X9b6Ptw == NIM_NIL)) goto LA4_;
		T1_ = ((NI) 0);
	}
	goto LA2_;
	LA4_: ;
	{
		T1_ = ((NI) ((NI16)((*framePtr_HRfVMH3jYeBJz6Q6X9b6Ptw).calldepth + ((NI16) 1))));
	}
	LA2_: ;
	(*s).calldepth = ((NI16) (T1_));
	(*s).prev = framePtr_HRfVMH3jYeBJz6Q6X9b6Ptw;
	framePtr_HRfVMH3jYeBJz6Q6X9b6Ptw = s;
	{
		if (!((*s).calldepth == ((NI16) 2000))) goto LA9_;
		stackOverflow_II46IjNZztN9bmbxUD8dt8g();
	}
	LA9_: ;
}

static N_INLINE(void, popFrame)(void) {
	framePtr_HRfVMH3jYeBJz6Q6X9b6Ptw = (*framePtr_HRfVMH3jYeBJz6Q6X9b6Ptw).prev;
}

N_LIB_PRIVATE N_NIMCALL(tyTuple_GviMuKbe9c3Hsi9c4x4m9avrw, init_board_GgkmOoopef2yi9byyRuy8XQ)(void) {
	tyTuple_GviMuKbe9c3Hsi9c4x4m9avrw result;
	nimfr_("init_board", "reversi_core.nim");
	memset((void*)(&result), 0, sizeof(result));
	nimln_(6, "reversi_core.nim");
	result = TM_JSFJweKilXamd1oWnkcddg_2;
	popFrame();
	return result;
}

N_LIB_PRIVATE N_NIMCALL(NI, count_sWuXysMKxSvco7W0Yl9cUNw)(NU64 x) {
	NI result;
	NU64 t;
	nimfr_("count", "reversi_core.nim");
	result = (NI)0;
	nimln_(15, "reversi_core.nim");
	t = (NU64)((NU64)((NU64)(x & 6148914691236517205ULL)) + (NU64)((NU64)((NU64)((NU64)(x) >> (NU64)(((NI) 1))) & 6148914691236517205ULL)));
	nimln_(16, "reversi_core.nim");
	t = (NU64)((NU64)((NU64)(t & 3689348814741910323ULL)) + (NU64)((NU64)((NU64)((NU64)(t) >> (NU64)(((NI) 2))) & 3689348814741910323ULL)));
	nimln_(17, "reversi_core.nim");
	t = (NU64)((NU64)((NU64)(t & 1085102592571150095ULL)) + (NU64)((NU64)((NU64)((NU64)(t) >> (NU64)(((NI) 4))) & 1085102592571150095ULL)));
	nimln_(18, "reversi_core.nim");
	t = (NU64)((NU64)((NU64)(t & 71777214294589695ULL)) + (NU64)((NU64)((NU64)((NU64)(t) >> (NU64)(((NI) 8))) & 71777214294589695ULL)));
	nimln_(19, "reversi_core.nim");
	t = (NU64)((NU64)((NU64)(t & 281470681808895ULL)) + (NU64)((NU64)((NU64)((NU64)(t) >> (NU64)(((NI) 16))) & 281470681808895ULL)));
	nimln_(20, "reversi_core.nim");
	t = (NU64)((NU64)((NU64)(t & 4294967295ULL)) + (NU64)((NU64)((NU64)((NU64)(t) >> (NU64)(((NI) 32))) & 4294967295ULL)));
	nimln_(21, "reversi_core.nim");
	result = ((NI) (t));
	popFrame();
	return result;
}

static N_INLINE(NI, addInt)(NI a, NI b) {
	NI result;
{	result = (NI)0;
	result = (NI)((NU64)(a) + (NU64)(b));
	{
		NIM_BOOL T3_;
		T3_ = (NIM_BOOL)0;
		T3_ = (((NI) 0) <= (NI)(result ^ a));
		if (T3_) goto LA4_;
		T3_ = (((NI) 0) <= (NI)(result ^ b));
		LA4_: ;
		if (!T3_) goto LA5_;
		goto BeforeRet_;
	}
	LA5_: ;
	raiseOverflow();
	}BeforeRet_: ;
	return result;
}

N_LIB_PRIVATE N_NIMCALL(NU64, getPutBoard_FGEvbm3TxX9aBkFl77i7oKw)(NU64 me, NU64 op) {
	NU64 result;
	NU64 blank;
	NU64 masked_op;
	NU64 tmp;
	nimfr_("getPutBoard", "reversi_core.nim");
	result = (NU64)0;
	nimln_(31, "reversi_core.nim");
	result = 0ULL;
	nimln_(32, "reversi_core.nim");
	blank = (NU64)((NU64) ~((NU64)(me | op)));
	masked_op = (NU64)0;
	tmp = (NU64)0;
	nimln_(36, "reversi_core.nim");
	masked_op = (NU64)(op & 9114861777597660798ULL);
	nimln_(38, "reversi_core.nim");
	tmp = (NU64)(masked_op & (NU64)((NU64)(me) << (NU64)(((NI) 1))));
	{
		NI _;
		NI i;
		_ = (NI)0;
		nimln_(3519, "system.nim");
		i = ((NI) 0);
		{
			nimln_(3520, "system.nim");
			while (1) {
				NI TM_JSFJweKilXamd1oWnkcddg_3;
				if (!(i < ((NI) 5))) goto LA3;
				nimln_(3521, "system.nim");
				_ = i;
				nimln_(40, "reversi_core.nim");
				tmp = (NU64)(tmp | (NU64)(masked_op & (NU64)((NU64)(tmp) << (NU64)(((NI) 1)))));
				nimln_(3522, "system.nim");
				TM_JSFJweKilXamd1oWnkcddg_3 = addInt(i, ((NI) 1));
				i = (NI)(TM_JSFJweKilXamd1oWnkcddg_3);
			} LA3: ;
		}
	}
	nimln_(41, "reversi_core.nim");
	result = (NU64)(result | (NU64)(blank & (NU64)((NU64)(tmp) << (NU64)(((NI) 1)))));
	nimln_(44, "reversi_core.nim");
	tmp = (NU64)(masked_op & (NU64)((NU64)(me) >> (NU64)(((NI) 1))));
	{
		NI __2;
		NI i_2;
		__2 = (NI)0;
		nimln_(3519, "system.nim");
		i_2 = ((NI) 0);
		{
			nimln_(3520, "system.nim");
			while (1) {
				NI TM_JSFJweKilXamd1oWnkcddg_4;
				if (!(i_2 < ((NI) 5))) goto LA6;
				nimln_(3521, "system.nim");
				__2 = i_2;
				nimln_(46, "reversi_core.nim");
				tmp = (NU64)(tmp | (NU64)(masked_op & (NU64)((NU64)(tmp) >> (NU64)(((NI) 1)))));
				nimln_(3522, "system.nim");
				TM_JSFJweKilXamd1oWnkcddg_4 = addInt(i_2, ((NI) 1));
				i_2 = (NI)(TM_JSFJweKilXamd1oWnkcddg_4);
			} LA6: ;
		}
	}
	nimln_(47, "reversi_core.nim");
	result = (NU64)(result | (NU64)(blank & (NU64)((NU64)(tmp) >> (NU64)(((NI) 1)))));
	nimln_(50, "reversi_core.nim");
	masked_op = (NU64)(op & 9114861777597660798ULL);
	nimln_(52, "reversi_core.nim");
	tmp = (NU64)(masked_op & (NU64)((NU64)(me) << (NU64)(((NI) 8))));
	{
		NI __3;
		NI i_3;
		__3 = (NI)0;
		nimln_(3519, "system.nim");
		i_3 = ((NI) 0);
		{
			nimln_(3520, "system.nim");
			while (1) {
				NI TM_JSFJweKilXamd1oWnkcddg_5;
				if (!(i_3 < ((NI) 5))) goto LA9;
				nimln_(3521, "system.nim");
				__3 = i_3;
				nimln_(54, "reversi_core.nim");
				tmp = (NU64)(tmp | (NU64)(masked_op & (NU64)((NU64)(tmp) << (NU64)(((NI) 8)))));
				nimln_(3522, "system.nim");
				TM_JSFJweKilXamd1oWnkcddg_5 = addInt(i_3, ((NI) 1));
				i_3 = (NI)(TM_JSFJweKilXamd1oWnkcddg_5);
			} LA9: ;
		}
	}
	nimln_(55, "reversi_core.nim");
	result = (NU64)(result | (NU64)(blank & (NU64)((NU64)(tmp) << (NU64)(((NI) 8)))));
	nimln_(58, "reversi_core.nim");
	tmp = (NU64)(masked_op & (NU64)((NU64)(me) >> (NU64)(((NI) 8))));
	{
		NI __4;
		NI i_4;
		__4 = (NI)0;
		nimln_(3519, "system.nim");
		i_4 = ((NI) 0);
		{
			nimln_(3520, "system.nim");
			while (1) {
				NI TM_JSFJweKilXamd1oWnkcddg_6;
				if (!(i_4 < ((NI) 5))) goto LA12;
				nimln_(3521, "system.nim");
				__4 = i_4;
				nimln_(60, "reversi_core.nim");
				tmp = (NU64)(tmp | (NU64)(masked_op & (NU64)((NU64)(tmp) >> (NU64)(((NI) 8)))));
				nimln_(3522, "system.nim");
				TM_JSFJweKilXamd1oWnkcddg_6 = addInt(i_4, ((NI) 1));
				i_4 = (NI)(TM_JSFJweKilXamd1oWnkcddg_6);
			} LA12: ;
		}
	}
	nimln_(61, "reversi_core.nim");
	result = (NU64)(result | (NU64)(blank & (NU64)((NU64)(tmp) >> (NU64)(((NI) 8)))));
	nimln_(64, "reversi_core.nim");
	masked_op = (NU64)(op & 35604928818740736ULL);
	nimln_(66, "reversi_core.nim");
	tmp = (NU64)(masked_op & (NU64)((NU64)(me) << (NU64)(((NI) 7))));
	{
		NI __5;
		NI i_5;
		__5 = (NI)0;
		nimln_(3519, "system.nim");
		i_5 = ((NI) 0);
		{
			nimln_(3520, "system.nim");
			while (1) {
				NI TM_JSFJweKilXamd1oWnkcddg_7;
				if (!(i_5 < ((NI) 5))) goto LA15;
				nimln_(3521, "system.nim");
				__5 = i_5;
				nimln_(68, "reversi_core.nim");
				tmp = (NU64)(tmp | (NU64)(masked_op & (NU64)((NU64)(tmp) << (NU64)(((NI) 7)))));
				nimln_(3522, "system.nim");
				TM_JSFJweKilXamd1oWnkcddg_7 = addInt(i_5, ((NI) 1));
				i_5 = (NI)(TM_JSFJweKilXamd1oWnkcddg_7);
			} LA15: ;
		}
	}
	nimln_(69, "reversi_core.nim");
	result = (NU64)(result | (NU64)(blank & (NU64)((NU64)(tmp) << (NU64)(((NI) 7)))));
	nimln_(72, "reversi_core.nim");
	tmp = (NU64)(masked_op & (NU64)((NU64)(me) << (NU64)(((NI) 9))));
	{
		NI __6;
		NI i_6;
		__6 = (NI)0;
		nimln_(3519, "system.nim");
		i_6 = ((NI) 0);
		{
			nimln_(3520, "system.nim");
			while (1) {
				NI TM_JSFJweKilXamd1oWnkcddg_8;
				if (!(i_6 < ((NI) 5))) goto LA18;
				nimln_(3521, "system.nim");
				__6 = i_6;
				nimln_(74, "reversi_core.nim");
				tmp = (NU64)(tmp | (NU64)(masked_op & (NU64)((NU64)(tmp) << (NU64)(((NI) 9)))));
				nimln_(3522, "system.nim");
				TM_JSFJweKilXamd1oWnkcddg_8 = addInt(i_6, ((NI) 1));
				i_6 = (NI)(TM_JSFJweKilXamd1oWnkcddg_8);
			} LA18: ;
		}
	}
	nimln_(75, "reversi_core.nim");
	result = (NU64)(result | (NU64)(blank & (NU64)((NU64)(tmp) << (NU64)(((NI) 9)))));
	nimln_(78, "reversi_core.nim");
	tmp = (NU64)(masked_op & (NU64)((NU64)(me) >> (NU64)(((NI) 9))));
	{
		NI __7;
		NI i_7;
		__7 = (NI)0;
		nimln_(3519, "system.nim");
		i_7 = ((NI) 0);
		{
			nimln_(3520, "system.nim");
			while (1) {
				NI TM_JSFJweKilXamd1oWnkcddg_9;
				if (!(i_7 < ((NI) 5))) goto LA21;
				nimln_(3521, "system.nim");
				__7 = i_7;
				nimln_(80, "reversi_core.nim");
				tmp = (NU64)(tmp | (NU64)(masked_op & (NU64)((NU64)(tmp) >> (NU64)(((NI) 9)))));
				nimln_(3522, "system.nim");
				TM_JSFJweKilXamd1oWnkcddg_9 = addInt(i_7, ((NI) 1));
				i_7 = (NI)(TM_JSFJweKilXamd1oWnkcddg_9);
			} LA21: ;
		}
	}
	nimln_(81, "reversi_core.nim");
	result = (NU64)(result | (NU64)(blank & (NU64)((NU64)(tmp) >> (NU64)(((NI) 9)))));
	nimln_(84, "reversi_core.nim");
	tmp = (NU64)(masked_op & (NU64)((NU64)(me) >> (NU64)(((NI) 7))));
	{
		NI __8;
		NI i_8;
		__8 = (NI)0;
		nimln_(3519, "system.nim");
		i_8 = ((NI) 0);
		{
			nimln_(3520, "system.nim");
			while (1) {
				NI TM_JSFJweKilXamd1oWnkcddg_10;
				if (!(i_8 < ((NI) 5))) goto LA24;
				nimln_(3521, "system.nim");
				__8 = i_8;
				nimln_(86, "reversi_core.nim");
				tmp = (NU64)(tmp | (NU64)(masked_op & (NU64)((NU64)(tmp) >> (NU64)(((NI) 7)))));
				nimln_(3522, "system.nim");
				TM_JSFJweKilXamd1oWnkcddg_10 = addInt(i_8, ((NI) 1));
				i_8 = (NI)(TM_JSFJweKilXamd1oWnkcddg_10);
			} LA24: ;
		}
	}
	nimln_(87, "reversi_core.nim");
	result = (NU64)(result | (NU64)(blank & (NU64)((NU64)(tmp) >> (NU64)(((NI) 7)))));
	popFrame();
	return result;
}

N_LIB_PRIVATE N_NIMCALL(NU64, getRevBoard_aAAC5Qi6feABFGOdegNgSw)(NU64 me, NU64 op, NU64 pos) {
	NU64 result;
	NU64 blank;
	NI i;
	NU64 masked_op;
	NU64 rev_cand;
	nimfr_("getRevBoard", "reversi_core.nim");
	result = (NU64)0;
	nimln_(96, "reversi_core.nim");
	result = 0ULL;
	nimln_(97, "reversi_core.nim");
	blank = (NU64)((NU64) ~((NU64)(me | op)));
	i = (NI)0;
	masked_op = (NU64)0;
	rev_cand = (NU64)0;
	nimln_(103, "reversi_core.nim");
	masked_op = (NU64)(op & 9114861777597660798ULL);
	nimln_(105, "reversi_core.nim");
	i = ((NI) 1);
	nimln_(106, "reversi_core.nim");
	rev_cand = 0ULL;
	{
		nimln_(107, "reversi_core.nim");
		while (1) {
			NI TM_JSFJweKilXamd1oWnkcddg_11;
			nimln_(398, "system.nim");
			nimln_(107, "reversi_core.nim");
			if (!!(((NU64)((NU64)((NU64)(pos) << (NU64)(i)) & masked_op) == ((NI) 0)))) goto LA2;
			nimln_(108, "reversi_core.nim");
			rev_cand = (NU64)(rev_cand | (NU64)((NU64)(pos) << (NU64)(i)));
			nimln_(109, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_11 = addInt(i, ((NI) 1));
			i = (NI)(TM_JSFJweKilXamd1oWnkcddg_11);
		} LA2: ;
	}
	nimln_(110, "reversi_core.nim");
	{
		nimln_(398, "system.nim");
		nimln_(110, "reversi_core.nim");
		if (!!(((NU64)((NU64)((NU64)(pos) << (NU64)(i)) & me) == ((NI) 0)))) goto LA5_;
		nimln_(111, "reversi_core.nim");
		result = (NU64)(result | rev_cand);
	}
	LA5_: ;
	nimln_(114, "reversi_core.nim");
	i = ((NI) 1);
	nimln_(115, "reversi_core.nim");
	rev_cand = 0ULL;
	{
		nimln_(116, "reversi_core.nim");
		while (1) {
			NI TM_JSFJweKilXamd1oWnkcddg_12;
			nimln_(398, "system.nim");
			nimln_(116, "reversi_core.nim");
			if (!!(((NU64)((NU64)((NU64)(pos) >> (NU64)(i)) & masked_op) == ((NI) 0)))) goto LA8;
			nimln_(117, "reversi_core.nim");
			rev_cand = (NU64)(rev_cand | (NU64)((NU64)(pos) >> (NU64)(i)));
			nimln_(118, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_12 = addInt(i, ((NI) 1));
			i = (NI)(TM_JSFJweKilXamd1oWnkcddg_12);
		} LA8: ;
	}
	nimln_(119, "reversi_core.nim");
	{
		nimln_(398, "system.nim");
		nimln_(119, "reversi_core.nim");
		if (!!(((NU64)((NU64)((NU64)(pos) >> (NU64)(i)) & me) == ((NI) 0)))) goto LA11_;
		nimln_(120, "reversi_core.nim");
		result = (NU64)(result | rev_cand);
	}
	LA11_: ;
	nimln_(123, "reversi_core.nim");
	masked_op = (NU64)(op & 72057594037927680ULL);
	nimln_(125, "reversi_core.nim");
	i = ((NI) 1);
	nimln_(126, "reversi_core.nim");
	rev_cand = 0ULL;
	{
		nimln_(127, "reversi_core.nim");
		while (1) {
			NI TM_JSFJweKilXamd1oWnkcddg_13;
			tyArray_nHXaesL0DJZHyVS07ARPRA T15_;
			NI TM_JSFJweKilXamd1oWnkcddg_14;
			NI TM_JSFJweKilXamd1oWnkcddg_15;
			NI TM_JSFJweKilXamd1oWnkcddg_16;
			nimln_(398, "system.nim");
			nimln_(127, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_13 = mulInt(i, ((NI) 8));
			if (!!(((NU64)((NU64)((NU64)(pos) >> (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_13))) & masked_op) == ((NI) 0)))) goto LA14;
			nimln_(128, "reversi_core.nim");
			memset((void*)T15_, 0, sizeof(T15_));
			TM_JSFJweKilXamd1oWnkcddg_14 = mulInt(i, ((NI) 8));
			T15_[0] = dollar__rzAI8EMyNBAQwGODeohhAA((NU64)((NU64)((NU64)(pos) >> (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_14))) & masked_op));
			echoBinSafe(T15_, 1);
			nimln_(129, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_15 = mulInt(i, ((NI) 8));
			rev_cand = (NU64)(rev_cand | (NU64)((NU64)(pos) >> (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_15))));
			nimln_(130, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_16 = addInt(i, ((NI) 1));
			i = (NI)(TM_JSFJweKilXamd1oWnkcddg_16);
		} LA14: ;
	}
	nimln_(131, "reversi_core.nim");
	{
		NI TM_JSFJweKilXamd1oWnkcddg_17;
		nimln_(398, "system.nim");
		nimln_(131, "reversi_core.nim");
		TM_JSFJweKilXamd1oWnkcddg_17 = mulInt(i, ((NI) 8));
		if (!!(((NU64)((NU64)((NU64)(pos) >> (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_17))) & me) == ((NI) 0)))) goto LA18_;
		nimln_(132, "reversi_core.nim");
		result = (NU64)(result | rev_cand);
	}
	LA18_: ;
	nimln_(135, "reversi_core.nim");
	i = ((NI) 1);
	nimln_(136, "reversi_core.nim");
	rev_cand = 0ULL;
	{
		nimln_(137, "reversi_core.nim");
		while (1) {
			NI TM_JSFJweKilXamd1oWnkcddg_18;
			NI TM_JSFJweKilXamd1oWnkcddg_19;
			NI TM_JSFJweKilXamd1oWnkcddg_20;
			nimln_(398, "system.nim");
			nimln_(137, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_18 = mulInt(i, ((NI) 8));
			if (!!(((NU64)((NU64)((NU64)(pos) << (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_18))) & masked_op) == ((NI) 0)))) goto LA21;
			nimln_(138, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_19 = mulInt(i, ((NI) 8));
			rev_cand = (NU64)(rev_cand | (NU64)((NU64)(pos) << (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_19))));
			nimln_(139, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_20 = addInt(i, ((NI) 1));
			i = (NI)(TM_JSFJweKilXamd1oWnkcddg_20);
		} LA21: ;
	}
	nimln_(140, "reversi_core.nim");
	{
		NI TM_JSFJweKilXamd1oWnkcddg_21;
		nimln_(398, "system.nim");
		nimln_(140, "reversi_core.nim");
		TM_JSFJweKilXamd1oWnkcddg_21 = mulInt(i, ((NI) 8));
		if (!!(((NU64)((NU64)((NU64)(pos) << (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_21))) & me) == ((NI) 0)))) goto LA24_;
		nimln_(141, "reversi_core.nim");
		result = (NU64)(result | rev_cand);
	}
	LA24_: ;
	nimln_(144, "reversi_core.nim");
	masked_op = (NU64)(op & 35604928818740736ULL);
	nimln_(146, "reversi_core.nim");
	i = ((NI) 1);
	nimln_(147, "reversi_core.nim");
	rev_cand = 0ULL;
	{
		nimln_(148, "reversi_core.nim");
		while (1) {
			NI TM_JSFJweKilXamd1oWnkcddg_22;
			NI TM_JSFJweKilXamd1oWnkcddg_23;
			NI TM_JSFJweKilXamd1oWnkcddg_24;
			nimln_(398, "system.nim");
			nimln_(148, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_22 = mulInt(i, ((NI) 7));
			if (!!(((NU64)((NU64)((NU64)(pos) << (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_22))) & masked_op) == ((NI) 0)))) goto LA27;
			nimln_(149, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_23 = mulInt(i, ((NI) 7));
			rev_cand = (NU64)(rev_cand | (NU64)((NU64)(pos) << (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_23))));
			nimln_(150, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_24 = addInt(i, ((NI) 1));
			i = (NI)(TM_JSFJweKilXamd1oWnkcddg_24);
		} LA27: ;
	}
	nimln_(151, "reversi_core.nim");
	{
		NI TM_JSFJweKilXamd1oWnkcddg_25;
		nimln_(398, "system.nim");
		nimln_(151, "reversi_core.nim");
		TM_JSFJweKilXamd1oWnkcddg_25 = mulInt(i, ((NI) 7));
		if (!!(((NU64)((NU64)((NU64)(pos) << (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_25))) & me) == ((NI) 0)))) goto LA30_;
		nimln_(152, "reversi_core.nim");
		result = (NU64)(result | rev_cand);
	}
	LA30_: ;
	nimln_(155, "reversi_core.nim");
	i = ((NI) 1);
	nimln_(156, "reversi_core.nim");
	rev_cand = 0ULL;
	{
		nimln_(157, "reversi_core.nim");
		while (1) {
			NI TM_JSFJweKilXamd1oWnkcddg_26;
			NI TM_JSFJweKilXamd1oWnkcddg_27;
			NI TM_JSFJweKilXamd1oWnkcddg_28;
			nimln_(398, "system.nim");
			nimln_(157, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_26 = mulInt(i, ((NI) 9));
			if (!!(((NU64)((NU64)((NU64)(pos) << (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_26))) & masked_op) == ((NI) 0)))) goto LA33;
			nimln_(158, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_27 = mulInt(i, ((NI) 9));
			rev_cand = (NU64)(rev_cand | (NU64)((NU64)(pos) << (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_27))));
			nimln_(159, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_28 = addInt(i, ((NI) 1));
			i = (NI)(TM_JSFJweKilXamd1oWnkcddg_28);
		} LA33: ;
	}
	nimln_(160, "reversi_core.nim");
	{
		NI TM_JSFJweKilXamd1oWnkcddg_29;
		nimln_(398, "system.nim");
		nimln_(160, "reversi_core.nim");
		TM_JSFJweKilXamd1oWnkcddg_29 = mulInt(i, ((NI) 9));
		if (!!(((NU64)((NU64)((NU64)(pos) << (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_29))) & me) == ((NI) 0)))) goto LA36_;
		nimln_(161, "reversi_core.nim");
		result = (NU64)(result | rev_cand);
	}
	LA36_: ;
	nimln_(164, "reversi_core.nim");
	i = ((NI) 1);
	nimln_(165, "reversi_core.nim");
	rev_cand = 0ULL;
	{
		nimln_(166, "reversi_core.nim");
		while (1) {
			NI TM_JSFJweKilXamd1oWnkcddg_30;
			NI TM_JSFJweKilXamd1oWnkcddg_31;
			NI TM_JSFJweKilXamd1oWnkcddg_32;
			nimln_(398, "system.nim");
			nimln_(166, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_30 = mulInt(i, ((NI) 9));
			if (!!(((NU64)((NU64)((NU64)(pos) >> (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_30))) & masked_op) == ((NI) 0)))) goto LA39;
			nimln_(167, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_31 = mulInt(i, ((NI) 9));
			rev_cand = (NU64)(rev_cand | (NU64)((NU64)(pos) >> (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_31))));
			nimln_(168, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_32 = addInt(i, ((NI) 1));
			i = (NI)(TM_JSFJweKilXamd1oWnkcddg_32);
		} LA39: ;
	}
	nimln_(169, "reversi_core.nim");
	{
		NI TM_JSFJweKilXamd1oWnkcddg_33;
		nimln_(398, "system.nim");
		nimln_(169, "reversi_core.nim");
		TM_JSFJweKilXamd1oWnkcddg_33 = mulInt(i, ((NI) 9));
		if (!!(((NU64)((NU64)((NU64)(pos) >> (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_33))) & me) == ((NI) 0)))) goto LA42_;
		nimln_(170, "reversi_core.nim");
		result = (NU64)(result | rev_cand);
	}
	LA42_: ;
	nimln_(173, "reversi_core.nim");
	i = ((NI) 1);
	nimln_(174, "reversi_core.nim");
	rev_cand = 0ULL;
	{
		nimln_(175, "reversi_core.nim");
		while (1) {
			NI TM_JSFJweKilXamd1oWnkcddg_34;
			NI TM_JSFJweKilXamd1oWnkcddg_35;
			NI TM_JSFJweKilXamd1oWnkcddg_36;
			nimln_(398, "system.nim");
			nimln_(175, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_34 = mulInt(i, ((NI) 7));
			if (!!(((NU64)((NU64)((NU64)(pos) >> (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_34))) & masked_op) == ((NI) 0)))) goto LA45;
			nimln_(176, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_35 = mulInt(i, ((NI) 7));
			rev_cand = (NU64)(rev_cand | (NU64)((NU64)(pos) >> (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_35))));
			nimln_(177, "reversi_core.nim");
			TM_JSFJweKilXamd1oWnkcddg_36 = addInt(i, ((NI) 1));
			i = (NI)(TM_JSFJweKilXamd1oWnkcddg_36);
		} LA45: ;
	}
	nimln_(178, "reversi_core.nim");
	{
		NI TM_JSFJweKilXamd1oWnkcddg_37;
		nimln_(398, "system.nim");
		nimln_(178, "reversi_core.nim");
		TM_JSFJweKilXamd1oWnkcddg_37 = mulInt(i, ((NI) 7));
		if (!!(((NU64)((NU64)((NU64)(pos) >> (NU64)((NI)(TM_JSFJweKilXamd1oWnkcddg_37))) & me) == ((NI) 0)))) goto LA48_;
		nimln_(179, "reversi_core.nim");
		result = (NU64)(result | rev_cand);
	}
	LA48_: ;
	popFrame();
	return result;
}

N_LIB_PRIVATE N_NIMCALL(tyTuple_GviMuKbe9c3Hsi9c4x4m9avrw, putStone_EFEi9aXdSta3HpRe4e2W67A)(NU64 black, NU64 white, NI pos_n, NIM_BOOL blackTurn) {
	tyTuple_GviMuKbe9c3Hsi9c4x4m9avrw result;
	NU64 rev;
	NU64 pos;
	nimfr_("putStone", "reversi_core.nim");
	memset((void*)(&result), 0, sizeof(result));
	rev = (NU64)0;
	nimln_(192, "reversi_core.nim");
	pos = ((NU64) ((NU)((NU64)(((NU) 1)) << (NU64)(pos_n))));
	nimln_(195, "reversi_core.nim");
	{
		tyArray_nHXaesL0DJZHyVS07ARPRA T5_;
		NU64 new_black;
		NU64 new_white;
		if (!blackTurn) goto LA3_;
		nimln_(197, "reversi_core.nim");
		rev = getRevBoard_aAAC5Qi6feABFGOdegNgSw(black, white, pos);
		nimln_(198, "reversi_core.nim");
		memset((void*)T5_, 0, sizeof(T5_));
		T5_[0] = dollar__rzAI8EMyNBAQwGODeohhAA(rev);
		echoBinSafe(T5_, 1);
		nimln_(199, "reversi_core.nim");
		new_black = (NU64)(black ^ (NU64)(pos | rev));
		nimln_(200, "reversi_core.nim");
		new_white = (NU64)(white ^ rev);
		nimln_(201, "reversi_core.nim");
		result.Field0 = new_black;
		result.Field1 = new_white;
	}
	goto LA1_;
	LA3_: ;
	{
		NU64 new_white_2;
		NU64 new_black_2;
		nimln_(204, "reversi_core.nim");
		rev = getRevBoard_aAAC5Qi6feABFGOdegNgSw(white, black, pos);
		nimln_(205, "reversi_core.nim");
		new_white_2 = (NU64)(white ^ (NU64)(pos | rev));
		nimln_(206, "reversi_core.nim");
		new_black_2 = (NU64)(black ^ rev);
		nimln_(207, "reversi_core.nim");
		result.Field0 = new_black_2;
		result.Field1 = new_white_2;
	}
	LA1_: ;
	popFrame();
	return result;
}
NIM_EXTERNC N_NOINLINE(void, unknown_reversi_coreInit000)(void) {
	nimfr_("reversi_core", "reversi_core.nim");
	popFrame();
}

NIM_EXTERNC N_NOINLINE(void, unknown_reversi_coreDatInit000)(void) {
}
