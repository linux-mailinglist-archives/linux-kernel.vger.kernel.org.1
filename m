Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0C32B8C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKSHVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:21:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:21940 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKSHVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:21:00 -0500
IronPort-SDR: WqoW3KOrSWPPtTcSpg2D/p36NxXrnBNMA7o3YhG5je8KP9ixvVDLYNyH8+FvjkSNcYoRBiApzY
 e7rraoKfljFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="158279545"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="c'?scan'208";a="158279545"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 23:20:59 -0800
IronPort-SDR: 978Lo2YPfWt5dcbYMzHacSPighx+8/nS/mnfct0m6otnneN8fv2tFt2UlTw8RPBUXerFn61g2p
 tNytsyX2+ZLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="c'?scan'208";a="544893212"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2020 23:20:56 -0800
Date:   Thu, 19 Nov 2020 15:20:55 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nivedita@alum.mit.edu,
        thomas.lendacky@amd.com, yazen.ghannam@amd.com, wei.huang2@amd.com
Subject: Re: [RFC PATCH v3] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20201119072055.GA112648@shbuild999.sh.intel.com>
References: <1603344083-100742-1-git-send-email-feng.tang@intel.com>
 <20201118191529.GN7472@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201118191529.GN7472@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Borislav,

Thanks for reviewing and trying.

On Wed, Nov 18, 2020 at 08:15:29PM +0100, Borislav Petkov wrote:
> On Thu, Oct 22, 2020 at 01:21:23PM +0800, Feng Tang wrote:
> > diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
> > new file mode 100644
> > index 0000000..9bd35b7
> > --- /dev/null
> > +++ b/tools/arch/x86/kcpuid/kcpuid.c
> > @@ -0,0 +1,618 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> You need here:
> 
> #define _GNU_SOURCE

Thanks for the fix.


> otherwise:
> 
> cc -Wextra -O2 -Wall -I../../../include -o kcpuid kcpuid.c 
> kcpuid.c: In function ‘parse_line’:
> kcpuid.c:324:6: warning: implicit declaration of function ‘strcasestr’; did you mean ‘strcasecmp’? [-Wimplicit-function-declaration]
>   324 |  if (strcasestr(buf, "EAX"))
>       |      ^~~~~~~~~~
>       |      strcasecmp
 
 
> Also, options text needs fixing:
> 
>   usage: kcpuid [-abdfhr] [-l leaf] [-s subleaf]
>         -a|--all             Show info of all CPUID leafs and subleafs(default on)
>         -b|--bitflags        Show boolean flags only
>         -d|--detail          Show details of the flag/fields
>         -f|--flags           Show boolean flags only
> 
> that f is user_csv, above in the "usage" line too.
> 
>         -h|--help            Show usage info
>         -l|--leaf=index      Specify the leaf you want to check
>         -r|--raw             Show raw cpuid data
>         -s|--subleaf=sub     Specify the subleaf you want to check
 
Will fix.

