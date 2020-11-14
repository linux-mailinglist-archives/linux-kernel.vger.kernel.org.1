Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D44D2B2AD9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 03:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgKNCgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 21:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgKNCgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 21:36:51 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08789C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 18:36:51 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 81so200457pgf.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 18:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WU1roLZDRMo5CeraEPOuMSGqOPN3LO0rl+zQO9V4U74=;
        b=jyz4xThoPr8ye1zcX9DO0DIAUzG+DlSeOqiF4HqWFv9AcexgFoNNWaKOmpFtJBWmip
         XuR51UakcVm7vXct4pnrPvGQN+GRhLZ816Rxf3wrpGa4aeWJNbTpawrdw30dXaiYw+0G
         SS0Dh2MsNE+ihiJMgcxzNUHQQ248FPEJyA+YEWF7y1fufDjrFx+YOIpHXDYOfmcyCq/1
         qw4aK77jUrIDIIbh5uJttgyk9DA+Yr1hYNtPrVlpufnnXfqV5QnfkJa27ztaP0RxMdjC
         20G15yi1342ifgpzh8olR6ieNXjMrtoFUmG4NAiYOGoI5PJfyHIEVRJ3cdlbfryOH94E
         ooxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=WU1roLZDRMo5CeraEPOuMSGqOPN3LO0rl+zQO9V4U74=;
        b=I16ghS8dbBuP/NumCQafZzUnhVZRooyYEe2x70QeUx3V7/HSwuWTfgxxiFTHobo3RA
         HZlkX5NRqRRFk9mOZBS4PP1MNszdpTLeRXim5S1J0XxBMNJDlkpS30XrhHpfKP8mk5aT
         4D+JmqTEZIQfoZ2bsHUfXjTTQbF/CKx/Qb2BlNGvimDi6ifrB/aF+s7CBZT2IaRRWxmO
         T2vPkwnK70GL5KDDzT54fkH04A6bJNZQlBLz0+lsOLbokZLvCd8dBfzZJbXa9gLAlwfV
         404esMnh9mydmgFBt8ArrT78RKqIo91e0BQH47m/aC+CNkfsdmTH/nVQgK6rbk1Vsg/m
         maSw==
X-Gm-Message-State: AOAM531c0uWb0hZ1sEAcLfX6ZTLZf9xxAorL/EhVhkoxd9WobaRJW1bc
        Hf/ENoAQKgh5DApeFKG4yAo=
X-Google-Smtp-Source: ABdhPJx+c/jwpSyekJshxIszS2pJEB8J8M6gQNOibkNNzfPRwecMFGaHKIspVUmHIlY8NdUCg28bwQ==
X-Received: by 2002:a65:5c89:: with SMTP id a9mr2549961pgt.182.1605321410363;
        Fri, 13 Nov 2020 18:36:50 -0800 (PST)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id 9sm10866746pfp.102.2020.11.13.18.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 18:36:49 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf stat: Take cgroups into account for shadow stats
Date:   Sat, 14 Nov 2020 11:36:43 +0900
Message-Id: <20201114023643.211313-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now it doesn't consider cgroups when collecting shadow stats and
metrics so counter values from different cgroups will be saved in a
same slot.  This resulted in an incorrect numbers when those cgroups
have different workloads.

For example, let's look at the below - the cgroup A and C runs same
workload which burns a cpu while cgroup B runs a light workload.

  $ perf stat -a -e cycles,instructions --for-each-cgroup A,B,C  sleep 1

   Performance counter stats for 'system wide':

     3,958,116,522      cycles                A
     6,722,650,929      instructions          A #    2.53  insn per cycle
         1,132,741      cycles                B
           571,743      instructions          B #    0.00  insn per cycle
     4,007,799,935      cycles                C
     6,793,181,523      instructions          C #    2.56  insn per cycle

       1.001050869 seconds time elapsed

When I run perf stat with single workload, it usually shows IPC around 1.7.
We can verify it (6,722,650,929.0 / 3,958,116,522 = 1.698) for cgroup A.

But in this case, since cgroups are ignored, cycles are averaged so it
used the lower value for IPC calculation and resulted in around 2.5.

  avg cycle: (3958116522 + 1132741 + 4007799935) / 3 = 2655683066
  IPC (A)  :  6722650929 / 2655683066 = 2.531
  IPC (B)  :      571743 / 2655683066 = 0.0002
  IPC (C)  :  6793181523 / 2655683066 = 2.557

