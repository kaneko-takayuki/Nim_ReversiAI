/* Generated by Nim Compiler v0.18.0 */
/*   (c) 2018 Andreas Rumpf */
/* The generated code is subject to the original license. */
/* Compiled for: MacOSX, amd64, clang */
/* Command for C compiler:
   clang -c  -w -O3  -I/Users/kaneko_takayuki/.choosenim/toolchains/nim-0.18.0/lib -o /Users/kaneko_takayuki/MyProgram/ReversiAI/src/nimcache/ai.o /Users/kaneko_takayuki/MyProgram/ReversiAI/src/nimcache/ai.c */
#define NIM_NEW_MANGLING_RULES
#define NIM_INTBITS 64

#include "nimbase.h"
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
typedef struct tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA;
typedef struct RootObj RootObj;
typedef struct TNimType TNimType;
typedef struct TNimNode TNimNode;
typedef NU8 tyEnum_TNimKind_jIBKr1ejBgsfM33Kxw4j7A;
typedef NU8 tySet_tyEnum_TNimTypeFlag_v8QUszD1sWlSIWZz7mC4bQ;
typedef N_NIMCALL_PTR(void, tyProc_ojoeKfW4VYIm36I9cpDTQIg) (void* p, NI op);
typedef N_NIMCALL_PTR(void*, tyProc_WSm2xU5ARYv9aAR4l0z9c9auQ) (void* p);
struct TNimType {
NI size;
tyEnum_TNimKind_jIBKr1ejBgsfM33Kxw4j7A kind;
tySet_tyEnum_TNimTypeFlag_v8QUszD1sWlSIWZz7mC4bQ flags;
TNimType* base;
TNimNode* node;
void* finalizer;
tyProc_ojoeKfW4VYIm36I9cpDTQIg marker;
tyProc_WSm2xU5ARYv9aAR4l0z9c9auQ deepcopy;
};
struct RootObj {
TNimType* m_type;
};
struct tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA {
  RootObj Sup;
NI value;
NI lastPosN;
};
typedef NU8 tyEnum_TNimNodeKind_unfNsxrcATrufDZmpBq4HQ;
struct TNimNode {
tyEnum_TNimNodeKind_unfNsxrcATrufDZmpBq4HQ kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
};
N_LIB_PRIVATE N_NIMCALL(tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA*, negaScout_nCscnMwOG1WTBi8Fg9b9bxVw)(NU64 me, NU64 op, NI alpha, NI beta, NI depth);
N_NIMCALL(void*, newObj)(TNimType* typ, NI size);
N_LIB_PRIVATE N_NIMCALL(NI, evaluate_i6j85K9bXGiEsMM1DCI9ccqw)(NU64 me, NU64 op);
N_LIB_PRIVATE N_NIMCALL(NI, evaluateWithPosition_WTnc1bOa8JXsHTNPzd5J8A)(NU64 me, NU64 op);
N_LIB_PRIVATE N_NIMCALL(NI, evaluateWithPutN_WTnc1bOa8JXsHTNPzd5J8A_2)(NU64 me, NU64 op);
N_LIB_PRIVATE N_NIMCALL(NIM_BOOL, isEnd_GohnLDQTdtUYriy1iAaBNA)(NU64 black, NU64 white);
N_LIB_PRIVATE N_NIMCALL(NU64, getPutBoard_zeO1KqsRtyEbP9bosMoaBIw)(NU64 me, NU64 op);
N_LIB_PRIVATE N_NIMCALL(tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA*, minus__Vty3RbFKjLQOgYqY9bvv5CQ)(tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA* x);
N_LIB_PRIVATE N_NIMCALL(NU64, getRevBoard_OZmhNZjQV9bCDasDWYYkfqw)(NU64 me, NU64 op, NU64 pos);
N_LIB_PRIVATE N_NIMCALL(NIM_BOOL, lt__0ZVrbyG0jTiHWR7uISrPNA)(tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA* x, tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA* y);
extern TNimType NTI_B9cTrhDFBURRqziYICNCAvA_;
extern TNimType NTI_zAsotna64eELd4Sf5w32sA_;

N_LIB_PRIVATE N_NIMCALL(NI, evaluate_i6j85K9bXGiEsMM1DCI9ccqw)(NU64 me, NU64 op) {
	NI result;
	NI T1_;
	NI T2_;
	result = (NI)0;
	T1_ = (NI)0;
	T1_ = evaluateWithPosition_WTnc1bOa8JXsHTNPzd5J8A(me, op);
	T2_ = (NI)0;
	T2_ = evaluateWithPutN_WTnc1bOa8JXsHTNPzd5J8A_2(me, op);
	result = (NI)(T1_ + (NI)(((NI) 10) * T2_));
	return result;
}

