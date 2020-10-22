Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AAB2957D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 07:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507886AbgJVFVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 01:21:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:2444 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444362AbgJVFVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 01:21:31 -0400
IronPort-SDR: dYzLAc2PWau4DoWN3ihYYFJGh3uHl+sue7vxeGQw+i0dlXyOE816eD8tOPKjf4M0w/EzHyNfyc
 34vTKQI71MBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="166693815"
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="166693815"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 22:21:30 -0700
IronPort-SDR: mtv561QQmLZIbHgVMzlosDF18h65DZYUgKxmSjJIw7hsxXyzXYnwakoU6/NBr7RLCHma7tLk/X
 vC+STh1rgHbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; 
   d="scan'208";a="523007593"
Received: from shbuild999.sh.intel.com ([10.239.147.98])
  by fmsmga006.fm.intel.com with ESMTP; 21 Oct 2020 22:21:25 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     nivedita@alum.mit.edu, thomas.lendacky@amd.com,
        yazen.ghannam@amd.com, wei.huang2@amd.com,
        Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH v3] tools/x86: add kcpuid tool to show raw CPU features
Date:   Thu, 22 Oct 2020 13:21:23 +0800
Message-Id: <1603344083-100742-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

End users frequently want to know what features their processor
supports, independent of what the kernel supports.

/proc/cpuinfo is great. It is omnipresent and since it is provided by
the kernel it is always as up to date as the kernel. But, it could be
ambiguous about processor features which can be disabled by the kernel
at boot-time or compile-time.

There are some user space tools showing more raw features, but they are
not bound with kernel, and go with distros. Many end users are still
using old distros with new kernels (upgraded by themselves), and may
not upgrade the distros only to get a newer tool.

So here arise the need for a new tool, which
  * Shows raw cpu features got from running cpuid
  * Be easier to obtain updates for compared to existing userspace
    tooling (perhaps distributed like perf)
  * Inherits "modern" kernel development process, in contrast to some
    of the existing userspace cpuid tools which are still being developed
    without git and distributed in tarballs from non-https sites.
  * Can produce output consistent with /proc/cpuinfo to make comparison
    easier.

This RFC is an early prototype, and would get community's opinion on
whether it's the right thing to do, and what functions it should also
support.

It contains one .c core file and one text file which shows the bits
definition of all CPUID output data, while in v1, a specific data
structure is defined for each eax/ebx/ecx/edx output of each leaf
and subleaf, which is less expandable [1].

This is based on the prototype code from Borislav Petkov [2].

The supported options are:

  Usage: kcpuid [-abdfhr] [-l leaf] [-s subleaf]
	-a|--all             Show info of all CPUID leafs and subleafs(default on)
	-b|--bitflags        Show boolean flags only
	-d|--detail          Show details of the flag/fields
	-f|--flags           Show boolean flags only
	-h|--help            Show usage info
	-l|--leaf=index      Specify the leaf you want to check
	-r|--raw             Show raw cpuid data
	-s|--subleaf=sub     Specify the subleaf you want to check

Current RFC version only shows limited number of cpu features, and will
be completed