We can simply compare cgroup pointers in the evsel and it'll be NULL
when cgroups are not specified.  With this patch, I can see correct
numbers like below:

  $ perf stat -a -e cycles,instructions --for-each-cgroup A,B,C  sleep 1

  Performance counter stats for 'system wide':

     4,171,051,687      cycles                A
     7,219,793,922      instructions          A #    1.73  insn per cycle
         1,051,189      cycles                B
           583,102      instructions          B #    0.55  insn per cycle
     4,171,124,710      cycles                C
     7,192,944,580      instructions          C #    1.72  insn per cycle

       1.007909814 seconds time elapsed

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-shadow.c | 243 ++++++++++++++++++----------------
 1 file changed, 132 insertions(+), 111 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 901265127e36..10d0f5a0fd4a 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -8,6 +8,7 @@
 #include "evlist.h"
 #include "expr.h"
 #include "metricgroup.h"
+#include "cgroup.h"
 #include <linux/zalloc.h>
 
 /*
@@ -28,6 +29,7 @@ struct saved_value {
 	enum stat_type type;
 	int ctx;
 	int cpu;
+	struct cgroup *cgrp;
 	struct runtime_stat *stat;
 	struct stats stats;
 	u64 metric_total;
@@ -57,6 +59,9 @@ static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
 	if (a->ctx != b->ctx)
 		return a->ctx - b->ctx;
 
+	if (a->cgrp != b->cgrp)
+		return (char *)a->cgrp < (char *)b->cgrp ? -1 : +1;
+
 	if (a->evsel == NULL && b->evsel == NULL) {
 		if (a->stat == b->stat)
 			return 0;
@@ -100,7 +105,8 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
 					      bool create,
 					      enum stat_type type,
 					      int ctx,
-					      struct runtime_stat *st)
+					      struct runtime_stat *st,
+					      struct cgroup *cgrp)
 {
 	struct rblist *rblist;
 	struct rb_node *nd;
@@ -110,6 +116,7 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
 		.type = type,
 		.ctx = ctx,
 		.stat = st,
+		.cgrp = cgrp,
 	};
 
 	rblist = &st->value_list;
@@ -193,10 +200,11 @@ void perf_stat__reset_shadow_per_stat(struct runtime_stat *st)
 
 static void update_runtime_stat(struct runtime_stat *st,
 				enum stat_type type,
-				int ctx, int cpu, u64 count)
+				int ctx, int cpu, u64 count,
+				struct cgroup *cgrp)
 {
 	struct saved_value *v = saved_value_lookup(NULL, cpu, true,
-						   type, ctx, st);
+						   type, ctx, st, cgrp);
 
 	if (v)
 		update_stats(&v->stats, count);
@@ -212,80 +220,81 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 {
 	int ctx = evsel_context(counter);
 	u64 count_ns = count;
+	struct cgroup *cgrp = counter->cgrp;
 	struct saved_value *v;
 
 	count *= counter->scale;
 
 	if (evsel__is_clock(counter))
-		update_runtime_stat(st, STAT_NSECS, 0, cpu, count_ns);
+		update_runtime_stat(st, STAT_NSECS, 0, cpu, count_ns, cgrp);
 	else if (evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
-		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
+		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
-		update_runtime_stat(st, STAT_CYCLES_IN_TX, ctx, cpu, count);
+		update_runtime_stat(st, STAT_CYCLES_IN_TX, ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, TRANSACTION_START))
-		update_runtime_stat(st, STAT_TRANSACTION, ctx, cpu, count);
+		update_runtime_stat(st, STAT_TRANSACTION, ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, ELISION_START))
-		update_runtime_stat(st, STAT_ELISION, ctx, cpu, count);
+		update_runtime_stat(st, STAT_ELISION, ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_TOTAL_SLOTS))
 		update_runtime_stat(st, STAT_TOPDOWN_TOTAL_SLOTS,
-				    ctx, cpu, count);
+				    ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_ISSUED))
 		update_runtime_stat(st, STAT_TOPDOWN_SLOTS_ISSUED,
-				    ctx, cpu, count);
+				    ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_RETIRED))
 		update_runtime_stat(st, STAT_TOPDOWN_SLOTS_RETIRED,
-				    ctx, cpu, count);
+				    ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_FETCH_BUBBLES))
 		update_runtime_stat(st, STAT_TOPDOWN_FETCH_BUBBLES,
-				    ctx, cpu, count);
+				    ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_RECOVERY_BUBBLES))
 		update_runtime_stat(st, STAT_TOPDOWN_RECOVERY_BUBBLES,
-				    ctx, cpu, count);
+				    ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_RETIRING))
 		update_runtime_stat(st, STAT_TOPDOWN_RETIRING,
-				    ctx, cpu, count);
+				    ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_BAD_SPEC))
 		update_runtime_stat(st, STAT_TOPDOWN_BAD_SPEC,
-				    ctx, cpu, count);
+				    ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_FE_BOUND))
 		update_runtime_stat(st, STAT_TOPDOWN_FE_BOUND,
-				    ctx, cpu, count);
+				    ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_BE_BOUND))
 		update_runtime_stat(st, STAT_TOPDOWN_BE_BOUND,
-				    ctx, cpu, count);
+				    ctx, cpu, count, cgrp);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
-				    ctx, cpu, count);
+				    ctx, cpu, count, cgrp);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_BACKEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_BACK,
-				    ctx, cpu, count);
+				    ctx, cpu, count, cgrp);
 	else if (evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
-		update_runtime_stat(st, STAT_BRANCHES, ctx, cpu, count);
+		update_runtime_stat(st, STAT_BRANCHES, ctx, cpu, count, cgrp);
 	else if (evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
-		update_runtime_stat(st, STAT_CACHEREFS, ctx, cpu, count);
+		update_runtime_stat(st, STAT_CACHEREFS, ctx, cpu, count, cgrp);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
-		update_runtime_stat(st, STAT_L1_DCACHE, ctx, cpu, count);
+		update_runtime_stat(st, STAT_L1_DCACHE, ctx, cpu, count, cgrp);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
-		update_runtime_stat(st, STAT_L1_ICACHE, ctx, cpu, count);
+		update_runtime_stat(st, STAT_L1_ICACHE, ctx, cpu, count, cgrp);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_LL))
-		update_runtime_stat(st, STAT_LL_CACHE, ctx, cpu, count);
+		update_runtime_stat(st, STAT_LL_CACHE, ctx, cpu, count, cgrp);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_DTLB))
-		update_runtime_stat(st, STAT_DTLB_CACHE, ctx, cpu, count);
+		update_runtime_stat(st, STAT_DTLB_CACHE, ctx, cpu, count, cgrp);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
-		update_runtime_stat(st, STAT_ITLB_CACHE, ctx, cpu, count);
+		update_runtime_stat(st, STAT_ITLB_CACHE, ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, SMI_NUM))
-		update_runtime_stat(st, STAT_SMI_NUM, ctx, cpu, count);
+		update_runtime_stat(st, STAT_SMI_NUM, ctx, cpu, count, cgrp);
 	else if (perf_stat_evsel__is(counter, APERF))
-		update_runtime_stat(st, STAT_APERF, ctx, cpu, count);
+		update_runtime_stat(st, STAT_APERF, ctx, cpu, count, cgrp);
 
 	if (counter->collect_stat) {
-		v = saved_value_lookup(counter, cpu, true, STAT_NONE, 0, st);
+		v = saved_value_lookup(counter, cpu, true, STAT_NONE, 0, st, cgrp);
 		update_stats(&v->stats, count);
 		if (counter->metric_leader)
 			v->metric_total += count;
 	} else if (counter->metric_leader) {
 		v = saved_value_lookup(counter->metric_leader,
-				       cpu, true, STAT_NONE, 0, st);
+				       cpu, true, STAT_NONE, 0, st, cgrp);
 		v->metric_total += count;
 		v->metric_other++;
 	}
@@ -422,11 +431,12 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 }
 
 static double runtime_stat_avg(struct runtime_stat *st,
-			       enum stat_type type, int ctx, int cpu)
+			       enum stat_type type, int ctx, int cpu,
+			       struct cgroup *cgrp)
 {
 	struct saved_value *v;
 
-	v = saved_value_lookup(NULL, cpu, false, type, ctx, st);
+	v = saved_value_lookup(NULL, cpu, false, type, ctx, st, cgrp);
 	if (!v)
 		return 0.0;
 
@@ -434,11 +444,12 @@ static double runtime_stat_avg(struct runtime_stat *st,
 }
 
 static double runtime_stat_n(struct runtime_stat *st,
-			     enum stat_type type, int ctx, int cpu)
+			     enum stat_type type, int ctx, int cpu,
+			     struct cgroup *cgrp)
 {
 	struct saved_value *v;
 
-	v = saved_value_lookup(NULL, cpu, false, type, ctx, st);
+	v = saved_value_lookup(NULL, cpu, false, type, ctx, st, cgrp);
 	if (!v)
 		return 0.0;
 
@@ -455,7 +466,7 @@ static void print_stalled_cycles_frontend(struct perf_stat_config *config,
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu, evsel->cgrp);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -479,7 +490,7 @@ static void print_stalled_cycles_backend(struct perf_stat_config *config,
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu, evsel->cgrp);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -500,7 +511,7 @@ static void print_branch_misses(struct perf_stat_config *config,
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_BRANCHES, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_BRANCHES, ctx, cpu, evsel->cgrp);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -522,7 +533,7 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_L1_DCACHE, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_L1_DCACHE, ctx, cpu, evsel->cgrp);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -544,7 +555,7 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_L1_ICACHE, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_L1_ICACHE, ctx, cpu, evsel->cgrp);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -564,7 +575,7 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_DTLB_CACHE, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_DTLB_CACHE, ctx, cpu, evsel->cgrp);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -584,7 +595,7 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_ITLB_CACHE, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_ITLB_CACHE, ctx, cpu, evsel->cgrp);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -604,7 +615,7 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_LL_CACHE, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_LL_CACHE, ctx, cpu, evsel->cgrp);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -662,56 +673,61 @@ static double sanitize_val(double x)
 	return x;
 }
 
-static double td_total_slots(int ctx, int cpu, struct runtime_stat *st)
+static double td_total_slots(int ctx, int cpu, struct runtime_stat *st,
+			     struct cgroup *cgrp)
 {
-	return runtime_stat_avg(st, STAT_TOPDOWN_TOTAL_SLOTS, ctx, cpu);
+	return runtime_stat_avg(st, STAT_TOPDOWN_TOTAL_SLOTS, ctx, cpu, cgrp);
 }
 
-static double td_bad_spec(int ctx, int cpu, struct runtime_stat *st)
+static double td_bad_spec(int ctx, int cpu, struct runtime_stat *st,
+			  struct cgroup *cgrp)
 {
 	double bad_spec = 0;
 	double total_slots;
 	double total;
 
-	total = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_ISSUED, ctx, cpu) -
-		runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED, ctx, cpu) +
-		runtime_stat_avg(st, STAT_TOPDOWN_RECOVERY_BUBBLES, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_ISSUED, ctx, cpu, cgrp) -
+		runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED, ctx, cpu, cgrp) +
+		runtime_stat_avg(st, STAT_TOPDOWN_RECOVERY_BUBBLES, ctx, cpu, cgrp);
 
-	total_slots = td_total_slots(ctx, cpu, st);
+	total_slots = td_total_slots(ctx, cpu, st, cgrp);
 	if (total_slots)
 		bad_spec = total / total_slots;
 	return sanitize_val(bad_spec);
 }
 
-static double td_retiring(int ctx, int cpu, struct runtime_stat *st)
+static double td_retiring(int ctx, int cpu, struct runtime_stat *st,
+			  struct cgroup *cgrp)
 {
 	double retiring = 0;
-	double total_slots = td_total_slots(ctx, cpu, st);
+	double total_slots = td_total_slots(ctx, cpu, st, cgrp);
 	double ret_slots = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED,
-					    ctx, cpu);
+					    ctx, cpu, cgrp);
 
 	if (total_slots)
 		retiring = ret_slots / total_slots;
 	return retiring;
 }
 
-static double td_fe_bound(int ctx, int cpu, struct runtime_stat *st)
+static double td_fe_bound(int ctx, int cpu, struct runtime_stat *st,
+			  struct cgroup *cgrp)
 {
 	double fe_bound = 0;
-	double total_slots = td_total_slots(ctx, cpu, st);
+	double total_slots = td_total_slots(ctx, cpu, st, cgrp);
 	double fetch_bub = runtime_stat_avg(st, STAT_TOPDOWN_FETCH_BUBBLES,
-					    ctx, cpu);
+					    ctx, cpu, cgrp);
 
 	if (total_slots)
 		fe_bound = fetch_bub / total_slots;
 	return fe_bound;
 }
 
-static double td_be_bound(int ctx, int cpu, struct runtime_stat *st)
+static double td_be_bound(int ctx, int cpu, struct runtime_stat *st,
+			  struct cgroup *cgrp)
 {
-	double sum = (td_fe_bound(ctx, cpu, st) +
-		      td_bad_spec(ctx, cpu, st) +
-		      td_retiring(ctx, cpu, st));
+	double sum = (td_fe_bound(ctx, cpu, st, cgrp) +
+		      td_bad_spec(ctx, cpu, st, cgrp) +
+		      td_retiring(ctx, cpu, st, cgrp));
 	if (sum == 0)
 		return 0;
 	return sanitize_val(1.0 - sum);
@@ -724,13 +740,14 @@ static double td_be_bound(int ctx, int cpu, struct runtime_stat *st)
 
 static double td_metric_ratio(int ctx, int cpu,
 			      enum stat_type type,
-			      struct runtime_stat *stat)
+			      struct runtime_stat *stat,
+			      struct cgroup *cgrp)
 {
-	double sum = runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, ctx, cpu) +
-		runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, ctx, cpu) +
-		runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, ctx, cpu) +
-		runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, ctx, cpu);
-	double d = runtime_stat_avg(stat, type, ctx, cpu);
+	double sum = runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, ctx, cpu, cgrp) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, ctx, cpu, cgrp) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, ctx, cpu, cgrp) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, ctx, cpu, cgrp);
+	double d = runtime_stat_avg(stat, type, ctx, cpu, cgrp);
 
 	if (sum)
 		return d / sum;
@@ -743,17 +760,18 @@ static double td_metric_ratio(int ctx, int cpu,
  */
 
 static bool full_td(int ctx, int cpu,
-		    struct runtime_stat *stat)
+		    struct runtime_stat *stat,
+		    struct cgroup *cgrp)
 {
 	int c = 0;
 
-	if (runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, ctx, cpu) > 0)
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, ctx, cpu, cgrp) > 0)
 		c++;
