Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069E12FC185
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbhASUrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:47:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:26412 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730467AbhASUpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:45:36 -0500
IronPort-SDR: JYevjJXAEzJXZNqfxLLt0p4iWMhnDrvLvXVdLOUzLzfkA0lz0Wfvotjf6rwMOl/4CgtlME/R+S
 kUsVkFS4Hf2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="243064935"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="243064935"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 12:42:07 -0800
IronPort-SDR: 9IiZqPzdLsdFrf546gXeavUjuKmN0UnsM2y66tDNnr1ICS8pwqRK0Ipa6AUGimFJ/WWfHIy8NC
 nJ49pRU6xGRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="365990804"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2021 12:42:07 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 06/12] perf tools: Support data block and addr block
Date:   Tue, 19 Jan 2021 12:38:25 -0800
Message-Id: <1611088711-17177-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Two new data source fields, to indicate the block reasons of a load
instruction, are introduced on the Intel Sapphire Rapids server. The
fields can be used by the memory profiling.

Add a new sort function, SORT_MEM_BLOCKED, for the two fields.

For the previous platforms or the block reason is unknown, print "N/A"
for the block reason.

Add blocked as a default mem sort key for perf report and
perf mem report.

An auxiliary event has to be enabled simultaneously with the load
latency event to retrieve complete Memory Info. Add X86 specific
perf_mem_events__name() to handle the auxiliary event.
- Users are only interested in the samples of the mem-loads event.
  Sample read the auxiliary event.
- The auxiliary event must be in front of the load latency event in a
  group. Assume the second event to sample if the auxiliary event is the
  leader.
- Add a weak is_mem_loads_aux_event() to check the auxiliary event for
  X86. For other ARCH, it always return false.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt  |  5 ++--
 tools/perf/arch/x86/util/Build            |  1 +
 tools/perf/arch/x86/util/mem-events.c     | 44 +++++++++++++++++++++++++++++++
 tools/perf/builtin-mem.c                  |  2 +-
 tools/perf/util/evsel.c                   |  2 ++
 tools/perf/util/hist.c                    |  1 +
 tools/perf/util/hist.h                    |  1 +
 tools/perf/util/mem-events.c              | 30 +++++++++++++++++++++
 tools/perf/util/mem-events.h              |  3 +++
 tools/perf/util/perf_event_attr_fprintf.c |  2 +-
 tools/perf/util/record.c                  |  4 ++-
 tools/perf/util/sort.c                    | 38 +++++++++++++++++++++++++-
 tools/perf/util/sort.h                    |  1 +
 13 files changed, 128 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/mem-events.c

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 8f7f4e9..826b5a9 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -139,7 +139,7 @@ OPTIONS
 
 	If the --mem-mode option is used, the following sort keys are also available
 	(incompatible with --branch-stack):
-	symbol_daddr, dso_daddr, locked, tlb, mem, snoop, dcacheline.
+	symbol_daddr, dso_daddr, locked, tlb, mem, snoop, dcacheline, blocked.
 
 	- symbol_daddr: name of data symbol being executed on at the time of sample
 	- dso_daddr: name of library or module containing the data being executed
@@ -151,9 +151,10 @@ OPTIONS
 	- dcacheline: the cacheline the data address is on at the time of the sample
 	- phys_daddr: physical address of data being executed on at the time of sample
 	- data_page_size: the data page size of data being executed on at the time of sample
+	- blocked: reason of blocked load access for the data at the time of the sample
 
 	And the default sort keys are changed to local_weight, mem, sym, dso,
-	symbol_daddr, dso_daddr, snoop, tlb, locked, see '--mem-mode'.
+	symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, see '--mem-mode'.
 
 	If the data file has tracepoint event(s), following (dynamic) sort keys
 	are also available:
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 347c39b..d73f548 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -6,6 +6,7 @@ perf-y += perf_regs.o
 perf-y += topdown.o
 perf-y += machine.o
 perf-y += event.o