output of the tool (output cut version)
---------------------------------------

    #kcpuid -r

    Basic Leafs :
    ================
    0x00000000: EAX=0x0000000d, EBX=0x756e6547, ECX=0x6c65746e, EDX=0x49656e69
    0x00000001: EAX=0x000206d7, EBX=0x0d200800, ECX=0x1fbee3ff, EDX=0xbfebfbff
    0x00000002: EAX=0x76035a01, EBX=0x00f0b2ff, ECX=0x00000000, EDX=0x00ca0000
    0x00000004: subleafs:
      0: EAX=0x3c004121, EBX=0x01c0003f, ECX=0x0000003f, EDX=0x00000000
      1: EAX=0x3c004122, EBX=0x01c0003f, ECX=0x0000003f, EDX=0x00000000
      2: EAX=0x3c004143, EBX=0x01c0003f, ECX=0x000001ff, EDX=0x00000000
      3: EAX=0x3c07c163, EBX=0x04c0003f, ECX=0x00003fff, EDX=0x00000006
    ...

    Extended Leafs :
    ================
    0x80000000: EAX=0x80000008, EBX=0x00000000, ECX=0x00000000, EDX=0x00000000
    0x80000001: EAX=0x00000000, EBX=0x00000000, ECX=0x00000001, EDX=0x2c100800

    #kcpuid -d

    max_basic_leafs     	: 0xd       	- Max input value for supported subleafs
    stepping            	: 0x7       	- Stepping ID
    model               	: 0xd       	- Model
    family              	: 0x6       	- Family ID
    processor           	: 0x0       	- Processor Type
    sse3                 - Streaming SIMD Extensions 3(SSE3)
    pclmulqdq            - Support PCLMULQDQ instruction
    dtes64               - DS area uses 64-bit layout
    mwait                - MONITOR/MWAIT supported
    ds_cpl               - CPL Qualified Debug Store, which allows for branch message storage qualified by CPL
    vmx                  - Virtual Machine Extensions supported
    smx                  - Safer Mode Extension supported
    ...

    #kcpuid -b

    sse3
    pclmulqdq
    dtes64
    mwait
    ds_cpl
    vmx
    smx
    eist
    tm2
    ...

    #kcpuid -l 0x1

    stepping            	: 0x7
    model               	: 0xd
    family              	: 0x6
    processor           	: 0x0
    clflush_size        	: 0x8
    max_cpu_id          	: 0x20
    apic_id             	: 0xf
    sse3
    pclmulqdq
    dtes64
    mwait
    ds_cpl
    ...

[1]. https://lore.kernel.org/lkml/1598514543-90152-1-git-send-email-feng.tang@intel.com/
[2]. http://sr71.net/~dave/intel/stupid-cpuid.c

Originally-from: Borislav Petkov <bp@alien8.de>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:

  v3:
  * use .csv file instead of plain text file which also uses
    comma to separate fields (Borislav)
  * add option to support a user specified .csv file (Dave)
  * make install will put the csv file under /usr/share/hwdata/ (Dave)

  v2:
  * use a new text file to store all the bits definition of each
    CPUID leaf/subleafs, which is easier for future expansion, as
    the core .c file will be kept untouched, suggested by Borislav/Dave
  * some code cleanup

 tools/arch/x86/kcpuid/Makefile  |  24 ++
 tools/arch/x86/kcpuid/cpuid.csv |  57 ++++
 tools/arch/x86/kcpuid/kcpuid.c  | 618 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 699 insertions(+)
 create mode 100644 tools/arch/x86/kcpuid/Makefile
 create mode 100644 tools/arch/x86/kcpuid/cpuid.csv
 create mode 100644 tools/arch/x86/kcpuid/kcpuid.c