-	if (runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, ctx, cpu) > 0)
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, ctx, cpu, cgrp) > 0)
 		c++;
-	if (runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, ctx, cpu) > 0)
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, ctx, cpu, cgrp) > 0)
 		c++;
-	if (runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, ctx, cpu) > 0)
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, ctx, cpu, cgrp) > 0)
 		c++;
 	return c >= 2;
 }
@@ -766,10 +784,11 @@ static void print_smi_cost(struct perf_stat_config *config,
 	double smi_num, aperf, cycles, cost = 0.0;
 	int ctx = evsel_context(evsel);
 	const char *color = NULL;
+	struct cgroup *cgrp = evsel->cgrp;
 
-	smi_num = runtime_stat_avg(st, STAT_SMI_NUM, ctx, cpu);
-	aperf = runtime_stat_avg(st, STAT_APERF, ctx, cpu);
-	cycles = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+	smi_num = runtime_stat_avg(st, STAT_SMI_NUM, ctx, cpu, cgrp);
+	aperf = runtime_stat_avg(st, STAT_APERF, ctx, cpu, cgrp);
+	cycles = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu, cgrp);
 
 	if ((cycles == 0) || (aperf == 0))
 		return;
@@ -804,7 +823,8 @@ static int prepare_metric(struct evsel **metric_events,
 			scale = 1e-9;
 		} else {
 			v = saved_value_lookup(metric_events[i], cpu, false,
-					       STAT_NONE, 0, st);
+					       STAT_NONE, 0, st,
+					       metric_events[i]->cgrp);
 			if (!v)
 				break;
 			stats = &v->stats;