+perf-y += mem-events.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
new file mode 100644
index 0000000..c21dce3
--- /dev/null
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "util/pmu.h"
+#include "map_symbol.h"
+#include "mem-events.h"
+
+static char mem_loads_name[100];
+static bool mem_loads_name__init;
+
+#define MEM_LOADS_AUX		0x0203
+#define MEM_LOADS_AUX_NAME	"{cpu/mem-loads-aux/,cpu/mem-loads,ldlat=%u/}:SP"
+
+bool is_mem_loads_aux_event(struct evsel *leader)
+{
+	if (!pmu_have_event("cpu", "mem-loads-aux"))
+		return false;
+
+	return leader->core.attr.config == MEM_LOADS_AUX;
+}
+
+char *perf_mem_events__name(int i)
+{
+	struct perf_mem_event *e = perf_mem_events__ptr(i);
+
+	if (!e)
+		return NULL;
+
+	if (i == PERF_MEM_EVENTS__LOAD) {
+		if (mem_loads_name__init)
+			return mem_loads_name;
+
+		mem_loads_name__init = true;
+
+		if (pmu_have_event("cpu", "mem-loads-aux")) {
+			scnprintf(mem_loads_name, sizeof(MEM_LOADS_AUX_NAME),
+				  MEM_LOADS_AUX_NAME, perf_mem_events__loads_ldlat);
+		} else {
+			scnprintf(mem_loads_name, sizeof(mem_loads_name),
+				  e->name, perf_mem_events__loads_ldlat);
+		}
+		return mem_loads_name;
+	}
+
+	return (char *)e->name;
+}
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 8237420..e5778aa 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -312,7 +312,7 @@ static char *get_sort_order(struct perf_mem *mem)
 			     "dso_daddr,tlb,locked");
 	} else if (has_extra_options) {
 		strcpy(sort, "--sort=local_weight,mem,sym,dso,symbol_daddr,"
-			     "dso_daddr,snoop,tlb,locked");
+			     "dso_daddr,snoop,tlb,locked,blocked");
 	} else
 		return NULL;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c26ea822..97acde2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2689,6 +2689,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		break;
+	case ENODATA:
+		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. Please add an auxiliary event in front of the load latency event.");
 	default:
 		break;
 	}
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index a08fb9e..7cb4cbe 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -208,6 +208,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_MEM_LVL, 21 + 3);
 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
+	hists__new_col_len(hists, HISTC_MEM_BLOCKED, 7);
 	if (symbol_conf.nanosecs)
 		hists__new_col_len(hists, HISTC_TIME, 16);
 	else
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 14f6633..522486b 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -71,6 +71,7 @@ enum hist_column {
 	HISTC_SYM_SIZE,
 	HISTC_DSO_SIZE,
 	HISTC_SYMBOL_IPC,
+	HISTC_MEM_BLOCKED,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 19007e4..890f638 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -56,6 +56,11 @@ char * __weak perf_mem_events__name(int i)
 	return (char *)e->name;
 }
 
+__weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
+{
+	return false;
+}
+
 int perf_mem_events__parse(const char *str)
 {
 	char *tok, *saveptr = NULL;
@@ -332,6 +337,29 @@ int perf_mem__lck_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 	return l;
 }
 
+int perf_mem__blk_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
+{
+	size_t l = 0;
+	u64 mask = PERF_MEM_BLK_NA;
+
+	sz -= 1; /* -1 for null termination */
+	out[0] = '\0';
+
+	if (mem_info)
+		mask = mem_info->data_src.mem_blk;
+
+	if (!mask || (mask & PERF_MEM_BLK_NA)) {
+		l += scnprintf(out + l, sz - l, " N/A");
+		return l;
+	}
+	if (mask & PERF_MEM_BLK_DATA)
+		l += scnprintf(out + l, sz - l, " Data");
+	if (mask & PERF_MEM_BLK_ADDR)
+		l += scnprintf(out + l, sz - l, " Addr");
+
+	return l;
+}
+
 int perf_script__meminfo_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 {
 	int i = 0;
@@ -343,6 +371,8 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, struct mem_info *mem_in
 	i += perf_mem__tlb_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|LCK ");
 	i += perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
+	i += scnprintf(out + i, sz - i, "|BLK ");
+	i += perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
 
 	return i;
 }
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 5ef1782..5ddf447 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -9,6 +9,7 @@
 #include <linux/refcount.h>
 #include <linux/perf_event.h>
 #include "stat.h"
