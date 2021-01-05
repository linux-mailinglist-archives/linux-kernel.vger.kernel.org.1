Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653DD2EB3CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbhAEUAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:00:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:12067 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728383AbhAEUAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:00:18 -0500
IronPort-SDR: CYfNQNuNI0VfB6mKWxi8zl63DNLa1cXZ5307NlKxGXa/J59KM5Yg7lAC+QR+ptF4mGTEKJ6WWQ
 EzeoP47Jza7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="174594259"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="174594259"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 11:58:31 -0800
IronPort-SDR: ToPpKPXfGfb8o5fpgdW9/CPz+tqj7yMfLeg7QRwr1zo8OTKkdEhFj+hPjw6euGBoTx4FDa8uXL
 dsHEW8Ww0fsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="421901280"
Received: from ssp-iclu-cdi187.jf.intel.com ([10.54.55.67])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2021 11:58:31 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org, eranian@google.com,
        ak@linux.intel.com, mark.rutland@arm.com, will@kernel.org,
        mpe@ellerman.id.au, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 2/6] perf mem: Support data page size
Date:   Tue,  5 Jan 2021 11:57:48 -0800
Message-Id: <20210105195752.43489-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105195752.43489-1-kan.liang@linux.intel.com>
References: <20210105195752.43489-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add option --data-page-size in "perf mem" to record/report data page
size.

Here are some examples.
perf mem --phys-data --data-page-size report -D

 # PID, TID, IP, ADDR, PHYS ADDR, DATA PAGE SIZE, LOCAL WEIGHT, DSRC,
 # SYMBOL
20134 20134 0xffffffffb5bd2fd0 0x016ffff9a274e96a308 0x000000044e96a308
4K  1168 0x5080144
/lib/modules/4.18.0-rc7+/build/vmlinux:perf_ctx_unlock
20134 20134 0xffffffffb63f645c 0xffffffffb752b814 0xcfb52b814 2M 225
0x26a100142 /lib/modules/4.18.0-rc7+/build/vmlinux:_raw_spin_lock
20134 20134 0xffffffffb660300c 0xfffffe00016b8bb0 0x0 4K 0 0x5080144
/lib/modules/4.18.0-rc7+/build/vmlinux:__x86_indirect_thunk_rax

perf mem --phys-data --data-page-size report --stdio

 # To display the perf.data header info, please use
 # --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 5K of event 'cpu/mem-loads,ldlat=30/P'
 # Total weight : 281234
 # Sort order   :
 # mem,sym,dso,symbol_daddr,dso_daddr,tlb,locked,phys_daddr,data_page_size
 #
 # Overhead       Samples  Memory access             Symbol
 # Shared Object     Data Symbol                                  Data
 # Object              TLB access              Locked  Data Physical
 # Address   Data Page Size
 # ........  ............  ........................
 # ................................  ................
 # ...........................................  .......................
 # ......................  ......  ......................
 # ......................
 #
    28.54%          1826  L1 or L1 hit              [k]
__x86_indirect_thunk_rax      [kernel.vmlinux]  [k] 0xffffb0df31b0ff28
[unknown]                L1 or L2 hit            No      [k]
0000000000000000    4K
     6.02%           256  L1 or L1 hit              [.] touch_buffer
dtlb              [.] 0x00007ffd50109da8                       [stack]
L1 or L2 hit            No      [.] 0x000000042454ada8  4K
     3.23%             5  L1 or L1 hit              [k] clear_huge_page
[kernel.vmlinux]  [k] 0xffff9a2753b8ce60                       [unknown]
L1 or L2 hit            No      [k] 0x0000000453b8ce60  2M
     2.98%             4  L1 or L1 hit              [k] clear_page_erms
[kernel.vmlinux]  [k] 0xffffb0df31b0fd00                       [unknown]
L1 or L2 hit            No      [k] 0000000000000000    4K

Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-mem.txt |  3 +++
 tools/perf/builtin-mem.c              | 20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 199ea0f0a6c0..66177511c5c4 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -63,6 +63,9 @@ OPTIONS
 --phys-data::
 	Record/Report sample physical addresses
 
+--data-page-size::
+	Record/Report sample data address page size
+
 RECORD OPTIONS
 --------------
 -e::
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 7d6ee2208709..f3aac85aa9d4 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -30,6 +30,7 @@ struct perf_mem {
 	bool			dump_raw;
 	bool			force;
 	bool			phys_addr;
+	bool			data_page_size;
 	int			operation;
 	const char		*cpu_list;
 	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -124,6 +125,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	if (mem->phys_addr)
 		rec_argv[i++] = "--phys-data";
 
+	if (mem->data_page_size)
+		rec_argv[i++] = "--data-page-size";
+
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		e = perf_mem_events__ptr(j);
 		if (!e->record)
@@ -173,6 +177,7 @@ dump_raw_samples(struct perf_tool *tool,
 	struct perf_mem *mem = container_of(tool, struct perf_mem, tool);
 	struct addr_location al;
 	const char *fmt, *field_sep;
+	char str[PAGE_SIZE_NAME_LEN];
 
 	if (machine__resolve(machine, &al, sample) < 0) {
 		fprintf(stderr, "problem processing %d event, skipping it.\n",
@@ -209,6 +214,12 @@ dump_raw_samples(struct perf_tool *tool,
 			symbol_conf.field_sep);
 	}
 
+	if (mem->data_page_size) {
+		printf("%s%s",
+			get_page_size_name(sample->data_page_size, str),
+			symbol_conf.field_sep);
+	}
+
 	if (field_sep)
 		fmt = "%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
 	else
@@ -273,6 +284,9 @@ static int report_raw_events(struct perf_mem *mem)
 	if (mem->phys_addr)
 		printf("PHYS ADDR, ");
 
+	if (mem->data_page_size)
+		printf("DATA PAGE SIZE, ");
+
 	printf("LOCAL WEIGHT, DSRC, SYMBOL\n");
 
 	ret = perf_session__process_events(session);
@@ -283,7 +297,7 @@ static int report_raw_events(struct perf_mem *mem)
 }
 static char *get_sort_order(struct perf_mem *mem)
 {
-	bool has_extra_options = mem->phys_addr ? true : false;
+	bool has_extra_options = (mem->phys_addr | mem->data_page_size) ? true : false;
 	char sort[128];
 
 	/*
@@ -302,6 +316,9 @@ static char *get_sort_order(struct perf_mem *mem)
 	if (mem->phys_addr)
 		strcat(sort, ",phys_daddr");
 
+	if (mem->data_page_size)
+		strcat(sort, ",data_page_size");
+
 	return strdup(sort);
 }
 
@@ -447,6 +464,7 @@ int cmd_mem(int argc, const char **argv)
 		   " between columns '.' is reserved."),
 	OPT_BOOLEAN('f', "force", &mem.force, "don't complain, do it"),
 	OPT_BOOLEAN('p', "phys-data", &mem.phys_addr, "Record/Report sample physical addresses"),
+	OPT_BOOLEAN(0, "data-page-size", &mem.data_page_size, "Record/Report sample data address page size"),
 	OPT_END()
 	};
 	const char *const mem_subcommands[] = { "record", "report", NULL };
-- 
2.25.1