@@ -931,11 +951,12 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	double total, ratio = 0.0, total2;
 	const char *color = NULL;
 	int ctx = evsel_context(evsel);
+	struct cgroup *cgrp = evsel->cgrp;
 	struct metric_event *me;
 	int num = 1;
 
 	if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
-		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu, cgrp);
 
 		if (total) {
 			ratio = avg / total;
@@ -946,11 +967,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		}
 
 		total = runtime_stat_avg(st, STAT_STALLED_CYCLES_FRONT,
-					 ctx, cpu);
+					 ctx, cpu, cgrp);
 
 		total = max(total, runtime_stat_avg(st,
 						    STAT_STALLED_CYCLES_BACK,
-						    ctx, cpu));
+						    ctx, cpu, cgrp));
 
 		if (total && avg) {
 			out->new_line(config, ctxp);
@@ -960,7 +981,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					ratio);
 		}
 	} else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
-		if (runtime_stat_n(st, STAT_BRANCHES, ctx, cpu) != 0)
+		if (runtime_stat_n(st, STAT_BRANCHES, ctx, cpu, cgrp) != 0)
 			print_branch_misses(config, cpu, evsel, avg, out, st);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all branches", 0);
@@ -970,7 +991,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
+		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu, cgrp) != 0)
 			print_l1_dcache_misses(config, cpu, evsel, avg, out, st);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache accesses", 0);
