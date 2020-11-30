Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462BF2C8B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbgK3Rb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:31:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:3530 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387521AbgK3Rbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:31:55 -0500
IronPort-SDR: seobH1dFO1PR1XUDlz/FkWvhAAPz8pSDfXYWDn2OhSeikfedryvaxNHcdFNhY+tv6bnGy7irZm
 FUKad9/KDu9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151926506"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151926506"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 09:29:01 -0800
IronPort-SDR: yREkqGz9yYjpwaFYMBUYsNsd6Oc8D4WdjC8oXlQY5Su6saccSQNaT0wjDGmF0mlaU5RYiQu5Gj
 H9GhkJAwZ0ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="334736305"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2020 09:29:01 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 04/12] perf sort: Add sort option for data page size
Date:   Mon, 30 Nov 2020 09:27:55 -0800
Message-Id: <20201130172803.2676-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130172803.2676-1-kan.liang@linux.intel.com>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add a new sort option "data_page_size" for --mem-mode sort.  With this
option applied, perf can sort and report by sample's data page size.

Here is an example.
perf report --stdio --mem-mode
--sort=comm,symbol,phys_daddr,data_page_size

 # To display the perf.data header info, please use
 # --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 9K of event 'mem-loads:uP'
 # Total weight : 9028
 # Sort order   : comm,symbol,phys_daddr,data_page_size
 #
 # Overhead  Command  Symbol                        Data Physical
 # Address
 # Data Page Size
 # ........  .......  ............................
 # ......................  ......................
 #
    11.19%  dtlb     [.] touch_buffer              [.]
0x00000003fec82ea8  4K
     8.61%  dtlb     [.] GetTickCount              [.]
0x00000003c4f2c8a8  4K
     4.52%  dtlb     [.] GetTickCount              [.]
0x00000003fec82f58  4K
     4.33%  dtlb     [.] __gettimeofday            [.]
0x00000003fec82f48  4K
     4.32%  dtlb     [.] GetTickCount              [.]
0x00000003fec82f78  4K
     4.28%  dtlb     [.] GetTickCount              [.]
0x00000003fec82f50  4K
     4.23%  dtlb     [.] GetTickCount              [.]
0x00000003fec82f70  4K
     4.11%  dtlb     [.] GetTickCount              [.]
0x00000003fec82f68  4K
     4.00%  dtlb     [.] Calibrate                 [.]
0x00000003fec82f98  4K
     3.91%  dtlb     [.] Calibrate                 [.]
0x00000003fec82f90  4K
     3.43%  dtlb     [.] touch_buffer              [.]
0x00000003fec82e98  4K
     3.42%  dtlb     [.] touch_buffer              [.]
0x00000003fec82e90  4K
     0.09%  dtlb     [.] DoDependentLoads          [.]
0x000000036ea084c0  2M
     0.08%  dtlb     [.] DoDependentLoads          [.]
0x000000032b010b80  2M

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/hist.c                   |  3 +++
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/machine.c                |  7 ++++--
 tools/perf/util/map_symbol.h             |  1 +
 tools/perf/util/sort.c                   | 30 ++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  1 +
 7 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index d068103690cc..8f7f4e9605d8 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -150,6 +150,7 @@ OPTIONS
 	- snoop: type of snoop (if any) for the data at the time of the sample
 	- dcacheline: the cacheline the data address is on at the time of the sample
 	- phys_daddr: physical address of data being executed on at the time of sample
+	- data_page_size: the data page size of data being executed on at the time of sample
 
 	And the default sort keys are changed to local_weight, mem, sym, dso,
 	symbol_daddr, dso_daddr, snoop, tlb, locked, see '--mem-mode'.
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 8a793e4c9400..7829ecd7ea59 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -188,6 +188,9 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		hists__new_col_len(hists, HISTC_MEM_PHYS_DADDR,
 				   unresolved_col_width + 4 + 2);
 