+#include "evsel.h"
 
 struct perf_mem_event {
 	bool		record;
@@ -39,6 +40,7 @@ int perf_mem_events__init(void);
 
 char *perf_mem_events__name(int i);
 struct perf_mem_event *perf_mem_events__ptr(int i);
+bool is_mem_loads_aux_event(struct evsel *leader);
 
 void perf_mem_events__list(void);
 
@@ -47,6 +49,7 @@ int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
 int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
 int perf_mem__lck_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
+int perf_mem__blk_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
 
 int perf_script__meminfo_scnprintf(char *bf, size_t size, struct mem_info *mem_info);
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index fb0bb66..b393acd 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -35,7 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
-		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE),
+		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE), bit_name(WEIGHT_EXT),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index e70c9dd..9f8c30a 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -15,6 +15,8 @@
 #include "record.h"
 #include "../perf-sys.h"
 #include "topdown.h"
+#include "map_symbol.h"
+#include "mem-events.h"
 
 /*
  * evsel__config_leader_sampling() uses special rules for leader sampling.
@@ -25,7 +27,7 @@ static struct evsel *evsel__read_sampler(struct evsel *evsel, struct evlist *evl
 {
 	struct evsel *leader = evsel->leader;
 
-	if (evsel__is_aux_event(leader) || arch_topdown_sample_read(leader)) {
+	if (evsel__is_aux_event(leader) || arch_topdown_sample_read(leader) || is_mem_loads_aux_event(leader)) {
 		evlist__for_each_entry(evlist, evsel) {
 			if (evsel->leader == leader && evsel != evsel->leader)
 				return evsel;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 80907bc..af7f893 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -36,7 +36,7 @@ const char	default_parent_pattern[] = "^sys_|^do_page_fault";
 const char	*parent_pattern = default_parent_pattern;
 const char	*default_sort_order = "comm,dso,symbol";
 const char	default_branch_sort_order[] = "comm,dso_from,symbol_from,symbol_to,cycles";
-const char	default_mem_sort_order[] = "local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked";
+const char	default_mem_sort_order[] = "local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked";
 const char	default_top_sort_order[] = "dso,symbol";
 const char	default_diff_sort_order[] = "dso,symbol";
 const char	default_tracepoint_sort_order[] = "trace";
@@ -1422,6 +1422,41 @@ struct sort_entry sort_mem_dcacheline = {
 };
 
 static int64_t
+sort__blocked_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	union perf_mem_data_src data_src_l;
+	union perf_mem_data_src data_src_r;
+
+	if (left->mem_info)
+		data_src_l = left->mem_info->data_src;
+	else
+		data_src_l.mem_blk = PERF_MEM_BLK_NA;
+
+	if (right->mem_info)
+		data_src_r = right->mem_info->data_src;
+	else
+		data_src_r.mem_blk = PERF_MEM_BLK_NA;
+
+	return (int64_t)(data_src_r.mem_blk - data_src_l.mem_blk);
+}
+
+static int hist_entry__blocked_snprintf(struct hist_entry *he, char *bf,
+					size_t size, unsigned int width)
+{
+	char out[10];
+
+	perf_mem__blk_scnprintf(out, sizeof(out), he->mem_info);
+	return repsep_snprintf(bf, size, "%.*s", width, out);
+}
+
+struct sort_entry sort_mem_blocked = {
+	.se_header	= "Blocked",
+	.se_cmp		= sort__blocked_cmp,
+	.se_snprintf	= hist_entry__blocked_snprintf,
+	.se_width_idx	= HISTC_MEM_BLOCKED,
+};
+
+static int64_t
 sort__phys_daddr_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	uint64_t l = 0, r = 0;
@@ -1770,6 +1805,7 @@ static struct sort_dimension memory_sort_dimensions[] = {
 	DIM(SORT_MEM_DCACHELINE, "dcacheline", sort_mem_dcacheline),
 	DIM(SORT_MEM_PHYS_DADDR, "phys_daddr", sort_mem_phys_daddr),
 	DIM(SORT_MEM_DATA_PAGE_SIZE, "data_page_size", sort_mem_data_page_size),
+	DIM(SORT_MEM_BLOCKED, "blocked", sort_mem_blocked),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index e50f2b6..2b2645b 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -256,6 +256,7 @@ enum sort_type {
 	SORT_MEM_IADDR_SYMBOL,
 	SORT_MEM_PHYS_DADDR,
 	SORT_MEM_DATA_PAGE_SIZE,
+	SORT_MEM_BLOCKED,
 };
 
 /*
-- 
2.7.4