> > +/*
> > + * Parse text file, and construct the array of all CPUID leafs and subleafs
> > + */
> > +static void parse_text(void)
> > +{
> > +	FILE *file;
> > +	char *filename, *line = NULL;
> 
> Do here:
> 
> 	char *filename = def_csv;
> 
> > +	size_t len = 0;
> > +	int ret;
> > +
> > +	if (show_raw)
> > +		return;
> > +
> > +	filename = user_csv ? user_csv : def_csv;
> 
> And now you do:
> 
> 	if (user_csv)
> 		filename = user_csv;

Ok, will change.

 
> But something's not working still. I've added debug output and it chokes
> on the test data:
> 
> $ ./kcpuid -f cpuid.csv 
> This platform has 51 CPUID leafs and subleafs.
> 
> parse_text: filename: cpuid.csv
> open
> parsing [# The basic row format is:
> ]parsing [# LEAF,SUBLEAF,register_name,bits,short name,long description
> ]parsing [
> ]parsing [# Leaf 00H
> ]parsing [         0,    0,  EAX,   31:0, max_basic_leafs,  Max input value for supported subleafs
> ]parsing [# Leaf 01H
> ]parsing [         1,    0,  ECX,     28, avx,  AVX instruction supported
> ]parsing [         1,    0,  ECX,     29, f16c,  16-bit floating-point conversion instruction supported
> ]parsing [         1,    0,  ECX,     30, rdrand,  RDRAND instruction supported
> ]parsing [
> ]parsing [#
> ]parsing [# !!! Test data for testing different options, will be updated in formal version
> ]parsing [#
> ]parsing [         4,    0,  ECX,      1, aaa,  AAA
> Segmentation fault

I just tried the patch on one Debian 9 and 2 Ubuntus (16.04 & 20.10) with
different gcc versions, and haven't reproduced it yet. What's your distro
and gcc version? I will try to reproduce. 

One thing I doubted is the getline() in parse_text() needs a accompany
free() according to its man page, but it can be added after the loop.

Anyway I attached one debug verison kcpuid.c which prints more info, thanks.

- Feng

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

--VS++wcV0S1rZb1Fb
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="kcpuid.c"

// SPDX-License-Identifier: GPL-2.0

#define _GNU_SOURCE
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

typedef unsigned int u32;
typedef unsigned long long u64;

char *def_csv = "/usr/share/hwdata/cpuid.csv";
char *user_csv;

struct bits_desc {
	int start, end;		/* start and end bits */
	int value;		/* 0 or 1 for 1-bit flag */
	char simp[32];
	char detail[256];
};

/* Descriptor info for eax/ebx/ecx/edx */
struct reg_desc {
	int nr;		/* number of valid entries */
	struct bits_desc descs[32];
};

enum {
	R_EAX = 0,
	R_EBX,
	R_ECX,
	R_EDX,
	NR_REGS
};

struct subleaf {
	u32 index;
	u32 sub;
	u32 eax, ebx, ecx, edx;
	struct reg_desc info[NR_REGS];	/* eax, ebx, ecx, edx */
};

/* cpuid_func represents one leaf (basic or extended) */
struct cpuid_func {
	/*
	 * Array of subleafs for this func, if there is no subleafs
	 * then the leafs[0] is the main leaf
	 */
	struct subleaf *leafs;
	int nr;
};

struct cpuid_range {
	/* Array of leafs in this range */
	struct cpuid_func *funcs;
	/* Number of valid leafs */
	int nr;
	bool is_ext;
};

/*
 * basic:  basic functions started from 0
 * ext:    extended functions started from 0x80000000
 */
struct cpuid_range *leafs_basic, *leafs_ext;

static int num_leafs;
static bool is_amd;
static bool show_details;
static bool show_all = true;
static bool show_raw;
static bool show_flags_only;

static u32 user_index = 0xFFFFFFFF;
static u32 user_sub = 0xFFFFFFFF;
static int flines;

static inline void cpuid(u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
{
	/* ecx is often an input as well as an output. */
	asm volatile("cpuid"
	    : "=a" (*eax),
	      "=b" (*ebx),
	      "=c" (*ecx),
	      "=d" (*edx)
	    : "0" (*eax), "2" (*ecx));
}

static inline bool has_subleafs(u32 f)
{
	if (f == 0x7 || f == 0xd)
		return true;

	if (is_amd) {
		if (f == 0x8000001d)
			return true;
		return false;
	}

	if (f == 0x4 || f == 0xf || f == 0x10 || f == 0x14)
		return true;

	return false;
}

static void leaf_print_raw(struct subleaf *leaf)
{
	if (has_subleafs(leaf->index)) {
		if (leaf->sub == 0)
			printf("0x%08x: subleafs:\n", leaf->index);

		printf(" %2d: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
			leaf->sub, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
	} else {
		printf("0x%08x: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
			leaf->index, leaf->eax, leaf->ebx, leaf->ecx, leaf->edx);
	}
}

static void cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
			u32 a, u32 b, u32 c, u32 d)
{
	struct cpuid_func *func;
	struct subleaf *leaf;
	int s = 0;

	if (a == 0 && b == 0 && c == 0 && d == 0)
		return;

	/*
	 * Cut off vendor-prefix from CPUID function as we're using it as an
	 * index into ->funcs.
	 */
	func = &range->funcs[f & 0xffff];

	if (!func->leafs) {
		func->leafs = malloc(sizeof(struct subleaf));
		if (!func->leafs)
			perror("malloc func leaf");

		func->nr = 1;
	} else {
		s = func->nr;
		func->leafs = realloc(func->leafs, (s + 1) * sizeof(struct subleaf));
		if (!func->leafs)
			perror("realloc f->leafs");

		func->nr++;
	}

	leaf = &func->leafs[s];

	leaf->index = f;
	leaf->sub = subleaf;
	leaf->eax = a;
	leaf->ebx = b;
	leaf->ecx = c;
	leaf->edx = d;
}

static void raw_dump_range(struct cpuid_range *range)
{
	u32 f;
	int i;

	printf("\n%s Leafs :\n", range->is_ext ? "Extended" : "Basic");
	printf("================\n");

	for (f = 0; (int)f < range->nr; f++) {
		struct cpuid_func *func = &range->funcs[f];
		u32 index = f;

		if (range->is_ext)
			index += 0x80000000;

		if (!func->nr) {
			printf("0x%08x: ...\n", f);
		} else {
			for (i = 0; i < func->nr; i++)
				leaf_print_raw(&func->leafs[i]);
		}
	}
}

struct cpuid_range *setup_cpuid_range(u32 input_eax)
{
	u32 max_func, idx_func;
	int subleaf;
	struct cpuid_range *range;
	u32 eax, ebx, ecx, edx;
	u32 f = input_eax;

	eax = input_eax;
	ebx = ecx = edx = 0;

	cpuid(&eax, &ebx, &ecx, &edx);
	max_func = eax;
	idx_func = (max_func & 0xffff) + 1;

	range = malloc(sizeof(struct cpuid_range));
	if (!range)
		perror("malloc range");

	if (input_eax & 0x80000000)
		range->is_ext = true;
	else
		range->is_ext = false;

	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
	if (!range->funcs)
		perror("malloc range->funcs");

	range->nr = idx_func;
	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);

	for (; f <= max_func; f++) {
		eax = f;
		subleaf = ecx = 0;

		cpuid(&eax, &ebx, &ecx, &edx);
		cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
		num_leafs++;

		if (!has_subleafs(f))
			continue;

		for (subleaf = 1; subleaf < 64; subleaf++) {
			eax = f;
			ecx = subleaf;

			cpuid(&eax, &ebx, &ecx, &edx);

			/* is subleaf valid? */
			if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0)
				continue;

			cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
			num_leafs++;
		}
	}

	return range;
}

/*
 * The basic row format for cpuid.csv  is
 *	LEAF,SUBLEAF,register_name,bits,short name,long description
 *
 * like:
 *	0,    0,  EAX,   31:0, max_basic_leafs,  Max input value for supported subleafs
 *	1,    0,  ECX,      0, sse3,  Streaming SIMD Extensions 3(SSE3)
 */
static int parse_line(char *line)
{
	char *str;
	int i;
	struct cpuid_range *range;
	struct cpuid_func *func;
	struct subleaf *leaf;
	u32 index;
	u32 sub;
	char buffer[512];
	char *buf;
	/*
	 * Tokens:
	 *  1. leaf
	 *  2. subleaf
	 *  3. register
	 *  4. bits
	 *  5. short name
	 *  6. long detail
	 */
	char *tokens[6];
	struct reg_desc *reg;
	struct bits_desc *bdesc;
	int reg_index;
	char *start, *end;

	printf("line: %s\n", line);

	/* Skip comments and NULL line */
	if (line[0] == '#' || line[0] == '\n')
		return 0;

	strncpy(buffer, line, 511);
	buffer[511] = 0;
	str = buffer;
	for (i = 0; i < 5; i++) {
		tokens[i] = strtok(str, ",");
		if (!tokens[i])
			goto err_exit;
		str = NULL;
		printf("token[%d]: %s\n", i, tokens[i]);
	}
	tokens[5] = strtok(str, "\n");
	printf("token[5]: %s\n", tokens[5]);

	/* index/main-leaf */
	index = strtoull(tokens[0], NULL, 0);

	if (index & 0x80000000)
		range = leafs_ext;
	else
		range = leafs_basic;

	index &= 0x7FFFFFFF;
	if ((int)index > range->nr) {
		printf("ERR: invalid index[0x%x] nr:%d\n",
				index,
				range->nr);
		return -1;
	}

	func = &range->funcs[index];

	/* subleaf */
	sub = strtoul(tokens[1], NULL, 0);
	if ((int)sub > func->nr)  {
		printf("ERR: invalid subleaf[%d]\n", sub);
		return -1;
	}

	leaf = &func->leafs[sub];
	buf = tokens[2];

	if (strcasestr(buf, "EAX"))
		reg_index = R_EAX;
	else if (strcasestr(buf, "EBX"))
		reg_index = R_EBX;
	else if (strcasestr(buf, "ECX"))
		reg_index = R_ECX;
	else if (strcasestr(buf, "EDX"))
		reg_index = R_EDX;
	else
		goto err_exit;

	reg = &leaf->info[reg_index];
	bdesc = &reg->descs[reg->nr++];

	/* bit flag or bits field */
	buf = tokens[3];

	end = strtok(buf, ":");
	bdesc->end = strtoul(end, NULL, 0);
	bdesc->start = bdesc->end;

	/* start != NULL means it is bit fields */
	start = strtok(NULL, ":");
	if (start)
		bdesc->start = strtoul(start, NULL, 0);

	printf("end: %s, start:%s [%d:%d]\n",
		end, start, bdesc->end, bdesc->start);


	strcpy(bdesc->simp, tokens[4]);
	strcpy(bdesc->detail, tokens[5]);
	return 0;

err_exit:
	printf("Warning: wrong line format:\n");
	printf("\tline[%d]: %s\n", flines, line);
	return -1;
}

/*
 * Parse text file, and construct the array of all CPUID leafs and subleafs
 */
static void parse_text(void)
{
	FILE *file;
	char *filename, *line = NULL;
	size_t len = 0;
	int ret;

	filename = def_csv;

	if (show_raw)
		return;

	if (user_csv)
		filename = user_csv;
	//filename = user_csv ? user_csv : def_csv;
	file = fopen(filename, "r");
	if (!file) {
		printf("Fail to open '%s'\n", filename);
		return;
	}

	while (1) {

		ret = getline(&line, &len, file);
		flines++;
		if (ret > 0)
			parse_line(line);

		if (feof(file))
			break;
	}

	fclose(file);
}


/* parse every eax/ebx/ecx/edx */
static void decode_bits(u32 value, struct reg_desc *rdesc)
{
	struct bits_desc *bdesc;
	int start, end, i;
	u32 mask;

	for (i = 0; i < rdesc->nr; i++) {
		bdesc = &rdesc->descs[i];

		start = bdesc->start;
		end = bdesc->end;
		if (start == end) {
			/* single bit flag */
			if (value & (1 << start)) {
				printf("\t%-20s %s%s\n",
					bdesc->simp,
					show_details ? "-" : "",
					show_details ? bdesc->detail : ""
					);
			}
		} else {
			/* bit fields */
			if (show_flags_only)
				continue;
			mask = ((u64)1 << (end - start + 1)) - 1;
			printf("\t%-20s\t: 0x%-8x\t%s%s\n",
					bdesc->simp,
					(value >> start) & mask,
					show_details ? "-" : "",
					show_details ? bdesc->detail : ""
					);
		}
	}
}

static void show_leaf(struct subleaf *leaf)
{
	if (!leaf)
		return;

	decode_bits(leaf->eax, &leaf->info[R_EAX]);
	decode_bits(leaf->ebx, &leaf->info[R_EBX]);
	decode_bits(leaf->ecx, &leaf->info[R_ECX]);
	decode_bits(leaf->edx, &leaf->info[R_EDX]);
}

static void show_func(struct cpuid_func *func)
{
	int i;

	if (!func)
		return;

	for (i = 0; i < func->nr; i++)
		show_leaf(&func->leafs[i]);
}

static void show_range(struct cpuid_range *range)
{
	int i;

	for (i = 0; i < range->nr; i++)
		show_func(&range->funcs[i]);
}

static inline struct cpuid_func *index_to_func(u32 index)
{
	struct cpuid_range *range;

	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
	index &= 0x7FFFFFFF;

	if (((index & 0xFFFF) + 1) > (u32)range->nr) {
		printf("ERR: invalid input index (0x%x)\n", index);
		return NULL;
	}
	return &range->funcs[index];
}

static void show_info(void)
{
	struct cpuid_func *func;

	if (show_raw) {
		/* Show all of the raw output data of running cpuid */
		raw_dump_range(leafs_basic);
		raw_dump_range(leafs_ext);
		return;
	}

	if (show_all) {
		show_range(leafs_basic);
		show_range(leafs_ext);
		return;
	}

	/* Show specific leaf/subleaf info */
	func = index_to_func(user_index);
	if (!func)
		return;

	if (user_sub != 0xFFFFFFFF) {
		if (user_sub + 1 <= (u32)func->nr) {
			show_leaf(&func->leafs[user_sub]);
			return;
		}

		printf("ERR: invalid input index (0x%x)\n", user_sub);
	}

	show_func(func);
}

static void setup_platform_cpuid(void)
{
	 u32 eax, ebx, ecx, edx;

	/* check vendor */
	eax = ebx = ecx = edx = 0;
	cpuid(&eax, &ebx, &ecx, &edx);

	/* "htuA" */
	if (ebx == 0x68747541)
		is_amd = true;

	/* setup leafs by getting the base and extended range */
	leafs_basic = setup_cpuid_range(0x0);
	leafs_ext = setup_cpuid_range(0x80000000);
	printf("This platform has %d CPUID leafs and subleafs.\n\n",
		num_leafs);
}

static void usage(void)
{
	printf("  usage: kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
		"\t-a|--all             Show info of all CPUID leafs and subleafs(default on)\n"
		"\t-b|--bitflags        Show boolean flags only\n"
		"\t-d|--detail          Show details of the flag/fields\n"
		"\t-f|--flags           Show boolean flags only\n"
		"\t-h|--help            Show usage info\n"
		"\t-l|--leaf=index      Specify the leaf you want to check\n"
		"\t-r|--raw             Show raw cpuid data\n"
		"\t-s|--subleaf=sub     Specify the subleaf you want to check\n"
		"\n"
	);
}

struct option opts[] = {
	{ "all", no_argument, NULL, 'a' },		/* show all leafs */
	{ "bitflags", no_argument, NULL, 'b' },		/* only show bit flags */
	{ "detail", no_argument, NULL, 'd' },		/* show detail descriptions, default no */
	{ "file", required_argument, NULL, 'f' },	/* use user's cpuid file */
	{ "help", no_argument, NULL, 'h'},		/* show usage */
	{ "leaf", required_argument, NULL, 'l'},	/* only check a specific leaf */
	{ "raw", no_argument, NULL, 'r'},		/* show raw CPUID leaf data */
	{ "subleaf", required_argument, NULL, 's'},	/* check a specific subleaf */
	{ NULL, 0, NULL, 0 }
};

static int parse_options(int argc, char *argv[])
{
	int c;

	while ((c = getopt_long(argc, argv, "abdf:hl:rs:",
					opts, NULL)) != -1)
		switch (c) {
		case 'a':
			show_all = true;
			break;
		case 'b':
			show_flags_only = true;
			break;
		case 'd':
			show_details = true;
			break;
		case 'f':
			user_csv = optarg;
			break;
		case 'h':
			usage();
			exit(1);
			break;
		case 'l':
			user_index = strtoul(optarg, NULL, 0);
			show_all = false;
			break;
		case 'r':
			show_raw = true;
			break;
		case 's':
			/* parse_subleaf */
			user_sub = strtoul(optarg, NULL, 0);
			break;
		default:
			printf("%s: Invalid option '%c'\n", argv[0], optopt);
			return -1;
	}

	return 0;
}

/*
 * Do 4 things in turn:
 * 1. Parse user options
 * 2. Parse and store all the CPUID leaf data supported on this platform
 * 2. Parse the text file according, skip leafs which is not available
 *    on this platform
 * 3. Print leafs info based on uers options
 */
int main(int argc, char *argv[])
{
	if (parse_options(argc, argv))
		return -1;

	/* setup the cpuid leafs of current platform */
	setup_platform_cpuid();

	/* read and parse the 'cpuid.csv' */
	parse_text();

	show_info();
	return 0;
}

--VS++wcV0S1rZb1Fb--