@@ -980,7 +1001,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
+		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu, cgrp) != 0)
 			print_l1_icache_misses(config, cpu, evsel, avg, out, st);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all L1-icache accesses", 0);
@@ -990,7 +1011,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
+		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu, cgrp) != 0)
 			print_dtlb_cache_misses(config, cpu, evsel, avg, out, st);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache accesses", 0);
@@ -1000,7 +1021,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
+		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu, cgrp) != 0)
 			print_itlb_cache_misses(config, cpu, evsel, avg, out, st);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache accesses", 0);
@@ -1010,17 +1031,17 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
+		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu, cgrp) != 0)
 			print_ll_cache_misses(config, cpu, evsel, avg, out, st);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all LL-cache accesses", 0);
 	} else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
-		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);
+		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu, cgrp);
 
 		if (total)
 			ratio = avg * 100 / total;
 
-		if (runtime_stat_n(st, STAT_CACHEREFS, ctx, cpu) != 0)
+		if (runtime_stat_n(st, STAT_CACHEREFS, ctx, cpu, cgrp) != 0)
 			print_metric(config, ctxp, NULL, "%8.3f %%",
 				     "of all cache refs", ratio);
 		else
@@ -1030,7 +1051,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
 		print_stalled_cycles_backend(config, cpu, evsel, avg, out, st);
 	} else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