diff --git a/tools/arch/x86/kcpuid/Makefile b/tools/arch/x86/kcpuid/Makefile
new file mode 100644
index 0000000..13f4e51
--- /dev/null
+++ b/tools/arch/x86/kcpuid/Makefile
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for x86/kcpuid tool
+
+kcpuid : kcpuid.c
+
+CFLAGS =  -Wextra
+
+BINDIR ?= /usr/sbin
+
+HWDATADIR ?= /usr/share/hwdata
+
+override CFLAGS += -O2 -Wall -I../../../include
+
+%: %.c
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
+
+.PHONY : clean
+clean :
+	@rm -f kcpuid
+
+install : kcpuid
+	install -d  $(DESTDIR)$(BINDIR)
+	install -m 755 -p kcpuid $(DESTDIR)$(BINDIR)/kcpuid
+	install -m 444 -p cpuid.csv $(HWDATADIR)/cpuid.csv
diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
new file mode 100644
index 0000000..a6bacd2
--- /dev/null
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -0,0 +1,57 @@
+# The basic row format is:
+# LEAF,SUBLEAF,register_name,bits,short name,long description
+
+# Leaf 00H
+         0,    0,  EAX,   31:0, max_basic_leafs,  Max input value for supported subleafs
+# Leaf 01H
+         1,    0,  EAX,    3:0, stepping,  Stepping ID
+         1,    0,  EAX,    7:4, model,  Model
+         1,    0,  EAX,   11:8, family,  Family ID
+         1,    0,  EAX,  13:12, processor,  Processor Type
+         1,    0,  EAX,  19:16, model_ext,  Extended Model ID
+         1,    0,  EAX,  27:20, family_ext,  Extended Family ID
+
+         1,    0,  EBX,    7:0, brand,  Brand Index
+         1,    0,  EBX,   15:8, clflush_size,  CLFLUSH line size (value * 8) in bytes
+         1,    0,  EBX,  23:16, max_cpu_id,  Maxim number of addressable logic cpu in this package
+         1,    0,  EBX,  31:24, apic_id,  Initial APIC ID
+
+         1,    0,  ECX,      0, sse3,  Streaming SIMD Extensions 3(SSE3)
+         1,    0,  ECX,      1, pclmulqdq,  PCLMULQDQ instruction supported
+         1,    0,  ECX,      2, dtes64,  DS area uses 64-bit layout
+         1,    0,  ECX,      3, mwait,  MONITOR/MWAIT supported
+         1,    0,  ECX,      4, ds_cpl,  CPL Qualified Debug Store which allows for branch message storage qualified by CPL
+         1,    0,  ECX,      5, vmx,  Virtual Machine Extensions supported
+         1,    0,  ECX,      6, smx,  Safer Mode Extension supported
+         1,    0,  ECX,      7, eist,  Enhanced Intel SpeedStep Technology
+         1,    0,  ECX,      8, tm2,  Thermal Monitor 2
+         1,    0,  ECX,      9, ssse3,  Supplemental Streaming SIMD Extensions 3 (SSSE3)
+         1,    0,  ECX,     10, l1_ctx_id,  L1 data cache could be set to either adaptive mode or shared mode (check IA32_MISC_ENABLE bit 24 definition)
+         1,    0,  ECX,     11, sdbg,  IA32_DEBUG_INTERFACE MSR for silicon debug supported
+         1,    0,  ECX,     12, fma,  FMA extensions using YMM state supported
+         1,    0,  ECX,     13, cmpxchg16b,  'CMPXCHG16B - Compare and Exchange Bytes' supported
+         1,    0,  ECX,     14, xtpr_update,  xTPR Update Control supported
+         1,    0,  ECX,     15, pdcm,  Perfmon and Debug Capability present
+         1,    0,  ECX,     17, pcid,  Process-Context Identifiers feature present
+         1,    0,  ECX,     18, dca,  Prefetching data from a memory mapped device supported
+         1,    0,  ECX,     19, sss4_1,  SSE4.1 feature present
+         1,    0,  ECX,     20, sse4_2,  SSE4.2 feature present
+         1,    0,  ECX,     21, x2apic,  x2APIC supported
+         1,    0,  ECX,     22, movbe,  MOVBE instruction supported
+         1,    0,  ECX,     23, popcnt,  POPCNT instruction supported
+         1,    0,  ECX,     24, tsc_deadline_timer,  LAPIC supports one-shot operation using a TSC deadline value
+         1,    0,  ECX,     25, aesni,  AESNI instruction supported
+         1,    0,  ECX,     26, xsave,  XSAVE/XRSTOR processor extended states (XSETBV/XGETBV/XCR0)
+         1,    0,  ECX,     27, osxsave,  OS has set CR4.OSXSAVE bit to enable XSETBV/XGETBV/XCR0
+         1,    0,  ECX,     28, avx,  AVX instruction supported
+         1,    0,  ECX,     29, f16c,  16-bit floating-point conversion instruction supported
+         1,    0,  ECX,     30, rdrand,  RDRAND instruction supported
+
+#
+# !!! Test data for testing different options, will be updated in formal version
+#
+         4,    0,  ECX,      1, aaa,  AAA
+         4,    1,  ECX,      1, bbb,  BBB
+         4,    2,  ECX,      1, ccc,  CCC
+         4,    3,  ECX,      1, ddd,  DDD
+0x80000000,    0,  EAX,      3, eee,  EEE
diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
new file mode 100644
index 0000000..9bd35b7
--- /dev/null
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -0,0 +1,618 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+typedef unsigned int u32;
+typedef unsigned long long u64;
+
+char *def_csv = "/usr/share/hwdata/cpuid.csv";
+char *user_csv;
+
+struct bits_desc {
+	int start, end;		/* start and end bits */
+	int value;		/* 0 or 1 for 1-bit flag */
+	char simp[32];
+	char detail[256];
+};
+
+/* Descriptor info for eax/ebx/ecx/edx */
+struct reg_desc {
+	int nr;		/* number of valid entries */
+	struct bits_desc descs[32];
+};
+
+enum {
+	R_EAX = 0,
+	R_EBX,
+	R_ECX,
+	R_EDX,
+	NR_REGS
+};
+
+struct subleaf {
+	u32 index;
+	u32 sub;
+	u32 eax, ebx, ecx, edx;
+	struct reg_desc info[NR_REGS];	/* eax, ebx, ecx, edx */
+};
+
+/* cpuid_func represents one leaf (basic or extended) */
+struct cpuid_func {
+	/*
+	 * Array of subleafs for this func, if there is no subleafs
+	 * then the leafs[0] is the main leaf
+	 */
+	struct subleaf *leafs;
+	int nr;
+};
+
+struct cpuid_range {
+	/* Array of leafs in this range */
+	struct cpuid_func *funcs;
+	/* Number of valid leafs */
+	int nr;
+	bool is_ext;
+};
+
+/*
+ * basic:  basic functions started from 0
+ * ext:    extended functions started from 0x80000000
+ */
+struct cpuid_range *leafs_basic, *leafs_ext;
+
+static int num_leafs;
+static bool is_amd;
+static bool show_details;
+static bool show_all = true;
+static bool show_raw;
+static bool show_flags_only;
+
+static u32 user_index = 0xFFFFFFFF;
+static u32 user_sub = 0xFFFFFFFF;
+static int flines;
+
+static inline void cpuid(u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
+{
+	/* ecx is often an input as well as an output. */
+	asm volatile("cpuid"
+	    : "=a" (*eax),
+	      "=b" (*ebx),
+	      "=c" (*ecx),
+	      "=d" (*edx)
+	    : "0" (*eax), "2" (*ecx));
+}
+
+static inline bool has_subleafs(u32 f)
+{
+	if (f == 0x7 || f == 0xd)
+		return true;
+
+	if (is_amd) {
+		if (f == 0x8000001d)
+			return true;
+		return false;
+	}
+
+	if (f == 0x4 || f == 0xf || f == 0x10 || f == 0x14)
+		return true;
+
+	return false;
+}
+
+static void leaf_print_raw(struct subleaf *leaf)
+{
+	if (has_subleafs(leaf->index)) {
+		if (leaf->sub == 0)
+			printf("0x%08x: subleafs:\n", leaf->index);
+
+		printf(" %2d: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
+			leaf->sub, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
+	} else {
+		printf("0x%08x: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
+			leaf->index, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
+	}
+}
+
+static void cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
+			u32 a, u32 b, u32 c, u32 d)
+{
+	struct cpuid_func *func;
+	struct subleaf *leaf;
+	int s = 0;
+
+	if (a == 0 && b == 0 && c == 0 && d == 0)
+		return;
+
+	/*
+	 * Cut off vendor-prefix from CPUID function as we're using it as an
+	 * index into ->funcs.
+	 */
+	func = &range->funcs[f & 0xffff];
+
+	if (!func->leafs) {
+		func->leafs = malloc(sizeof(struct subleaf));
+		if (!func->leafs)
+			perror("malloc func leaf");
+
+		func->nr = 1;
+	} else {
+		s = func->nr;
+		func->leafs = realloc(func->leafs, (s + 1) * sizeof(struct subleaf));
+		if (!func->leafs)
+			perror("realloc f->leafs");
+
+		func->nr++;
+	}
+
+	leaf = &func->leafs[s];
+
+	leaf->index = f;
+	leaf->sub = subleaf;
+	leaf->eax = a;
+	leaf->ebx = b;
+	leaf->ecx = c;
+	leaf->edx = d;
+}
+
+static void raw_dump_range(struct cpuid_range *range)
+{
+	u32 f;
+	int i;
+
+	printf("\n%s Leafs :\n", range->is_ext ? "Extended" : "Basic");
+	printf("================\n");
+
+	for (f = 0; (int)f < range->nr; f++) {
+		struct cpuid_func *func = &range->funcs[f];
+		u32 index = f;
+
+		if (range->is_ext)
+			index += 0x80000000;
+
+		if (!func->nr) {
+			printf("0x%08x: ...\n", f);
+		} else {
+			for (i = 0; i < func->nr; i++)
+				leaf_print_raw(&func->leafs[i]);
+		}
+	}
+}
+
+struct cpuid_range *setup_cpuid_range(u32 input_eax)
+{
+	u32 max_func, idx_func;
+	int subleaf;
+	struct cpuid_range *range;
+	u32 eax, ebx, ecx, edx;
+	u32 f = input_eax;
+
+	eax = input_eax;
+	ebx = ecx = edx = 0;
+
+	cpuid(&eax, &ebx, &ecx, &edx);
+	max_func = eax;
+	idx_func = (max_func & 0xffff) + 1;
+
+	range = malloc(sizeof(struct cpuid_range));
+	if (!range)
+		perror("malloc range");
+
+	if (input_eax & 0x80000000)
+		range->is_ext = true;
+	else
+		range->is_ext = false;
+
+	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
+	if (!range->funcs)
+		perror("malloc range->funcs");
+
+	range->nr = idx_func;
+	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
+
+	for (; f <= max_func; f++) {
+		eax = f;
+		subleaf = ecx = 0;
+
+		cpuid(&eax, &ebx, &ecx, &edx);
+		cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
+		num_leafs++;
+
+		if (!has_subleafs(f))
+			continue;
+
+		for (subleaf = 1; subleaf < 64; subleaf++) {
+			eax = f;
+			ecx = subleaf;
+
+			cpuid(&eax, &ebx, &ecx, &edx);
+
+			/* is subleaf valid? */
+			if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0)
+				continue;
+
+			cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
+			num_leafs++;
+		}
+	}
+
+	return range;
+}
+
+/*
+ * The basic row format for cpuid.csv  is
+ *	LEAF,SUBLEAF,register_name,bits,short name,long description
+ *
+ * like:
+ *	0,    0,  EAX,   31:0, max_basic_leafs,  Max input value for supported subleafs
+ *	1,    0,  ECX,      0, sse3,  Streaming SIMD Extensions 3(SSE3)
+ */
+static int parse_line(char *line)
+{
+	char *str;
+	int i;
+	struct cpuid_range *range;
+	struct cpuid_func *func;
+	struct subleaf *leaf;
+	u32 index;
+	u32 sub;
+	char buffer[512];
+	char *buf;
+	/*
+	 * Tokens:
+	 *  1. leaf
+	 *  2. subleaf
+	 *  3. register
+	 *  4. bits
+	 *  5. short name
+	 *  6. long detail
+	 */
+	char *tokens[6];
+	struct reg_desc *reg;
+	struct bits_desc *bdesc;
+	int reg_index;
+	char *start, *end;
+
+	/* Skip comments and NULL line */
+	if (line[0] == '#' || line[0] == '\n')
+		return 0;
+
+	strncpy(buffer, line, 511);
+	buffer[511] = 0;
+	str = buffer;
+	for (i = 0; i < 5; i++) {
+		tokens[i] = strtok(str, ",");
+		if (!tokens[i])
+			goto err_exit;
+		str = NULL;
+	}
+	tokens[5] = strtok(str, "\n");
+
+	/* index/main-leaf */
+	index = strtoull(tokens[0], NULL, 0);
+
+	if (index & 0x80000000)
+		range = leafs_ext;
+	else
+		range = leafs_basic;
+
+	index &= 0x7FFFFFFF;
+	if ((int)index > range->nr) {
+		printf("ERR: invalid index[0x%x] nr:%d\n",
+				index,
+				range->nr);
+		return -1;
+	}
+
+	func = &range->funcs[index];
+
+	/* subleaf */
+	sub = strtoul(tokens[1], NULL, 0);
+	if ((int)sub > func->nr)  {
+		printf("ERR: invalid subleaf[%d]\n", sub);
+		return -1;
+	}
+
+	leaf = &func->leafs[sub];
+	buf = tokens[2];
+
+	if (strcasestr(buf, "EAX"))
+		reg_index = R_EAX;
+	else if (strcasestr(buf, "EBX"))
+		reg_index = R_EBX;
+	else if (strcasestr(buf, "ECX"))
+		reg_index = R_ECX;
+	else if (strcasestr(buf, "EDX"))
+		reg_index = R_EDX;
+	else
+		goto err_exit;
+
+	reg = &leaf->info[reg_index];
+	bdesc = &reg->descs[reg->nr++];
+
+	/* bit flag or bits field */
+	buf = tokens[3];
+
+	end = strtok(buf, ":");
+	bdesc->end = strtoul(end, NULL, 0);
+	bdesc->start = bdesc->end;
+
+	/* start != NULL means it is bit fields */
+	start = strtok(NULL, ":");
+	if (start)
+		bdesc->start = strtoul(start, NULL, 0);
+
+	strcpy(bdesc->simp, tokens[4]);
+	strcpy(bdesc->detail, tokens[5]);
+	return 0;
+
+err_exit:
+	printf("Warning: wrong line format:\n");
+	printf("\tline[%d]: %s\n", flines, line);
+	return -1;
+}
+
+/*
+ * Parse text file, and construct the array of all CPUID leafs and subleafs
+ */
+static void parse_text(void)
+{
+	FILE *file;
+	char *filename, *line = NULL;
+	size_t len = 0;
+	int ret;
+
+	if (show_raw)
+		return;
+
+	filename = user_csv ? user_csv : def_csv;
+	file = fopen(filename, "r");
+	if (!file) {
+		printf("Fail to open '%s'\n", filename);
+		return;
+	}
+
+	while (1) {
+
+		ret = getline(&line, &len, file);
+		flines++;
+		if (ret > 0)
+			parse_line(line);
+
+		if (feof(file))
+			break;
+	}
+
+	fclose(file);
+}
+
+
+/* parse every eax/ebx/ecx/edx */
+static void decode_bits(u32 value, struct reg_desc *rdesc)
+{
+	struct bits_desc *bdesc;
+	int start, end, i;
+	u32 mask;
+
+	for (i = 0; i < rdesc->nr; i++) {
+		bdesc = &rdesc->descs[i];
+
+		start = bdesc->start;
+		end = bdesc->end;
+		if (start == end) {
+			/* single bit flag */
+			if (value & (1 << start)) {
+				printf("\t%-20s %s%s\n",
+					bdesc->simp,
+					show_details ? "-" : "",
+					show_details ? bdesc->detail : ""
+					);
+			}
+		} else {
+			/* bit fields */
+			if (show_flags_only)
+				continue;
+			mask = ((u64)1 << (end - start + 1)) - 1;
+			printf("\t%-20s\t: 0x%-8x\t%s%s\n",
+					bdesc->simp,
+					(value >> start) & mask,
+					show_details ? "-" : "",
+					show_details ? bdesc->detail : ""
+					);
+		}
+	}
+}
+
+static void show_leaf(struct subleaf *leaf)
+{
+	if (!leaf)
+		return;
+
+	decode_bits(leaf->eax, &leaf->info[R_EAX]);
+	decode_bits(leaf->ebx, &leaf->info[R_EBX]);
+	decode_bits(leaf->ecx, &leaf->info[R_ECX]);
+	decode_bits(leaf->edx, &leaf->info[R_EDX]);
+}
+
+static void show_func(struct cpuid_func *func)
+{
+	int i;
+
+	if (!func)
+		return;
+
+	for (i = 0; i < func->nr; i++)
+		show_leaf(&func->leafs[i]);
+}
+
+static void show_range(struct cpuid_range *range)
+{
+	int i;
+
+	for (i = 0; i < range->nr; i++)
+		show_func(&range->funcs[i]);
+}
+
+static inline struct cpuid_func *index_to_func(u32 index)
+{
+	struct cpuid_range *range;
+
+	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
+	index &= 0x7FFFFFFF;
+
+	if (((index & 0xFFFF) + 1) > (u32)range->nr) {
+		printf("ERR: invalid input index (0x%x)\n", index);
+		return NULL;
+	}
+	return &range->funcs[index];
+}
+
+static void show_info(void)
+{
+	struct cpuid_func *func;
+
+	if (show_raw) {
+		/* Show all of the raw output data of running cpuid */
+		raw_dump_range(leafs_basic);
+		raw_dump_range(leafs_ext);
+		return;
+	}
+
+	if (show_all) {
+		show_range(leafs_basic);
+		show_range(leafs_ext);
+		return;
+	}
+
+	/* Show specific leaf/subleaf info */
+	func = index_to_func(user_index);
+	if (!func)
+		return;
+
+	if (user_sub != 0xFFFFFFFF) {
+		if (user_sub + 1 <= (u32)func->nr) {
+			show_leaf(&func->leafs[user_sub]);
+			return;
+		}
+
+		printf("ERR: invalid input index (0x%x)\n", user_sub);
+	}
+
+	show_func(func);
+}
+
+static void setup_platform_cpuid(void)
+{
+	 u32 eax, ebx, ecx, edx;
+
+	/* check vendor */
+	eax = ebx = ecx = edx = 0;
+	cpuid(&eax, &ebx, &ecx, &edx);
+
+	/* "htuA" */
+	if (ebx == 0x68747541)
+		is_amd = true;
+
+	/* setup leafs by getting the base and extended range */
+	leafs_basic = setup_cpuid_range(0x0);
+	leafs_ext = setup_cpuid_range(0x80000000);
+	printf("This platform has %d CPUID leafs and subleafs.\n\n",
+		num_leafs);
+}
+
+static void usage(void)
+{
+	printf("  usage: kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
+		"\t-a|--all             Show info of all CPUID leafs and subleafs(default on)\n"
+		"\t-b|--bitflags        Show boolean flags only\n"
+		"\t-d|--detail          Show details of the flag/fields\n"
+		"\t-f|--flags           Show boolean flags only\n"
+		"\t-h|--help            Show usage info\n"
+		"\t-l|--leaf=index      Specify the leaf you want to check\n"
+		"\t-r|--raw             Show raw cpuid data\n"
+		"\t-s|--subleaf=sub     Specify the subleaf you want to check\n"
+		"\n"
+	);
+}
+
+struct option opts[] = {
+	{ "all", no_argument, NULL, 'a' },		/* show all leafs */
+	{ "bitflags", no_argument, NULL, 'b' },		/* only show bit flags */
+	{ "detail", no_argument, NULL, 'd' },		/* show detail descriptions, default no */
+	{ "file", required_argument, NULL, 'f' },	/* use user's cpuid file */
+	{ "help", no_argument, NULL, 'h'},		/* show usage */
+	{ "leaf", required_argument, NULL, 'l'},	/* only check a specific leaf */
+	{ "raw", no_argument, NULL, 'r'},		/* show raw CPUID leaf data */
+	{ "subleaf", required_argument, NULL, 's'},	/* check a specific subleaf */
+	{ NULL, 0, NULL, 0 }
+};
+
+static int parse_options(int argc, char *argv[])
+{
+	int c;
+
+	while ((c = getopt_long(argc, argv, "abdf:hl:rs:",
+					opts, NULL)) != -1)
+		switch (c) {
+		case 'a':
+			show_all = true;
+			break;
+		case 'b':
+			show_flags_only = true;
+			break;
+		case 'd':
+			show_details = true;
+			break;
+		case 'f':
+			user_csv = optarg;
+			break;
+		case 'h':
+			usage();
+			exit(1);
+			break;
+		case 'l':
+			user_index = strtoul(optarg, NULL, 0);
+			show_all = false;
+			break;
+		case 'r':
+			show_raw = true;
+			break;
+		case 's':
+			/* parse_subleaf */
+			user_sub = strtoul(optarg, NULL, 0);
+			break;
+		default:
+			printf("%s: Invalid option '%c'\n", argv[0], optopt);
+			return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Do 4 things in turn:
+ * 1. Parse user options
+ * 2. Parse and store all the CPUID leaf data supported on this platform
+ * 2. Parse the text file according, skip leafs which is not available
+ *    on this platform
+ * 3. Print leafs info based on uers options
+ */
+int main(int argc, char *argv[])
+{
+	if (parse_options(argc, argv))
+		return -1;
+
+	/* setup the cpuid leafs of current platform */
+	setup_platform_cpuid();
+
+	/* read and parse the 'cpuid.csv' */
+	parse_text();
+
+	show_info();
+	return 0;
+}
-- 
2.7.4

