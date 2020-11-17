Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6194A2B6F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbgKQT5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:57:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:48614 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731408AbgKQT5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:57:30 -0500
IronPort-SDR: Sf0CQf6iU1yYCeaZA9uEilXUBEPy0F2RioYPplHwaDX6+MBcGKYjhLYco0g9MfUFVzs1BciquV
 euA+tDE4Ff/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150270464"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150270464"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:57:30 -0800
IronPort-SDR: sPvHaPBE51alANRIv2DQzJISEdekLWYBOQ2LIhnZfvsWxWOfLGILPswvdq9bB+HuNjJ0vF2a6u
 pgjoUbVNBX4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544188126"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2020 11:57:29 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 03/12] perf script: Support data page size
Date:   Tue, 17 Nov 2020 11:56:28 -0800
Message-Id: <20201117195637.6499-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117195637.6499-1-kan.liang@linux.intel.com>
References: <20201117195637.6499-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Display the data page size if it is available.

Can be configured by the user, for example:
  perf script --fields comm,event,phys_addr,data_page_size
            dtlb mem-loads:uP:        3fec82ea8 4K
            dtlb mem-loads:uP:        3fec82e90 4K
            dtlb mem-loads:uP:        3e23700a4 4K
            dtlb mem-loads:uP:        3fec82f20 4K
            dtlb mem-loads:uP:        3e23700a4 4K
            dtlb mem-loads:uP:        3b4211bec 4K
            dtlb mem-loads:uP:        382205dc0 2M
            dtlb mem-loads:uP:        36fa082c0 2M
            dtlb mem-loads:uP:        377607340 2M
            dtlb mem-loads:uP:        330010180 2M
            dtlb mem-loads:uP:        33200fd80 2M
            dtlb mem-loads:uP:        31b012b80 2M

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt |  5 +++--
 tools/perf/builtin-script.c              | 17 +++++++++++++++--
 tools/perf/util/event.h                  |  3 +++
 tools/perf/util/session.c                | 23 +++++++++++++++++++++++
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 4f712fb8f175..ac4755727ca1 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -116,8 +116,9 @@ OPTIONS
 --fields::
         Comma separated list of fields to print. Options are:
         comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
-        srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output, brstackinsn,
-        brstackoff, callindent, insn, insnlen, synth, phys_addr, metric, misc, srccode, ipc.
+	srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
+	brstackinsn, brstackoff, callindent, insn, insnlen, synth, phys_addr,
+	metric, misc, srccode, ipc, data_page_size.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 48588ccf902e..a02a820398d7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -30,6 +30,7 @@
 #include "util/thread-stack.h"
 #include "util/time-utils.h"
 #include "util/path.h"
+#include "util/event.h"
 #include "ui/ui.h"
 #include "print_binary.h"
 #include "archinsn.h"
@@ -115,6 +116,7 @@ enum perf_output_field {
 	PERF_OUTPUT_SRCCODE	    = 1ULL << 30,
 	PERF_OUTPUT_IPC             = 1ULL << 31,
 	PERF_OUTPUT_TOD             = 1ULL << 32,
+	PERF_OUTPUT_DATA_PAGE_SIZE  = 1ULL << 33,
 };
 
 struct perf_script {
@@ -179,6 +181,7 @@ struct output_option {
 	{.str = "srccode", .field = PERF_OUTPUT_SRCCODE},
 	{.str = "ipc", .field = PERF_OUTPUT_IPC},
 	{.str = "tod", .field = PERF_OUTPUT_TOD},
+	{.str = "data_page_size", .field = PERF_OUTPUT_DATA_PAGE_SIZE},
 };
 
 enum {
@@ -251,7 +254,8 @@ static struct {
 			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
 			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD |
 			      PERF_OUTPUT_ADDR | PERF_OUTPUT_DATA_SRC |
-			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR,
+			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR |
+			      PERF_OUTPUT_DATA_PAGE_SIZE,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -499,6 +503,10 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 	    evsel__check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR", PERF_OUTPUT_PHYS_ADDR))
 		return -EINVAL;
 
+	if (PRINT_FIELD(DATA_PAGE_SIZE) &&
+	    evsel__check_stype(evsel, PERF_SAMPLE_DATA_PAGE_SIZE, "DATA_PAGE_SIZE", PERF_OUTPUT_DATA_PAGE_SIZE))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -1920,6 +1928,7 @@ static void process_event(struct perf_script *script,
 	unsigned int type = output_type(attr->type);
 	struct evsel_script *es = evsel->priv;
 	FILE *fp = es->fp;
+	char str[PAGE_SIZE_NAME_LEN];
 
 	if (output[type].fields == 0)
 		return;
@@ -2008,6 +2017,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(PHYS_ADDR))
 		fprintf(fp, "%16" PRIx64, sample->phys_addr);
 
+	if (PRINT_FIELD(DATA_PAGE_SIZE))
+		fprintf(fp, " %s", get_page_size_name(sample->data_page_size, str));
+
 	perf_sample__fprintf_ipc(sample, attr, fp);
 
 	fprintf(fp, "\n");
@@ -3506,7 +3518,8 @@ int cmd_script(int argc, const char **argv)
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
 		     "brstacksym,flags,bpf-output,brstackinsn,brstackoff,"
-		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc,tod",
+		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc,tod,"
+		     "data_page_size",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 448ac30c2fc4..2e5aec3ead9f 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -409,4 +409,7 @@ extern int sysctl_perf_event_max_stack;
 extern int sysctl_perf_event_max_contexts_per_stack;
 extern unsigned int proc_map_timeout;
 
+#define PAGE_SIZE_NAME_LEN	10
+char *get_page_size_name(u64 size, char *str);
+
 #endif /* __PERF_RECORD_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7a5f03764702..6335deda28f6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1246,10 +1246,30 @@ static void dump_event(struct evlist *evlist, union perf_event *event,
 	       event->header.size, perf_event__name(event->header.type));
 }
 
+char *get_page_size_name(u64 size, char *str)
+{
+	const char suffixes[5] = { 'B', 'K', 'M', 'G', 'T' };
+	int i;
+
+	if (size == 0) {
+		snprintf(str, PAGE_SIZE_NAME_LEN, "%s", "N/A");
+		return str;
+	}
+	for (i = 0; i < 5; i++) {
+		if (size < 1024)
+			break;
+		size /= 1024;
+	}
+
+	snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
+	return str;
+}
+
 static void dump_sample(struct evsel *evsel, union perf_event *event,
 			struct perf_sample *sample)
 {
 	u64 sample_type;
+	char str[PAGE_SIZE_NAME_LEN];
 
 	if (!dump_trace)
 		return;
@@ -1284,6 +1304,9 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		printf(" .. phys_addr: 0x%"PRIx64"\n", sample->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		printf(" .. data page size: %s\n", get_page_size_name(sample->data_page_size, str));
+
 	if (sample_type & PERF_SAMPLE_TRANSACTION)
 		printf("... transaction: %" PRIx64 "\n", sample->transaction);
 
-- 
2.17.1