-		total = runtime_stat_avg(st, STAT_NSECS, 0, cpu);
+		total = runtime_stat_avg(st, STAT_NSECS, 0, cpu, cgrp);
 
 		if (total) {
 			ratio = avg / total;
@@ -1039,7 +1060,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, "Ghz", 0);
 		}
 	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX)) {
-		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu, cgrp);
 
 		if (total)
 			print_metric(config, ctxp, NULL,
@@ -1049,8 +1070,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, "transactional cycles",
 				     0);
 	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX_CP)) {
-		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
-		total2 = runtime_stat_avg(st, STAT_CYCLES_IN_TX, ctx, cpu);
+		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu, cgrp);
+		total2 = runtime_stat_avg(st, STAT_CYCLES_IN_TX, ctx, cpu, cgrp);
 
 		if (total2 < avg)
 			total2 = avg;
@@ -1061,12 +1082,12 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, "aborted cycles", 0);
 	} else if (perf_stat_evsel__is(evsel, TRANSACTION_START)) {
 		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX,
-					 ctx, cpu);
+					 ctx, cpu, cgrp);
 
 		if (avg)
 			ratio = total / avg;
 
-		if (runtime_stat_n(st, STAT_CYCLES_IN_TX, ctx, cpu) != 0)
+		if (runtime_stat_n(st, STAT_CYCLES_IN_TX, ctx, cpu, cgrp) != 0)
 			print_metric(config, ctxp, NULL, "%8.0f",
 				     "cycles / transaction", ratio);
 		else
