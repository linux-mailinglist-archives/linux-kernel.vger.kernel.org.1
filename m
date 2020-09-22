Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EB62749D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIVUKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVUKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:10:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9CCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:10:33 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bfb005490ac4baf047eb3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:fb00:5490:ac4b:af04:7eb3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A64F01EC0268;
        Tue, 22 Sep 2020 22:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600805431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zpeQYd+BDjAI/7X80/S/siBQI6p/94yGa0o2b1H2ICk=;
        b=R8h9i169U/LFqf3JKOkUiOPRWmg8hKjnD2H0kGE81ieJLPw1xcvfiGrtVCH85NtDKhB8vN
        /DN0CjbtjoaRSCk4M0Sepnc8Q08wZdem1/BeOfbxpodrEQmn5KMwu3iFqWiMbOEVq+tuVY
        AyLMU7UHl4FjNvZHBCLu0igbcUM7QfM=
Date:   Tue, 22 Sep 2020 22:10:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Wei Huang <wei.huang2@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20200922201024.GS22660@zn.tnic>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ AMD folks.

On Tue, Sep 22, 2020 at 01:27:50PM +0800, Feng Tang wrote:
> End users frequently want to know what features their processor
> supports, independent of what the kernel supports.
> 
> /proc/cpuinfo is great. It is omnipresent and since it is provided by
> the kernel it is always as up to date as the kernel. But, it could be
> ambiguous about processor features which can be disabled by the kernel
> at boot-time or compile-time.
> 
> There are some user space tools showing more raw features, but they are
> not bound with kernel, and go with distros. Many end users are still
> using old distros with new kernels (upgraded by themselves), and may
> not upgrade the distros only to get a newer tool.
> 
> So here arise the need for a new tool, which
>   * Shows raw cpu features got from running cpuid
>   * Be easier to obtain updates for compared to existing userspace
>     tooling (perhaps distributed like perf)
>   * Inherits "modern" kernel development process, in contrast to some
>     of the existing userspace cpuid tools which are still being developed
>     without git and distributed in tarballs from non-https sites.
>   * Can produce output consistent with /proc/cpuinfo to make comparison
>     easier.
>   * Be in-kernel, could leverage kernel enabling, and even
>     theoretically consume arch/x86/boot/cpustr.h so it could pick up
>     new features directly from one-line X86_FEATURE_* definitions.
> 
> This RFC is an early prototype, and would get community's opinion on
> whether it's the right thing to do, and what functions it should also
> support.
> 
> It contains one .c core file and one text file which shows the bits
> definition of all CPUID output data, while in v1, a specific data
> structure is defined for each eax/ebx/ecx/edx output of each leaf
> and subleaf, which is less expandable [1].
> 
> The supported options are:
> 
>   Usage: kcpuid [-adfhr] [-l leaf] [-s subleaf]
> 	-a|--all		Show info of all CPUID leafs and subleafs(default on)
> 	-d|--detail		Show details of the flag/fields
> 	-f|--flags		Show boolean flags only
> 	-h|--help		Show usage info
> 	-l|--leaf=index		Specify the leaf
> 	-r|--raw		Show raw cpuid data
> 	-s|--subleaf=sub	Specify the subleaf
> 
> Current RFC version only shows limited number of cpu features, and will
> be completed
> 
> This is based on the prototype code from Borislav Petkov [2]. 
> 
> output of the tool (output cut version)
> ---------------------------------------
> 
> 	#kcpuid -r
> 
> 	Basic Leafs:
> 	0x00000000: EAX=0x0000000d, EBX=0x756e6547, ECX=0x6c65746e, EDX=0x49656e69
> 	0x00000001: EAX=0x000206d7, EBX=0x0a200800, ECX=0x1fbee3ff, EDX=0xbfebfbff
> 	0x00000004: subleafs:
> 	  0: EAX=0x3c004121, EBX=0x01c0003f, ECX=0x0000003f, EDX=0x00000000
> 	  1: EAX=0x3c004122, EBX=0x01c0003f, ECX=0x0000003f, EDX=0x00000000
> 	  2: EAX=0x3c004143, EBX=0x01c0003f, ECX=0x000001ff, EDX=0x00000000
> 
> 	Extended Leafs :
> 	0x80000000: EAX=0x80000008, EBX=0x00000000, ECX=0x00000000, EDX=0x00000000
> 	0x80000001: EAX=0x00000000, EBX=0x00000000, ECX=0x00000001, EDX=0x2c100800
> 	0x80000002: EAX=0x20202020, EBX=0x49202020, ECX=0x6c65746e, EDX=0x20295228
> 	...
> 
> 	#kcpuid -d
> 
> 	max_basic_leafs     	: 0xd       	- Max input value for supported subleafs
> 	stepping            	: 0x7       	- Stepping ID
> 	model               	: 0xd       	- Model
> 	family              	: 0x6       	- Family ID
> 	processor           	: 0x0       	- Processor Type
> 	sse3                 - Streaming SIMD Extensions 3(SSE3)
> 	pclmulqdq            - Support PCLMULQDQ instruction
> 	dtes64               - DS area uses 64-bit layout
> 	mwait                - MONITOR/MWAIT supported
> 	ds_cpl               - CPL Qualified Debug Store, which allows for branch message storage qualified by CPL
> 	vmx                  - Virtual Machine Extensions supported
> 	smx                  - Safer Mode Extension supported
> 	...
> 
> 	#kcpuid -f
> 
> 	sse3
> 	pclmulqdq
> 	dtes64
> 	mwait
> 	ds_cpl
> 	vmx
> 	smx
> 	eist
> 	tm2
> 	...
> 
> 	#kcpuid -l 0x1
> 
> 	stepping            	: 0x7
> 	model               	: 0xd
> 	family              	: 0x6
> 	processor           	: 0x0
> 	clflush_size        	: 0x8
> 	max_cpu_id          	: 0x20
> 	apic_id             	: 0xf
> 	sse3
> 	pclmulqdq
> 	dtes64
> 	mwait
> 	ds_cpl
> 	...
> 
> [1]. https://lore.kernel.org/lkml/1598514543-90152-1-git-send-email-feng.tang@intel.com/
> [2]. http://sr71.net/~dave/intel/stupid-cpuid.c
> 
> Originally-by: Borislav Petkov <bp@alien8.de>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Changelog:
> 
>   v2:
>   * use a new text file to store all the bits definition of each
>     CPUID leaf/subleafs, which is easier for future expansion, as
>     the core .c file will be kept untouched, suggested by Borislav/Dave
>   * some code cleanup
> 
>  tools/arch/x86/kcpuid/Makefile  |  21 ++
>  tools/arch/x86/kcpuid/cpuid.txt |  59 ++++
>  tools/arch/x86/kcpuid/kcpuid.c  | 598 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 678 insertions(+)
>  create mode 100644 tools/arch/x86/kcpuid/Makefile
>  create mode 100644 tools/arch/x86/kcpuid/cpuid.txt
>  create mode 100644 tools/arch/x86/kcpuid/kcpuid.c
> 
> diff --git a/tools/arch/x86/kcpuid/Makefile b/tools/arch/x86/kcpuid/Makefile
> new file mode 100644
> index 0000000..21453e5
> --- /dev/null
> +++ b/tools/arch/x86/kcpuid/Makefile
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Makefile for x86/kcpuid tool
> +
> +kcpuid : kcpuid.c
> +
> +CFLAGS =  -Wextra
> +
> +BINDIR ?= /usr/sbin
> +
> +override CFLAGS += -O2 -Wall -I../../../include
> +
> +%: %.c
> +	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
> +
> +.PHONY : clean
> +clean :
> +	@rm -f kcpuid
> +
> +install : kcpuid
> +	install -d  $(DESTDIR)$(BINDIR)
> +	install -m 755 -p kcpuid $(DESTDIR)$(BINDIR)/kcpuid
> diff --git a/tools/arch/x86/kcpuid/cpuid.txt b/tools/arch/x86/kcpuid/cpuid.txt
> new file mode 100644
> index 0000000..8c2c5ec
> --- /dev/null
> +++ b/tools/arch/x86/kcpuid/cpuid.txt
> @@ -0,0 +1,58 @@
> +# Leaf 00H
> +
> +LEAF[00000000],SUBLEAF[00],EAX[ 31:0],max_basic_leafs, Max input value for supported subleafs
> +
> +
> +# Leaf 01H
> +
> +LEAF[00000001],SUBLEAF[00],EAX[  3:0],stepping, Stepping ID
> +LEAF[00000001],SUBLEAF[00],EAX[  7:4],model, Model
> +LEAF[00000001],SUBLEAF[00],EAX[ 11:8],family, Family ID
> +LEAF[00000001],SUBLEAF[00],EAX[13:12],processor, Processor Type
> +LEAF[00000001],SUBLEAF[00],EAX[19:16],model_ext, Extended Model ID
> +LEAF[00000001],SUBLEAF[00],EAX[27:20],family_ext, Extended Family ID
> +
> +LEAF[00000001],SUBLEAF[00],EBX[  7:0],brand, Brand Index
> +LEAF[00000001],SUBLEAF[00],EBX[ 15:8],clflush_size, CLFLUSH line size (value * 8) in bytes
> +LEAF[00000001],SUBLEAF[00],EBX[23:16],max_cpu_id, Maxim number of addressable logic cpu ID in this package
> +LEAF[00000001],SUBLEAF[00],EBX[31:24],apic_id, Initial APIC ID
> +
> +LEAF[00000001],SUBLEAF[00],ECX[    0],sse3, Streaming SIMD Extensions 3(SSE3)
> +LEAF[00000001],SUBLEAF[00],ECX[    1],pclmulqdq, Support PCLMULQDQ instruction
> +LEAF[00000001],SUBLEAF[00],ECX[    2],dtes64, DS area uses 64-bit layout
> +LEAF[00000001],SUBLEAF[00],ECX[    3],mwait, MONITOR/MWAIT supported
> +LEAF[00000001],SUBLEAF[00],ECX[    4],ds_cpl, CPL Qualified Debug Store, which allows for branch message storage qualified by CPL
> +LEAF[00000001],SUBLEAF[00],ECX[    5],vmx, Virtual Machine Extensions supported
> +LEAF[00000001],SUBLEAF[00],ECX[    6],smx, Safer Mode Extension supported
> +LEAF[00000001],SUBLEAF[00],ECX[    7],eist, Enhanced Intel SpeedStep Technology
> +LEAF[00000001],SUBLEAF[00],ECX[    8],tm2, Thermal Monitor 2
> +LEAF[00000001],SUBLEAF[00],ECX[    9],ssse3, Supplemental Streaming SIMD Extensions 3 (SSSE3)
> +LEAF[00000001],SUBLEAF[00],ECX[   10],l1_ctx_id, L1 data cache could be set to either adaptive mode or shared mode (check IA32_MISC_ENABLE bit 24 definition)
> +LEAF[00000001],SUBLEAF[00],ECX[   11],sdbg, IA32_DEBUG_INTERFACE MSR for silicon debug supported
> +LEAF[00000001],SUBLEAF[00],ECX[   12],fma, FMA extensions using YMM state supported
> +LEAF[00000001],SUBLEAF[00],ECX[   13],cmpxchg16b, 'CMPXCHG16B - Compare and Exchange Bytes' supported
> +LEAF[00000001],SUBLEAF[00],ECX[   14],xtpr_update, xTPR Update Control supported
> +LEAF[00000001],SUBLEAF[00],ECX[   15],pdcm, Perfmon and Debug Capability supported
> +LEAF[00000001],SUBLEAF[00],ECX[   17],pcid, Process-Context Identifiers supported
> +LEAF[00000001],SUBLEAF[00],ECX[   18],dca, Prefetching data from a memory mapped device supported
> +LEAF[00000001],SUBLEAF[00],ECX[   19],sss4_1, SSE4.1 feature present
> +LEAF[00000001],SUBLEAF[00],ECX[   20],sse4_2, SSE4.2 feature present
> +LEAF[00000001],SUBLEAF[00],ECX[   21],x2apic, x2APIC supported
> +LEAF[00000001],SUBLEAF[00],ECX[   22],movbe, MOVBE instruction supported
> +LEAF[00000001],SUBLEAF[00],ECX[   23],popcnt, POPCNT instruction supported
> +LEAF[00000001],SUBLEAF[00],ECX[   24],tsc_deadline_timer, LAPIC supports not-shot operation usinga a TSC deadline value
> +LEAF[00000001],SUBLEAF[00],ECX[   25],aesni, AESNI instruction supported
> +LEAF[00000001],SUBLEAF[00],ECX[   26],xsave, XSAVE/XRSTOR processor extended states, XSETBV/XGETBV, XCR0 supported
> +LEAF[00000001],SUBLEAF[00],ECX[   27],osxsave, OS has set CR4.OSXSAVE bit to enable XSETBV/XGETBV, XCR0
> +LEAF[00000001],SUBLEAF[00],ECX[   28],avx, AVX instruction supported
> +LEAF[00000001],SUBLEAF[00],ECX[   29],f16c, 16-bit floating-point conversion instruction supported
> +LEAF[00000001],SUBLEAF[00],ECX[   30],rdrand, RDRAND instruction supported
> +
> +#
> +# !!! Test data for testing different options, will be removed in formal version
> +#
> +LEAF[00000004],SUBLEAF[00],ECX[    1],aaa, AAA
> +LEAF[00000004],SUBLEAF[01],ECX[    1],bbb, BBB
> +LEAF[00000004],SUBLEAF[02],ECX[    1],ccc, CCC
> +LEAF[00000004],SUBLEAF[03],ECX[    1],ddd, DDD
> +LEAF[80000000],SUBLEAF[00],EAX[    3],eee, EEE
> diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
> new file mode 100644
> index 0000000..ab2ab32
> --- /dev/null
> +++ b/tools/arch/x86/kcpuid/kcpuid.c
> @@ -0,0 +1,598 @@
> +#include <stdio.h>
> +#include <stdbool.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <getopt.h>
> +
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +
> +typedef unsigned int u32;
> +typedef unsigned long long u64;
> +
> +struct bits_desc {
> +	int start, end;		/* start and end bits */
> +	int value;		/* 0 or 1 for 1-bit flag */
> +	char simp[32];
> +	char detail[256];	/* 256B should be big enough? */
> +};
> +
> +/* descriptor info for eax/ebx/ecx/edx */
> +struct reg_desc {
> +	int nr;		/* number of valid entries */
> +	struct bits_desc descs[32];
> +};
> +
> +enum {
> +	R_EAX = 0,
> +	R_EBX,
> +	R_ECX,
> +	R_EDX,
> +	NR_REGS
> +};
> +
> +struct subleaf {
> +	u32 index;
> +	u32 sub;
> +	u32 eax, ebx, ecx, edx;
> +	struct reg_desc info[NR_REGS];	/* eax, ebx, ecx, edx */
> +};
> +
> +/* cpuid_func represents one leaf (basic or extended) */
> +struct cpuid_func {
> +	/*
> +	 * Array of subleafs for this func, if there is no subleafs
> +	 * then the leafs[0] is the main leaf
> +	 */
> +	struct subleaf *leafs;
> +	int nr;
> +};
> +
> +struct cpuid_range {
> +	/* Array of leafs in this range */
> +	struct cpuid_func *funcs;
> +	/* Number of valid leafs */
> +	int nr;
> +
> +	bool is_ext;
> +};
> +
> +
> +/*
> + * 'basic' means basic functions started from 0
> + * 'ext' means extended functions started from 0x80000000
> + */
> +struct cpuid_range *leafs_basic, *leafs_ext;
> +
> +static int num_leafs;
> +static bool is_amd;
> +static bool show_details;
> +static bool show_all = true;
> +static bool show_raw;
> +static bool show_flags_only;
> +
> +static u32 user_index = 0xFFFFFFFF;
> +static u32 user_sub = 0xFFFFFFFF;
> +
> +static inline void cpuid(u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
> +{
> +	/* ecx is often an input as well as an output. */
> +	asm volatile("cpuid"
> +	    : "=a" (*eax),
> +	      "=b" (*ebx),
> +	      "=c" (*ecx),
> +	      "=d" (*edx)
> +	    : "0" (*eax), "2" (*ecx));
> +}
> +
> +static inline bool has_subleafs(u32 f)
> +{
> +	if (f == 0x7 || f == 0xd)
> +		return true;
> +
> +	if (is_amd) {
> +		if (f == 0x8000001d)
> +			return true;
> +		return false;
> +	}
> +
> +	if (f == 0x4 || f == 0xf || f == 0x10 || f == 0x14)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void leaf_print_raw(struct subleaf *leaf)
> +{
> +	if (has_subleafs(leaf->index)) {
> +		if (leaf->sub == 0)
> +			printf("0x%08x: subleafs:\n", leaf->index);
> +
> +		printf(" %2d: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
> +			leaf->sub, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
> +	} else {
> +		printf("0x%08x: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
> +			leaf->index, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
> +	}
> +}
> +
> +static void cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
> +			u32 a, u32 b, u32 c, u32 d)
> +{
> +	struct cpuid_func *func;
> +	struct subleaf *leaf;
> +	int s = 0;
> +
> +	if (a == 0 && b == 0 && c == 0 && d == 0)
> +		return;
> +
> +	/*
> +	 * Cut off vendor-prefix from CPUID function as we're using it as an
> +	 * index into ->funcs.
> +	 */
> +	func = &range->funcs[f & 0xffff];
> +	if (!func->leafs) {
> +		func->leafs = malloc(sizeof(struct subleaf));
> +		if (!func->leafs)
> +			perror("malloc func leaf");
> +
> +		func->nr = 1;
> +	} else {
> +		s = func->nr;
> +		func->leafs = realloc(func->leafs, (s + 1) * sizeof(struct subleaf));
> +		if (!func->leafs)
> +			perror("realloc f->leafs");
> +
> +		func->nr++;
> +	}
> +
> +	leaf = &func->leafs[s];
> +
> +	leaf->index = f;
> +	leaf->sub = subleaf;
> +	leaf->eax = a;
> +	leaf->ebx = b;
> +	leaf->ecx = c;
> +	leaf->edx = d;
> +}
> +
> +static void raw_dump_range(struct cpuid_range *range)
> +{
> +	u32 f;
> +	int i;
> +
> +	printf("\n%s Leafs :\n", range->is_ext ? "Extended" : "Basic");
> +
> +	for (f = 0; (int)f < range->nr; f++) {
> +		struct cpuid_func *func = &range->funcs[f];
> +		u32 index = f;
> +
> +		if (range->is_ext)
> +			index += 0x80000000;
> +
> +		if (!func->nr) {
> +			printf("0x%08x: ...\n", f);
> +		} else {
> +			for (i = 0; i < func->nr; i++)
> +				leaf_print_raw(&func->leafs[i]);
> +		}
> +	}
> +}
> +
> +struct cpuid_range *setup_cpuid_range(u32 input_eax)
> +{
> +	u32 max_func, idx_func;
> +	int subleaf;
> +	struct cpuid_range *range;
> +	u32 eax, ebx, ecx, edx;
> +	u32 f = input_eax;
> +
> +	eax = input_eax;
> +	ebx = ecx = edx = 0;
> +
> +	cpuid(&eax, &ebx, &ecx, &edx);
> +	max_func = eax;
> +	idx_func = (max_func & 0xffff) + 1;
> +
> +	range = malloc(sizeof(struct cpuid_range));
> +	if (!range)
> +		perror("malloc range");
> +
> +	if (input_eax & 0x80000000)
> +		range->is_ext = true;
> +	else
> +		range->is_ext = false;
> +
> +	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
> +	if (!range->funcs)
> +		perror("malloc range->funcs");
> +
> +	range->nr = idx_func;
> +	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
> +
> +	for (; f <= max_func; f++) {
> +		eax = f;
> +		subleaf = ecx = 0;
> +
> +		cpuid(&eax, &ebx, &ecx, &edx);
> +		cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
> +		num_leafs++;
> +
> +		if (!has_subleafs(f))
> +			continue;
> +
> +		for (subleaf = 1; subleaf < 64; subleaf++) {
> +			eax = f;
> +			ecx = subleaf;
> +
> +			cpuid(&eax, &ebx, &ecx, &edx);
> +
> +			/* is subleaf valid? */
> +			if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0)
> +				continue;
> +
> +			cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
> +			num_leafs++;
> +		}
> +	}
> +
> +	return range;
> +}
> +
> +/*
> + * The max nubmer returned by CPUID is honored and we
> + * created leafs for all of them, even some has no valid info
> + */
> +
> +/*
> + * Currently the input text is assumed to be correct, without bits overlapping
> + * and wrong format. More error check could be added later on demand, sample
> + * like below:
> + *
> + *	LEAF[00000000],SUBLEAF[00],EAX[31:00],aaa, AAAAAAAAAAAA
> + *	LEAF[80000001],SUBLEAF[00],EAX[    2],bbb, BBBBBBBBBBBB
> + */
> +static int parse_line(char *line)
> +{
> +	char *str, *buf;
> +	struct cpuid_range *range;
> +	struct cpuid_func *func;
> +	struct subleaf *leaf;
> +	u32 index, sub;
> +	char buffer[512];
> +	char *tokens[5];
> +	struct reg_desc *reg;
> +	struct bits_desc *bdesc;
> +	char *start, *end;
> +	int i;
> +
> +	/* Skip comments parts in cpuid.txt */
> +	if (line[0] == '#' || line[0] == '\n' || line[0] == ' ')
> +		return 0;
> +
> +	/*
> +	 * Tokens:
> +	 *  1. leaf
> +	 *  2. subleaf
> +	 *  3. bits
> +	 *  4. simiple text
> +	 *  5. detail string
> +	 */
> +	str = line;
> +	for (i = 0; i < 4; i++) {
> +		tokens[i] = strtok(str, ",");
> +		if (!tokens[i])
> +			goto err_exit;
> +		str = NULL;
> +	}
> +	tokens[4] = strtok(str, "\n");
> +
> +	/* index */
> +	buf = tokens[0];
> +	if (strncmp(buf, "LEAF[", 5) || buf[13] != ']')
> +		goto err_exit;
> +
> +	buffer[0] = '0';
> +	buffer[1] = 'x';
> +	strncpy(buffer + 2, buf + 5, 8);
> +	index = strtoul(buffer, NULL, 0);
> +
> +	if (index & 0x80000000)
> +		range = leafs_ext;
> +	else
> +		range = leafs_basic;
> +
> +	index &= 0x7FFFFFFF;
> +	if ((int)index > range->nr) {
> +		printf("ERR: invalid index[0x%x] nr:%d\n",
> +				index,
> +				range->nr);
> +		return -1;
> +	}
> +	func = &range->funcs[index];
> +
> +	/* subleaf */
> +	buf = tokens[1];
> +	if (strncmp(buf, "SUBLEAF[", 8) || buf[10] != ']')
> +		goto err_exit;
> +
> +	strncpy(buffer + 2, buf + 8, 2);
> +	buffer[4] = 0;
> +	sub = strtoul(buffer, NULL, 0);
> +	if (sub > (u32)func->nr)  {
> +		printf("ERR: invalid subleaf[%d]\n", sub);
> +		return -1;
> +	}
> +
> +	/* token[2]: register and bits field */
> +	leaf = &func->leafs[sub];
> +	buf = tokens[2];
> +	if (buf[0] != 'E' || buf[2] != 'X' || buf[1] < 'A' || buf[1] > 'D')
> +		goto err_exit;
> +
> +	reg = &leaf->info[buf[1] - 'A'];
> +	bdesc = &reg->descs[reg->nr++];
> +
> +	strcpy(buffer, buf + 4);
> +	if (strstr(buffer, ":")) {
> +		end = strtok(buffer, ":");
> +		start = strtok(NULL, "]");
> +
> +		bdesc->end = strtoul(end, NULL, 0);
> +		bdesc->start = strtoul(start, NULL, 0);
> +	} else {
> +		start = strtok(buffer, "]");
> +		bdesc->start = bdesc->end = strtoul(start, NULL, 0);
> +	}
> +
> +	strcpy(bdesc->simp, tokens[3]);
> +	strcpy(bdesc->detail, tokens[4]);
> +	return 0;
> +
> +err_exit:
> +	printf("ERR: wrong line formt!\n\n");
> +	return -1;
> +}
> +
> +/*
> + * Parse text file, and construct the array of all CPUID leafs and subleafs
> + */
> +static void parse_text(void)
> +{
> +	FILE *file;
> +	char *line = NULL;
> +	size_t len = 0;
> +	int ret;
> +
> +	file = fopen("cpuid.txt", "r");
> +	if (!file) {
> +		printf("Error in opening 'cpuid.txt'\n");
> +		return;
> +	}
> +
> +	while (1) {
> +		ret = getline(&line, &len, file);
> +		if (ret > 0)
> +			parse_line(line);
> +
> +		if (feof(file))
> +			break;
> +	}
> +	fclose(file);
> +}
> +
> +/* Parse every eax/ebx/ecx/edx */
> +static void decode_bits(u32 value, struct reg_desc *rdesc)
> +{
> +	struct bits_desc *bdesc;
> +	int start, end, i;
> +	u32 mask;
> +
> +	for (i = 0; i < rdesc->nr; i++) {
> +		bdesc = &rdesc->descs[i];
> +		start = bdesc->start;
> +		end = bdesc->end;
> +
> +		if (start == end) {
> +			/* single bit flag */
> +			if (value & (1 << start)) {
> +				printf("\t%-20s %s%s\n",
> +					bdesc->simp,
> +					show_details ? "-" : "",
> +					show_details ? bdesc->detail : ""
> +					);
> +			}
> +		} else {
> +			/* bit fields */
> +			if (show_flags_only)
> +				continue;
> +			mask = ((u64)1 << (end - start + 1)) - 1;
> +			printf("\t%-20s\t: 0x%-8x\t%s%s\n",
> +					bdesc->simp,
> +					(value >> start) & mask,
> +					show_details ? "-" : "",
> +					show_details ? bdesc->detail : ""
> +					);
> +		}
> +	}
> +}
> +
> +static void show_leaf(struct subleaf *leaf)
> +{
> +	if (!leaf)
> +		return;
> +
> +	decode_bits(leaf->eax, &leaf->info[R_EAX]);
> +	decode_bits(leaf->ebx, &leaf->info[R_EBX]);
> +	decode_bits(leaf->ecx, &leaf->info[R_ECX]);
> +	decode_bits(leaf->edx, &leaf->info[R_EDX]);
> +}
> +
> +static void show_func(struct cpuid_func *func)
> +{
> +	int i;
> +
> +	if (!func)
> +		return;
> +
> +	for (i = 0; i < func->nr; i++)
> +		show_leaf(&func->leafs[i]);
> +}
> +
> +static void show_range(struct cpuid_range *range)
> +{
> +	int i;
> +
> +	for (i = 0; i < range->nr; i++)
> +		show_func(&range->funcs[i]);
> +}
> +
> +static inline struct cpuid_func *index_to_func(u32 index)
> +{
> +	struct cpuid_range *range;
> +
> +	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
> +	index &= 0x7FFFFFFF;
> +
> +	if (((index & 0xFFFF) + 1) > (u32)range->nr) {
> +		printf("ERR: invalid input index (0x%x)\n", index);
> +		return NULL;
> +	}
> +	return &range->funcs[index];
> +}
> +
> +static void show_info(void)
> +{
> +	struct cpuid_func *func;
> +
> +	if (show_raw) {
> +		/* Show all of the raw output data of running cpuid */
> +		raw_dump_range(leafs_basic);
> +		raw_dump_range(leafs_ext);
> +		return;
> +	}
> +
> +	if (show_all) {
> +		show_range(leafs_basic);
> +		show_range(leafs_ext);
> +		return;
> +	}
> +
> +	/* Show specific leaf/subleaf info */
> +	func = index_to_func(user_index);
> +	if (!func)
> +		return;
> +
> +	if (user_sub != 0xFFFFFFFF) {
> +		if (user_sub + 1 <= (u32)func->nr) {
> +			show_leaf(&func->leafs[user_sub]);
> +			return;
> +		} else {
> +			printf("ERR: invalid input index (0x%x)\n", user_sub);
> +		}
> +	}
> +
> +	show_func(func);
> +}
> +
> +static void setup_platform_cpuid(void)
> +{
> +	 u32 eax, ebx, ecx, edx;
> +
> +	/* check vendor */
> +	eax = ebx = ecx = edx = 0;
> +	cpuid(&eax, &ebx, &ecx, &edx);
> +	/* "htuA" */
> +	if (ebx == 0x68747541)
> +		is_amd = 1;
> +
> +	/* setup leafs by getting the base and extended range */
> +	leafs_basic = setup_cpuid_range(0x0);
> +	leafs_ext = setup_cpuid_range(0x80000000);
> +	printf("This platform has %d CPUID leafs and subleafs.\n\n",
> +		num_leafs);
> +}
> +
> +static void usage(void)
> +{
> +	printf("  Usage: kcpuid [-adfhr] [-l leaf] [-s subleaf]\n"
> +		"\t-a|--all		Show info of all CPUID leafs and subleafs(default on)\n"
> +		"\t-d|--detail		Show details of the flag/fields\n"
> +		"\t-f|--flags		Show boolean flags only \n"
> +		"\t-h|--help		Show usage info\n"
> +		"\t-l|--leaf=index	Specify the leaf you want to check\n"
> +		"\t-r|--raw		Show raw cpuid data\n"
> +		"\t-s|--subleaf=sub	Specify the subleaf you want to check\n"
> +		"\n"
> +	);
> +}
> +
> +struct option opts[] = {
> +	{ "all", no_argument, NULL, 'a' },		/* show all leafs */
> +	{ "detail", no_argument, NULL, 'd' },		/* show detail descriptions, default no */
> +	{ "flags", no_argument, NULL, 'f' },		/* only show flags */
> +	{ "help", no_argument, NULL, 'h'},		/* show usage */
> +	{ "leaf", required_argument, NULL, 'l'},	/* give the specific leaf you want to check */
> +	{ "raw", no_argument, NULL, 'r'},		/* show raw CPUID leaf data */
> +	{ "subleaf", required_argument, NULL, 's'},	/* give the specific subleaf you want to check */
> +	{ NULL, 0, NULL, 0 }
> +};
> +
> +static int parse_options(int argc, char *argv[])
> +{
> +	int c;
> +
> +	while ((c = getopt_long(argc, argv, "adfg:hl:rs:",
> +					opts, NULL)) != -1)
> +		switch (c) {
> +		case 'a':
> +			show_all = true;
> +			break;
> +		case 'd':
> +			show_details = true;
> +			break;
> +		case 'f':
> +			show_flags_only = true;
> +			break;
> +		case 'h':
> +			usage();
> +			exit(1);
> +			break;
> +		case 'l':
> +			user_index = strtoul(optarg, NULL, 0);
> +			show_all = false;
> +			break;
> +		case 'r':
> +			show_raw = true;
> +			break;
> +		case 's':
> +			user_sub = strtoul(optarg, NULL, 0);
> +			break;
> +		default:
> +			printf("%s: Invalid option '%c'\n", argv[0], optopt);
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Do 4 things in turn:
> + * 1. Parse user input options
> + * 2. Parse and store all the CPUID leaf data supported on this platform
> + * 2. Parse the text file according, skip leafs which is not available
> + *    on this platform
> + * 3. Print leafs info based on uers options
> + */
> +int main(int argc, char *argv[])
> +{
> +	if (parse_options(argc, argv))
> +		return -1;
> +
> +	/* setup the cpuid leafs of current platform */
> +	setup_platform_cpuid();
> +
> +	/* read and parse the 'cpuid.txt' */
> +	parse_text();
> +
> +	show_info();
> +	return 0;
> +}
> -- 
> 2.7.4
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