+		hists__new_col_len(hists, HISTC_MEM_DATA_PAGE_SIZE,
+				   unresolved_col_width + 4 + 2);
+
 	} else {
 		symlen = unresolved_col_width + 4 + 2;
 		hists__new_col_len(hists, HISTC_MEM_DADDR_SYMBOL, symlen);
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 96b1c13bbccc..e44cf5bb655f 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -56,6 +56,7 @@ enum hist_column {
 	HISTC_MEM_DADDR_SYMBOL,
 	HISTC_MEM_DADDR_DSO,
 	HISTC_MEM_PHYS_DADDR,
+	HISTC_MEM_DATA_PAGE_SIZE,
 	HISTC_MEM_LOCKED,
 	HISTC_MEM_TLB,
 	HISTC_MEM_LVL,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 1ae32a81639c..f841f3503cae 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2023,11 +2023,12 @@ static void ip__resolve_ams(struct thread *thread,
 	ams->ms.sym = al.sym;
 	ams->ms.map = al.map;
 	ams->phys_addr = 0;
+	ams->data_page_size = 0;
 }
 
 static void ip__resolve_data(struct thread *thread,
 			     u8 m, struct addr_map_symbol *ams,
-			     u64 addr, u64 phys_addr)
+			     u64 addr, u64 phys_addr, u64 daddr_page_size)
 {
 	struct addr_location al;
 
@@ -2041,6 +2042,7 @@ static void ip__resolve_data(struct thread *thread,
 	ams->ms.sym = al.sym;
 	ams->ms.map = al.map;
 	ams->phys_addr = phys_addr;
+	ams->data_page_size = daddr_page_size;
 }
 
 struct mem_info *sample__resolve_mem(struct perf_sample *sample,
@@ -2053,7 +2055,8 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 
 	ip__resolve_ams(al->thread, &mi->iaddr, sample->ip);
 	ip__resolve_data(al->thread, al->cpumode, &mi->daddr,
-			 sample->addr, sample->phys_addr);
+			 sample->addr, sample->phys_addr,
+			 sample->data_page_size);
 	mi->data_src.val = sample->data_src;
 
 	return mi;
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
index 5b8ca93798e9..7d22ade082c8 100644
--- a/tools/perf/util/map_symbol.h
+++ b/tools/perf/util/map_symbol.h
@@ -19,5 +19,6 @@ struct addr_map_symbol {
 	u64	      addr;
 	u64	      al_addr;
 	u64	      phys_addr;
+	u64	      data_page_size;
 };
 #endif // __PERF_MAP_SYMBOL
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index d42339df20f8..ad9666db07fb 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1462,6 +1462,35 @@ struct sort_entry sort_mem_phys_daddr = {
 	.se_width_idx	= HISTC_MEM_PHYS_DADDR,
 };
 
+static int64_t
+sort__data_page_size_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	uint64_t l = 0, r = 0;
+
+	if (left->mem_info)
+		l = left->mem_info->daddr.data_page_size;
+	if (right->mem_info)
+		r = right->mem_info->daddr.data_page_size;
+
+	return (int64_t)(r - l);
+}
+
+static int hist_entry__data_page_size_snprintf(struct hist_entry *he, char *bf,
+					  size_t size, unsigned int width)
+{
+	char str[PAGE_SIZE_NAME_LEN];
+
+	return repsep_snprintf(bf, size, "%-*s", width,
+			       get_page_size_name(he->mem_info->daddr.data_page_size, str));
+}
+
+struct sort_entry sort_mem_data_page_size = {
+	.se_header	= "Data Page Size",
+	.se_cmp		= sort__data_page_size_cmp,
+	.se_snprintf	= hist_entry__data_page_size_snprintf,
+	.se_width_idx	= HISTC_MEM_DATA_PAGE_SIZE,
+};
+
 static int64_t
 sort__abort_cmp(struct hist_entry *left, struct hist_entry *right)
 {
@@ -1740,6 +1769,7 @@ static struct sort_dimension memory_sort_dimensions[] = {
 	DIM(SORT_MEM_SNOOP, "snoop", sort_mem_snoop),
 	DIM(SORT_MEM_DCACHELINE, "dcacheline", sort_mem_dcacheline),
 	DIM(SORT_MEM_PHYS_DADDR, "phys_daddr", sort_mem_phys_daddr),
+	DIM(SORT_MEM_DATA_PAGE_SIZE, "data_page_size", sort_mem_data_page_size),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 66d39c4cfe2b..e50f2b695bc4 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -255,6 +255,7 @@ enum sort_type {
 	SORT_MEM_DCACHELINE,
 	SORT_MEM_IADDR_SYMBOL,
 	SORT_MEM_PHYS_DADDR,
+	SORT_MEM_DATA_PAGE_SIZE,
 };
 
 /*
-- 
2.17.1