@@ -1074,7 +1095,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				      0);
 	} else if (perf_stat_evsel__is(evsel, ELISION_START)) {
 		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX,
-					 ctx, cpu);
+					 ctx, cpu, cgrp);
 
 		if (avg)
 			ratio = total / avg;
@@ -1087,28 +1108,28 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		else
 			print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_BUBBLES)) {
-		double fe_bound = td_fe_bound(ctx, cpu, st);
+		double fe_bound = td_fe_bound(ctx, cpu, st, cgrp);
 
 		if (fe_bound > 0.2)
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
 				fe_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_RETIRED)) {
-		double retiring = td_retiring(ctx, cpu, st);
+		double retiring = td_retiring(ctx, cpu, st, cgrp);
 
 		if (retiring > 0.7)
 			color = PERF_COLOR_GREEN;
 		print_metric(config, ctxp, color, "%8.1f%%", "retiring",
 				retiring * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RECOVERY_BUBBLES)) {
-		double bad_spec = td_bad_spec(ctx, cpu, st);
+		double bad_spec = td_bad_spec(ctx, cpu, st, cgrp);
 
 		if (bad_spec > 0.1)
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
 				bad_spec * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_ISSUED)) {
-		double be_bound = td_be_bound(ctx, cpu, st);
+		double be_bound = td_be_bound(ctx, cpu, st, cgrp);
 		const char *name = "backend bound";
 		static int have_recovery_bubbles = -1;
 
@@ -1121,43 +1142,43 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
 		if (be_bound > 0.2)
 			color = PERF_COLOR_RED;
-		if (td_total_slots(ctx, cpu, st) > 0)
+		if (td_total_slots(ctx, cpu, st, cgrp) > 0)
 			print_metric(config, ctxp, color, "%8.1f%%", name,
 					be_bound * 100.);
 		else
 			print_metric(config, ctxp, NULL, NULL, name, 0);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RETIRING) &&
-			full_td(ctx, cpu, st)) {
+		   full_td(ctx, cpu, st, cgrp)) {
 		double retiring = td_metric_ratio(ctx, cpu,
-						  STAT_TOPDOWN_RETIRING, st);
-
+						  STAT_TOPDOWN_RETIRING, st,
+						  cgrp);
 		if (retiring > 0.7)
 			color = PERF_COLOR_GREEN;
 		print_metric(config, ctxp, color, "%8.1f%%", "retiring",
 				retiring * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FE_BOUND) &&
-			full_td(ctx, cpu, st)) {
+		   full_td(ctx, cpu, st, cgrp)) {
 		double fe_bound = td_metric_ratio(ctx, cpu,
-						  STAT_TOPDOWN_FE_BOUND, st);
-
+						  STAT_TOPDOWN_FE_BOUND, st,
+						  cgrp);
 		if (fe_bound > 0.2)
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
 				fe_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BE_BOUND) &&
-			full_td(ctx, cpu, st)) {
+		   full_td(ctx, cpu, st, cgrp)) {
 		double be_bound = td_metric_ratio(ctx, cpu,
-						  STAT_TOPDOWN_BE_BOUND, st);
-
+						  STAT_TOPDOWN_BE_BOUND, st,
+						  cgrp);
 		if (be_bound > 0.2)
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "backend bound",
 				be_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BAD_SPEC) &&
-			full_td(ctx, cpu, st)) {
+		   full_td(ctx, cpu, st, cgrp)) {
 		double bad_spec = td_metric_ratio(ctx, cpu,
-						  STAT_TOPDOWN_BAD_SPEC, st);
-
+						  STAT_TOPDOWN_BAD_SPEC, st,
+						  cgrp);
 		if (bad_spec > 0.1)
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
@@ -1165,11 +1186,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
 				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
-	} else if (runtime_stat_n(st, STAT_NSECS, 0, cpu) != 0) {
+	} else if (runtime_stat_n(st, STAT_NSECS, 0, cpu, cgrp) != 0) {
 		char unit = 'M';
 		char unit_buf[10];
 
-		total = runtime_stat_avg(st, STAT_NSECS, 0, cpu);
+		total = runtime_stat_avg(st, STAT_NSECS, 0, cpu, cgrp);
 
 		if (total)
 			ratio = 1000.0 * avg / total;
-- 
2.29.2.299.gdc1121823c-goog

