Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C8730224F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 08:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbhAYHGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 02:06:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:14294 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbhAYHEs (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 02:04:48 -0500
IronPort-SDR: h3cgrG1tEORqdoI/283WoBEW+FBEcFBIW3GW4DJDklFf8U76pFNOrF7jB5+HD+KoZVcc2VXAUK
 irJOU1SA+jyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="178897346"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="178897346"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 23:03:02 -0800
IronPort-SDR: 3wvmitnMf8oV92Pvay/kJ2ElDsPMFRJYR3rpBXYVVJRtAe4UZE0fZlFCg5q4Ncza8C8IDwJmLJ
 XfHfM5yOEw1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="471907582"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2021 23:03:00 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 1/2] perf script: Support filtering by hex address
Date:   Mon, 25 Jan 2021 07:27:49 +0800
Message-Id: <20210124232750.19170-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf-script supports '-S' or '--symbol' options to only list the
trace records in given symbols. Symbol is typically a name
or hex address. If it's hex address, it is the start address of
one symbol.

While it would be useful if we can filter trace records by any hex
address (not only the start address of symbol). So now we support
filtering trace records by more conditions, such as:
- symbol name
- start address of symbol
- any hexadecimal address
- address range

The comparison order is defined as:

1. symbol name comparison
2. symbol start address comparison.
3. any hexadecimal address comparison.
4. address range comparison.

Let's see some examples:

root@kbl-ppc:~# ./perf script -S 0xffffffff9ca77308
            perf 18123 [000] 6142863.075104:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075107:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075108:         10   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075156:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075158:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075159:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [002] 6142863.075202:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [002] 6142863.075204:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [002] 6142863.075205:         16   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [003] 6142863.075250:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [003] 6142863.075252:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [003] 6142863.075253:         16   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])

Filter the traced records by hex address 0xffffffff9ca77308.

Easy to use, we support the hex address without '0x' prefix,
e.g.
./perf script -S ffffffff9ca77308

It has the same effect.

We also support to filter trace records by a address range.

root@kbl-ppc:~# ./perf script -S ffffffff9ca77304 --addr-range 16
            perf 18123 [000] 6142863.075104:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075107:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075108:         10   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075109:        273   cycles:  ffffffff9ca7730a native_write_msr+0xa ([kernel.kallsyms])
            perf 18123 [001] 6142863.075156:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075158:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075159:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075160:        456   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])
            perf 18123 [002] 6142863.075202:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [002] 6142863.075204:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [002] 6142863.075205:         16   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [002] 6142863.075206:        436   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])
            perf 18123 [003] 6142863.075250:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [003] 6142863.075252:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [003] 6142863.075253:         16   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [003] 6142863.075254:        436   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])
            perf 18123 [004] 6142863.075299:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [004] 6142863.075301:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [004] 6142863.075302:         16   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [004] 6142863.075303:        431   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])
            perf 18123 [005] 6142863.075348:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [005] 6142863.075349:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [005] 6142863.075351:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [005] 6142863.075352:        454   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])
            perf 18123 [006] 6142863.075390:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [006] 6142863.075392:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [006] 6142863.075393:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [006] 6142863.075394:        459   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])
            perf 18123 [007] 6142863.075438:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [007] 6142863.075440:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [007] 6142863.075441:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [007] 6142863.075442:        466   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])

Filter the traced records from address range [0xffffffff9ca77304, 0xffffffff9ca77304 + 15].

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt | 19 +++++++++++++
 tools/perf/builtin-script.c              |  2 ++
 tools/perf/util/event.c                  | 36 ++++++++++++++++++++++++
 tools/perf/util/symbol_conf.h            |  1 +
 4 files changed, 58 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 44d37210fc8f..0ef2261baeb9 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -422,9 +422,28 @@ include::itrace.txt[]
 	Only consider the listed symbols. Symbols are typically a name
 	but they may also be hexadecimal address.
 
+	The hexadecimal address may be the start address of a symbol or
+	any other address to filter the trace records.
+
 	For example, to select the symbol noploop or the address 0x4007a0:
 	perf script --symbols=noploop,0x4007a0
 
+	Support filtering trace records by symbol name, start address of
+	symbol, any hexadecimal address and address range.
+
+	The comparison order is:
+	1. symbol name comparison
+	2. symbol start address comparison.
+	3. any hexadecimal address comparison.
+	4. address range comparison (see --addr-range).
+
+--addr-range::
+	Use with -S or --symbols to list traced records within address range.
+
+	For example, to list the traced records within the address range
+	[0x4007a0, 0x0x4007a9]:
+	perf script -S 0x4007a0 --addr-range 10
+
 --call-trace::
 	Show call stream for intel_pt traces. The CPUs are interleaved, but
 	can be filtered with -C.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index edacfa98d073..e0feda33dbb9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3525,6 +3525,8 @@ int cmd_script(int argc, const char **argv)
 		    "system-wide collection from all CPUs"),
 	OPT_STRING('S', "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
 		   "only consider these symbols"),
+	OPT_INTEGER(0, "addr-range", &symbol_conf.addr_range,
+		    "Use with -S to list traced records within address range"),
 	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
 			"Decode instructions from itrace", parse_insn_trace),
 	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fbe8578e4c47..525b859cb445 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -645,6 +645,22 @@ struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
 	return al->sym;
 }
 
+static bool check_address_range(struct strlist *sym_list, int addr_range,
+				struct addr_location *al)
+{
+	struct str_node *pos;
+	char *endptr;
+	u64 addr, al_addr = al->map->unmap_ip(al->map, al->addr);
+
+	strlist__for_each_entry(pos, sym_list) {
+		addr = strtoull(pos->s, &endptr, 16);
+		if (al_addr >= addr && al_addr < addr + addr_range)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Callers need to drop the reference to al->thread, obtained in
  * machine__findnew_thread()
@@ -709,6 +725,26 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 			ret = strlist__has_entry(symbol_conf.sym_list,
 						al_addr_str);
 		}
+		if (!ret && al->map) {
+			snprintf(al_addr_str, sz, "0x%"PRIx64,
+				al->map->unmap_ip(al->map, al->addr));
+			ret = strlist__has_entry(symbol_conf.sym_list,
+						 al_addr_str);
+			if (!ret) {
+				/* Check for hex without "0x" prefix */
+				snprintf(al_addr_str, sz, "%"PRIx64,
+					al->map->unmap_ip(al->map, al->addr));
+				ret = strlist__has_entry(symbol_conf.sym_list,
+							 al_addr_str);
+			}
+
+			if (!ret && symbol_conf.addr_range) {
+				ret = check_address_range(symbol_conf.sym_list,
+							  symbol_conf.addr_range,
+							  al);
+			}
+		}
+
 		if (!ret)
 			al->filtered |= (1 << HIST_FILTER__SYMBOL);
 	}
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index b18f9c8dbb75..07e247cdb43c 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -75,6 +75,7 @@ struct symbol_conf {
 	int		res_sample;
 	int		pad_output_len_dso;
 	int		group_sort_idx;
+	int		addr_range;
 };
 
 extern struct symbol_conf symbol_conf;
-- 
2.17.1