N_LIB_PRIVATE N_NIMCALL(tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA*, negaScout_nCscnMwOG1WTBi8Fg9b9bxVw)(NU64 me, NU64 op, NI alpha, NI beta, NI depth) {
	tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA* result;
	NU64 enablePut;
	tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA* T17_;
	NI childAlpha;
{	result = (tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA*)0;
	{
		tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA* T5_;
		if (!(depth == ((NI) 0))) goto LA3_;
		T5_ = (tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA*)0;
		T5_ = (tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA*) newObj((&NTI_B9cTrhDFBURRqziYICNCAvA_), sizeof(tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA));
		(*T5_).Sup.m_type = (&NTI_zAsotna64eELd4Sf5w32sA_);
		(*T5_).value = evaluate_i6j85K9bXGiEsMM1DCI9ccqw(me, op);
		(*T5_).lastPosN = ((NI) -1);
		result = T5_;
		goto BeforeRet_;
	}
	LA3_: ;
	{
		NIM_BOOL T8_;
		tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA* T11_;
		T8_ = (NIM_BOOL)0;
		T8_ = isEnd_GohnLDQTdtUYriy1iAaBNA(me, op);
		if (!T8_) goto LA9_;
		T11_ = (tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA*)0;
		T11_ = (tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA*) newObj((&NTI_B9cTrhDFBURRqziYICNCAvA_), sizeof(tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA));
		(*T11_).Sup.m_type = (&NTI_zAsotna64eELd4Sf5w32sA_);
		(*T11_).value = evaluate_i6j85K9bXGiEsMM1DCI9ccqw(me, op);
		(*T11_).lastPosN = ((NI) -1);
		result = T11_;
		goto BeforeRet_;
	}
	LA9_: ;
	enablePut = getPutBoard_zeO1KqsRtyEbP9bosMoaBIw(me, op);
	{
		tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA* T16_;
		if (!(enablePut == ((NI) 0))) goto LA14_;
		T16_ = (tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA*)0;
		T16_ = negaScout_nCscnMwOG1WTBi8Fg9b9bxVw(op, me, ((NI64)-(beta)), ((NI64)-(alpha)), depth);
		result = minus__Vty3RbFKjLQOgYqY9bvv5CQ(T16_);
		goto BeforeRet_;
	}
	LA14_: ;
	T17_ = (tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA*)0;
	T17_ = (tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA*) newObj((&NTI_B9cTrhDFBURRqziYICNCAvA_), sizeof(tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA));
	(*T17_).Sup.m_type = (&NTI_zAsotna64eELd4Sf5w32sA_);
	(*T17_).value = ((NI) (IL64(-9223372036854775807) - IL64(1)));
	(*T17_).lastPosN = ((NI) -1);
	result = T17_;
	childAlpha = alpha;
	{
		NI i;
		NI res;
		i = (NI)0;
		res = ((NI) 0);
		{
			while (1) {
				if (!(res <= ((NI) 63))) goto LA20;
				i = res;
				{
					NU64 pos;
					NU64 rev;
					NU64 childMe;
					NU64 childOp;
					tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA* childResult;
					tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA* T26_;
					{
						if (!((NU64)(enablePut & ((NU64) ((NU)((NU64)(((NU) 1)) << (NU64)(i))))) == ((NI) 0))) goto LA24_;
						goto LA21;
					}
					LA24_: ;
					pos = ((NU64) ((NU)((NU64)(((NU) 1)) << (NU64)(i))));
					rev = getRevBoard_OZmhNZjQV9bCDasDWYYkfqw(me, op, pos);
					childMe = (NU64)(me ^ (NU64)(pos | rev));
					childOp = (NU64)(op ^ rev);
					T26_ = (tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA*)0;
					T26_ = negaScout_nCscnMwOG1WTBi8Fg9b9bxVw(childOp, childMe, ((NI64)-(beta)), ((NI64)-(childAlpha)), (NI)(depth - ((NI) 1)));
					childResult = minus__Vty3RbFKjLQOgYqY9bvv5CQ(T26_);
					(*childResult).lastPosN = i;
					{
						if (!(beta <= (*childResult).value)) goto LA29_;
						result = childResult;
						goto BeforeRet_;
					}
					LA29_: ;
					{
						if (!(childAlpha < (*childResult).value)) goto LA33_;
						childAlpha = (*childResult).value;
					}
					LA33_: ;
					{
						NIM_BOOL T37_;
						T37_ = (NIM_BOOL)0;
						T37_ = lt__0ZVrbyG0jTiHWR7uISrPNA(result, childResult);
						if (!T37_) goto LA38_;
						result = childResult;
					}
					LA38_: ;
				} LA21: ;
				res += ((NI) 1);
			} LA20: ;
		}
	}
	}BeforeRet_: ;
	return result;
}

N_LIB_PRIVATE N_NIMCALL(NI, choosePosN_FnR9a55ekWIcD5z7wNgKsmQ)(NU64 black, NU64 white, NIM_BOOL blackTurn) {
	NI result;
	NU64 me;
	NU64 op;
	tyObject_SearchResultcolonObjectType__zAsotna64eELd4Sf5w32sA* searchResult;
	result = (NI)0;
	{
		if (!blackTurn) goto LA3_;
		me = black;
	}
	goto LA1_;
	LA3_: ;
	{
		me = white;
	}
	LA1_: ;
	{
		if (!blackTurn) goto LA8_;
		op = white;
	}
	goto LA6_;
	LA8_: ;
	{
		op = black;
	}
	LA6_: ;
	searchResult = negaScout_nCscnMwOG1WTBi8Fg9b9bxVw(me, op, ((NI) -10000), ((NI) 10000), ((NI) 7));
	result = (*searchResult).lastPosN;
	return result;
}
NIM_EXTERNC N_NOINLINE(void, unknown_aiInit000)(void) {
}

NIM_EXTERNC N_NOINLINE(void, unknown_aiDatInit000)(void) {
}

