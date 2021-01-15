Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAAC2F738D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbhAOHM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbhAOHM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:12:26 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D532C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:11:46 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c12so4911762pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o0tldBbVVkRUb3eoQahPGsGp6oLbRpb4s3rsMDgwQLs=;
        b=fWG292ua3zzpd/tMSPZAurjftwucznC7U6ybQaz17boqnEmwgH6U31ktZp2zSuSONx
         irRgHy/sCMV3HgbPakVKlp3a1PoGLHVJu5cuiPJZsrZzteRMOFy1AtaSiFxl4/MCyYZG
         jI3kgLZwzaWP3wNhd11hf92tzv3FrAZE2uoQnib+SPD4rrjEG/jdVET7WuVXkMomuS7o
         OwNRe47/c7vJZuksZco7qw3Ox8euswwhQuwqhsn+7lQo69j2HooaCu+Fbg/Be3KeWs2y
         9BiRSmuiEaYBmbtEfFTP/qUSMizVzcye/7WtIgPYMJ4aSU+mF1qztXZHkVvvjf59O3jU
         38xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=o0tldBbVVkRUb3eoQahPGsGp6oLbRpb4s3rsMDgwQLs=;
        b=uZh42tzkKeUJGFfmw/bBEXuErH112sJ9OUfOAHuxnI8cRGu1I+WhOs/YeongvN8XvZ
         d1fngfynLQynctLY/HWvu5lG+LQucT2UJbEnb74HMHFDhdhVY/rudX4vADbxZfUUBPDy
         6kH4P8Tytjbw5rwBB8y/Deb5TrcVpcR7SKbCVHvAIge3zX2ERAVpvHkX9t6J8s8CRfe0
         p7+5vQP9a25SOIdi1uu1boU88rnl/Q+vgkyImkcYFktjXte2yVweba8QLNFMGKT7HEDV
         NRfPVqcV8iTNJNTOxOe/VxbU+BSOru1ZDW4oZcLnNqXpnH4NBarihkY0xze03+gnm4qb
         /5Tw==
X-Gm-Message-State: AOAM532ha861LYkryD8iXqBTpMaxYJiM2pmUVR19XUoekQajm5Pbs6qC
        F36vH5UeoMYKGIGDYvOvXdI=
X-Google-Smtp-Source: ABdhPJxT7RoWFcb3wt5FhDYnt+lXlpSfOC7/6naIkkajzeRVG2gGpgUl9ExBPJH4XmwOt8r3xj79gQ==
X-Received: by 2002:a62:b60c:0:b029:1ae:6d91:4eb6 with SMTP id j12-20020a62b60c0000b02901ae6d914eb6mr11325389pff.33.1610694705284;
        Thu, 14 Jan 2021 23:11:45 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id 84sm7450569pfy.9.2021.01.14.23.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 23:11:44 -0800 (PST)
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
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v3 1/2] perf stat: Introduce struct runtime_stat_data
Date:   Fri, 15 Jan 2021 16:11:38 +0900
Message-Id: <20210115071139.257042-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To pass more info to the saved_value in the runtime_stat, add a new
struct runtime_stat_data.  Currently it only has 'ctx' field but later
patch will add more.

Note that we intentionally pass 0 as ctx to clock-related events for
compatibility.  It was already there in a few places.  So move the
code into the saved_value_lookup() explicitly and add a comment.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-shadow.c | 346 +++++++++++++++++-----------------
 1 file changed, 173 insertions(+), 173 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 901265127e36..a1565b6e38f2 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -114,6 +114,10 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
 
 	rblist = &st->value_list;
 
+	/* don't use context info for clock events */
+	if (type == STAT_NSECS)
+		dm.ctx = 0;
+
 	nd = rblist__find(rblist, &dm);
 	if (nd)
 		return container_of(nd, struct saved_value, rb_node);
@@ -191,12 +195,17 @@ void perf_stat__reset_shadow_per_stat(struct runtime_stat *st)
 	reset_stat(st);
 }
 
+struct runtime_stat_data {
+	int ctx;
+};
+
 static void update_runtime_stat(struct runtime_stat *st,
 				enum stat_type type,
-				int ctx, int cpu, u64 count)
+				int cpu, u64 count,
+				struct runtime_stat_data *rsd)
 {
-	struct saved_value *v = saved_value_lookup(NULL, cpu, true,
-						   type, ctx, st);
+	struct saved_value *v = saved_value_lookup(NULL, cpu, true, type,
+						   rsd->ctx, st);
 
 	if (v)
 		update_stats(&v->stats, count);
@@ -210,73 +219,75 @@ static void update_runtime_stat(struct runtime_stat *st,
 void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 				    int cpu, struct runtime_stat *st)
 {
-	int ctx = evsel_context(counter);
 	u64 count_ns = count;
 	struct saved_value *v;
+	struct runtime_stat_data rsd = {
+		.ctx = evsel_context(counter),
+	};
 
 	count *= counter->scale;
 
 	if (evsel__is_clock(counter))
-		update_runtime_stat(st, STAT_NSECS, 0, cpu, count_ns);
+		update_runtime_stat(st, STAT_NSECS, cpu, count_ns, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
-		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
+		update_runtime_stat(st, STAT_CYCLES, cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
-		update_runtime_stat(st, STAT_CYCLES_IN_TX, ctx, cpu, count);
+		update_runtime_stat(st, STAT_CYCLES_IN_TX, cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TRANSACTION_START))
-		update_runtime_stat(st, STAT_TRANSACTION, ctx, cpu, count);
+		update_runtime_stat(st, STAT_TRANSACTION, cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, ELISION_START))
-		update_runtime_stat(st, STAT_ELISION, ctx, cpu, count);
+		update_runtime_stat(st, STAT_ELISION, cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_TOTAL_SLOTS))
 		update_runtime_stat(st, STAT_TOPDOWN_TOTAL_SLOTS,
-				    ctx, cpu, count);
+				    cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_ISSUED))
 		update_runtime_stat(st, STAT_TOPDOWN_SLOTS_ISSUED,
-				    ctx, cpu, count);
+				    cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_RETIRED))
 		update_runtime_stat(st, STAT_TOPDOWN_SLOTS_RETIRED,
-				    ctx, cpu, count);
+				    cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_FETCH_BUBBLES))
 		update_runtime_stat(st, STAT_TOPDOWN_FETCH_BUBBLES,
-				    ctx, cpu, count);
+				    cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_RECOVERY_BUBBLES))
 		update_runtime_stat(st, STAT_TOPDOWN_RECOVERY_BUBBLES,
-				    ctx, cpu, count);
+				    cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_RETIRING))
 		update_runtime_stat(st, STAT_TOPDOWN_RETIRING,
-				    ctx, cpu, count);
+				    cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_BAD_SPEC))
 		update_runtime_stat(st, STAT_TOPDOWN_BAD_SPEC,
-				    ctx, cpu, count);
+				    cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_FE_BOUND))
 		update_runtime_stat(st, STAT_TOPDOWN_FE_BOUND,
-				    ctx, cpu, count);
+				    cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_BE_BOUND))
 		update_runtime_stat(st, STAT_TOPDOWN_BE_BOUND,
-				    ctx, cpu, count);
+				    cpu, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
-				    ctx, cpu, count);
+				    cpu, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_BACKEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_BACK,
-				    ctx, cpu, count);
+				    cpu, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
-		update_runtime_stat(st, STAT_BRANCHES, ctx, cpu, count);
+		update_runtime_stat(st, STAT_BRANCHES, cpu, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
-		update_runtime_stat(st, STAT_CACHEREFS, ctx, cpu, count);
+		update_runtime_stat(st, STAT_CACHEREFS, cpu, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
-		update_runtime_stat(st, STAT_L1_DCACHE, ctx, cpu, count);
+		update_runtime_stat(st, STAT_L1_DCACHE, cpu, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
-		update_runtime_stat(st, STAT_L1_ICACHE, ctx, cpu, count);
+		update_runtime_stat(st, STAT_L1_ICACHE, cpu, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_LL))
-		update_runtime_stat(st, STAT_LL_CACHE, ctx, cpu, count);
+		update_runtime_stat(st, STAT_LL_CACHE, cpu, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_DTLB))
-		update_runtime_stat(st, STAT_DTLB_CACHE, ctx, cpu, count);
+		update_runtime_stat(st, STAT_DTLB_CACHE, cpu, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
-		update_runtime_stat(st, STAT_ITLB_CACHE, ctx, cpu, count);
+		update_runtime_stat(st, STAT_ITLB_CACHE, cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, SMI_NUM))
-		update_runtime_stat(st, STAT_SMI_NUM, ctx, cpu, count);
+		update_runtime_stat(st, STAT_SMI_NUM, cpu, count, &rsd);
 	else if (perf_stat_evsel__is(counter, APERF))
-		update_runtime_stat(st, STAT_APERF, ctx, cpu, count);
+		update_runtime_stat(st, STAT_APERF, cpu, count, &rsd);
 
 	if (counter->collect_stat) {
 		v = saved_value_lookup(counter, cpu, true, STAT_NONE, 0, st);
@@ -422,11 +433,12 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 }
 
 static double runtime_stat_avg(struct runtime_stat *st,
-			       enum stat_type type, int ctx, int cpu)
+			       enum stat_type type, int cpu,
+			       struct runtime_stat_data *rsd)
 {
 	struct saved_value *v;
 
-	v = saved_value_lookup(NULL, cpu, false, type, ctx, st);
+	v = saved_value_lookup(NULL, cpu, false, type, rsd->ctx, st);
 	if (!v)
 		return 0.0;
 
@@ -434,11 +446,12 @@ static double runtime_stat_avg(struct runtime_stat *st,
 }
 
 static double runtime_stat_n(struct runtime_stat *st,
-			     enum stat_type type, int ctx, int cpu)
+			     enum stat_type type, int cpu,
+			     struct runtime_stat_data *rsd)
 {
 	struct saved_value *v;
 
-	v = saved_value_lookup(NULL, cpu, false, type, ctx, st);
+	v = saved_value_lookup(NULL, cpu, false, type, rsd->ctx, st);
 	if (!v)
 		return 0.0;
 
@@ -446,16 +459,15 @@ static double runtime_stat_n(struct runtime_stat *st,
 }
 
 static void print_stalled_cycles_frontend(struct perf_stat_config *config,
-					  int cpu,
-					  struct evsel *evsel, double avg,
+					  int cpu, double avg,
 					  struct perf_stat_output_ctx *out,
-					  struct runtime_stat *st)
+					  struct runtime_stat *st,
+					  struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
-	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_CYCLES, cpu, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -470,16 +482,15 @@ static void print_stalled_cycles_frontend(struct perf_stat_config *config,
 }
 
 static void print_stalled_cycles_backend(struct perf_stat_config *config,
-					 int cpu,
-					 struct evsel *evsel, double avg,
+					 int cpu, double avg,
 					 struct perf_stat_output_ctx *out,
-					 struct runtime_stat *st)
+					 struct runtime_stat *st,
+					 struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
-	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_CYCLES, cpu, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -490,17 +501,15 @@ static void print_stalled_cycles_backend(struct perf_stat_config *config,
 }
 
 static void print_branch_misses(struct perf_stat_config *config,
-				int cpu,
-				struct evsel *evsel,
-				double avg,
+				int cpu, double avg,
 				struct perf_stat_output_ctx *out,
-				struct runtime_stat *st)
+				struct runtime_stat *st,
+				struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
-	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_BRANCHES, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_BRANCHES, cpu, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -511,18 +520,15 @@ static void print_branch_misses(struct perf_stat_config *config,
 }
 
 static void print_l1_dcache_misses(struct perf_stat_config *config,
-				   int cpu,
-				   struct evsel *evsel,
-				   double avg,
+				   int cpu, double avg,
 				   struct perf_stat_output_ctx *out,
-				   struct runtime_stat *st)
-
+				   struct runtime_stat *st,
+				   struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
-	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_L1_DCACHE, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_L1_DCACHE, cpu, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -533,18 +539,15 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
 }
 
 static void print_l1_icache_misses(struct perf_stat_config *config,
-				   int cpu,
-				   struct evsel *evsel,
-				   double avg,
+				   int cpu, double avg,
 				   struct perf_stat_output_ctx *out,
-				   struct runtime_stat *st)
-
+				   struct runtime_stat *st,
+				   struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
-	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_L1_ICACHE, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_L1_ICACHE, cpu, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -554,17 +557,15 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
 }
 
 static void print_dtlb_cache_misses(struct perf_stat_config *config,
-				    int cpu,
-				    struct evsel *evsel,
-				    double avg,
+				    int cpu, double avg,
 				    struct perf_stat_output_ctx *out,
-				    struct runtime_stat *st)
+				    struct runtime_stat *st,
+				    struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
-	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_DTLB_CACHE, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_DTLB_CACHE, cpu, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -574,17 +575,15 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
 }
 
 static void print_itlb_cache_misses(struct perf_stat_config *config,
-				    int cpu,
-				    struct evsel *evsel,
-				    double avg,
+				    int cpu, double avg,
 				    struct perf_stat_output_ctx *out,
-				    struct runtime_stat *st)
+				    struct runtime_stat *st,
+				    struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
-	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_ITLB_CACHE, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_ITLB_CACHE, cpu, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -594,17 +593,15 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
 }
 
 static void print_ll_cache_misses(struct perf_stat_config *config,
-				  int cpu,
-				  struct evsel *evsel,
-				  double avg,
+				  int cpu, double avg,
 				  struct perf_stat_output_ctx *out,
-				  struct runtime_stat *st)
+				  struct runtime_stat *st,
+				  struct runtime_stat_data *rsd)
 {
 	double total, ratio = 0.0;
 	const char *color;
-	int ctx = evsel_context(evsel);
 
-	total = runtime_stat_avg(st, STAT_LL_CACHE, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_LL_CACHE, cpu, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -662,56 +659,61 @@ static double sanitize_val(double x)
 	return x;
 }
 
-static double td_total_slots(int ctx, int cpu, struct runtime_stat *st)
+static double td_total_slots(int cpu, struct runtime_stat *st,
+			     struct runtime_stat_data *rsd)
 {
-	return runtime_stat_avg(st, STAT_TOPDOWN_TOTAL_SLOTS, ctx, cpu);
+	return runtime_stat_avg(st, STAT_TOPDOWN_TOTAL_SLOTS, cpu, rsd);
 }
 
-static double td_bad_spec(int ctx, int cpu, struct runtime_stat *st)
+static double td_bad_spec(int cpu, struct runtime_stat *st,
+			  struct runtime_stat_data *rsd)
 {
 	double bad_spec = 0;
 	double total_slots;
 	double total;
 
-	total = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_ISSUED, ctx, cpu) -
-		runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED, ctx, cpu) +
-		runtime_stat_avg(st, STAT_TOPDOWN_RECOVERY_BUBBLES, ctx, cpu);
+	total = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_ISSUED, cpu, rsd) -
+		runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED, cpu, rsd) +
+		runtime_stat_avg(st, STAT_TOPDOWN_RECOVERY_BUBBLES, cpu, rsd);
 
-	total_slots = td_total_slots(ctx, cpu, st);
+	total_slots = td_total_slots(cpu, st, rsd);
 	if (total_slots)
 		bad_spec = total / total_slots;
 	return sanitize_val(bad_spec);
 }
 
-static double td_retiring(int ctx, int cpu, struct runtime_stat *st)
+static double td_retiring(int cpu, struct runtime_stat *st,
+			  struct runtime_stat_data *rsd)
 {
 	double retiring = 0;
-	double total_slots = td_total_slots(ctx, cpu, st);
+	double total_slots = td_total_slots(cpu, st, rsd);
 	double ret_slots = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED,
-					    ctx, cpu);
+					    cpu, rsd);
 
 	if (total_slots)
 		retiring = ret_slots / total_slots;
 	return retiring;
 }
 
-static double td_fe_bound(int ctx, int cpu, struct runtime_stat *st)
+static double td_fe_bound(int cpu, struct runtime_stat *st,
+			  struct runtime_stat_data *rsd)
 {
 	double fe_bound = 0;
-	double total_slots = td_total_slots(ctx, cpu, st);
+	double total_slots = td_total_slots(cpu, st, rsd);
 	double fetch_bub = runtime_stat_avg(st, STAT_TOPDOWN_FETCH_BUBBLES,
-					    ctx, cpu);
+					    cpu, rsd);
 
 	if (total_slots)
 		fe_bound = fetch_bub / total_slots;
 	return fe_bound;
 }
 
-static double td_be_bound(int ctx, int cpu, struct runtime_stat *st)
+static double td_be_bound(int cpu, struct runtime_stat *st,
+			  struct runtime_stat_data *rsd)
 {
-	double sum = (td_fe_bound(ctx, cpu, st) +
-		      td_bad_spec(ctx, cpu, st) +
-		      td_retiring(ctx, cpu, st));
+	double sum = (td_fe_bound(cpu, st, rsd) +
+		      td_bad_spec(cpu, st, rsd) +
+		      td_retiring(cpu, st, rsd));
 	if (sum == 0)
 		return 0;
 	return sanitize_val(1.0 - sum);
@@ -722,15 +724,15 @@ static double td_be_bound(int ctx, int cpu, struct runtime_stat *st)
  * the ratios we need to recreate the sum.
  */
 
-static double td_metric_ratio(int ctx, int cpu,
-			      enum stat_type type,
-			      struct runtime_stat *stat)
+static double td_metric_ratio(int cpu, enum stat_type type,
+			      struct runtime_stat *stat,
+			      struct runtime_stat_data *rsd)
 {
-	double sum = runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, ctx, cpu) +
-		runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, ctx, cpu) +
-		runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, ctx, cpu) +
-		runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, ctx, cpu);
-	double d = runtime_stat_avg(stat, type, ctx, cpu);
+	double sum = runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, cpu, rsd) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, cpu, rsd) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, cpu, rsd) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, cpu, rsd);
+	double d = runtime_stat_avg(stat, type, cpu, rsd);
 
 	if (sum)
 		return d / sum;
@@ -742,34 +744,33 @@ static double td_metric_ratio(int ctx, int cpu,
  * We allow two missing.
  */
 
-static bool full_td(int ctx, int cpu,
-		    struct runtime_stat *stat)
+static bool full_td(int cpu, struct runtime_stat *stat,
+		    struct runtime_stat_data *rsd)
 {
 	int c = 0;
 
-	if (runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, ctx, cpu) > 0)
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, cpu, rsd) > 0)
 		c++;
-	if (runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, ctx, cpu) > 0)
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, cpu, rsd) > 0)
 		c++;
-	if (runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, ctx, cpu) > 0)
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, cpu, rsd) > 0)
 		c++;
-	if (runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, ctx, cpu) > 0)
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, cpu, rsd) > 0)
 		c++;
 	return c >= 2;
 }
 
-static void print_smi_cost(struct perf_stat_config *config,
-			   int cpu, struct evsel *evsel,
+static void print_smi_cost(struct perf_stat_config *config, int cpu,
 			   struct perf_stat_output_ctx *out,
-			   struct runtime_stat *st)
+			   struct runtime_stat *st,
+			   struct runtime_stat_data *rsd)
 {
 	double smi_num, aperf, cycles, cost = 0.0;
-	int ctx = evsel_context(evsel);
 	const char *color = NULL;
 
-	smi_num = runtime_stat_avg(st, STAT_SMI_NUM, ctx, cpu);
-	aperf = runtime_stat_avg(st, STAT_APERF, ctx, cpu);
-	cycles = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+	smi_num = runtime_stat_avg(st, STAT_SMI_NUM, cpu, rsd);
+	aperf = runtime_stat_avg(st, STAT_APERF, cpu, rsd);
+	cycles = runtime_stat_avg(st, STAT_CYCLES, cpu, rsd);
 
 	if ((cycles == 0) || (aperf == 0))
 		return;
@@ -930,12 +931,14 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	print_metric_t print_metric = out->print_metric;
 	double total, ratio = 0.0, total2;
 	const char *color = NULL;
-	int ctx = evsel_context(evsel);
+	struct runtime_stat_data rsd = {
+		.ctx = evsel_context(evsel),
+	};
 	struct metric_event *me;
 	int num = 1;
 
 	if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
-		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+		total = runtime_stat_avg(st, STAT_CYCLES, cpu, &rsd);
 
 		if (total) {
 			ratio = avg / total;
@@ -945,12 +948,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, "insn per cycle", 0);
 		}
 
-		total = runtime_stat_avg(st, STAT_STALLED_CYCLES_FRONT,
-					 ctx, cpu);
+		total = runtime_stat_avg(st, STAT_STALLED_CYCLES_FRONT, cpu, &rsd);
 
 		total = max(total, runtime_stat_avg(st,
 						    STAT_STALLED_CYCLES_BACK,
-						    ctx, cpu));
+						    cpu, &rsd));
 
 		if (total && avg) {
 			out->new_line(config, ctxp);
@@ -960,8 +962,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					ratio);
 		}
 	} else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
-		if (runtime_stat_n(st, STAT_BRANCHES, ctx, cpu) != 0)
-			print_branch_misses(config, cpu, evsel, avg, out, st);
+		if (runtime_stat_n(st, STAT_BRANCHES, cpu, &rsd) != 0)
+			print_branch_misses(config, cpu, avg, out, st, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all branches", 0);
 	} else if (
@@ -970,8 +972,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
-			print_l1_dcache_misses(config, cpu, evsel, avg, out, st);
+		if (runtime_stat_n(st, STAT_L1_DCACHE, cpu, &rsd) != 0)
+			print_l1_dcache_misses(config, cpu, avg, out, st, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache accesses", 0);
 	} else if (
@@ -980,8 +982,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
-			print_l1_icache_misses(config, cpu, evsel, avg, out, st);
+		if (runtime_stat_n(st, STAT_L1_ICACHE, cpu, &rsd) != 0)
+			print_l1_icache_misses(config, cpu, avg, out, st, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all L1-icache accesses", 0);
 	} else if (
@@ -990,8 +992,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
-			print_dtlb_cache_misses(config, cpu, evsel, avg, out, st);
+		if (runtime_stat_n(st, STAT_DTLB_CACHE, cpu, &rsd) != 0)
+			print_dtlb_cache_misses(config, cpu, avg, out, st, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache accesses", 0);
 	} else if (
@@ -1000,8 +1002,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
-			print_itlb_cache_misses(config, cpu, evsel, avg, out, st);
+		if (runtime_stat_n(st, STAT_ITLB_CACHE, cpu, &rsd) != 0)
+			print_itlb_cache_misses(config, cpu, avg, out, st, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache accesses", 0);
 	} else if (
@@ -1010,27 +1012,27 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
-			print_ll_cache_misses(config, cpu, evsel, avg, out, st);
+		if (runtime_stat_n(st, STAT_LL_CACHE, cpu, &rsd) != 0)
+			print_ll_cache_misses(config, cpu, avg, out, st, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all LL-cache accesses", 0);
 	} else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
-		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);
+		total = runtime_stat_avg(st, STAT_CACHEREFS, cpu, &rsd);
 
 		if (total)
 			ratio = avg * 100 / total;
 
-		if (runtime_stat_n(st, STAT_CACHEREFS, ctx, cpu) != 0)
+		if (runtime_stat_n(st, STAT_CACHEREFS, cpu, &rsd) != 0)
 			print_metric(config, ctxp, NULL, "%8.3f %%",
 				     "of all cache refs", ratio);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all cache refs", 0);
 	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND)) {
-		print_stalled_cycles_frontend(config, cpu, evsel, avg, out, st);
+		print_stalled_cycles_frontend(config, cpu, avg, out, st, &rsd);
 	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
-		print_stalled_cycles_backend(config, cpu, evsel, avg, out, st);
+		print_stalled_cycles_backend(config, cpu, avg, out, st, &rsd);
 	} else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
-		total = runtime_stat_avg(st, STAT_NSECS, 0, cpu);
+		total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
 
 		if (total) {
 			ratio = avg / total;
@@ -1039,7 +1041,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, "Ghz", 0);
 		}
 	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX)) {
-		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+		total = runtime_stat_avg(st, STAT_CYCLES, cpu, &rsd);
 
 		if (total)
 			print_metric(config, ctxp, NULL,
@@ -1049,8 +1051,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, "transactional cycles",
 				     0);
 	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX_CP)) {
-		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
-		total2 = runtime_stat_avg(st, STAT_CYCLES_IN_TX, ctx, cpu);
+		total = runtime_stat_avg(st, STAT_CYCLES, cpu, &rsd);
+		total2 = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu, &rsd);
 
 		if (total2 < avg)
 			total2 = avg;
@@ -1060,21 +1062,19 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		else
 			print_metric(config, ctxp, NULL, NULL, "aborted cycles", 0);
 	} else if (perf_stat_evsel__is(evsel, TRANSACTION_START)) {
-		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX,
-					 ctx, cpu);
+		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu, &rsd);
 
 		if (avg)
 			ratio = total / avg;
 
-		if (runtime_stat_n(st, STAT_CYCLES_IN_TX, ctx, cpu) != 0)
+		if (runtime_stat_n(st, STAT_CYCLES_IN_TX, cpu, &rsd) != 0)
 			print_metric(config, ctxp, NULL, "%8.0f",
 				     "cycles / transaction", ratio);
 		else
 			print_metric(config, ctxp, NULL, NULL, "cycles / transaction",
 				      0);
 	} else if (perf_stat_evsel__is(evsel, ELISION_START)) {
-		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX,
-					 ctx, cpu);
+		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu, &rsd);
 
 		if (avg)
 			ratio = total / avg;
@@ -1087,28 +1087,28 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		else
 			print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_BUBBLES)) {
-		double fe_bound = td_fe_bound(ctx, cpu, st);
+		double fe_bound = td_fe_bound(cpu, st, &rsd);
 
 		if (fe_bound > 0.2)
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
 				fe_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_RETIRED)) {
-		double retiring = td_retiring(ctx, cpu, st);
+		double retiring = td_retiring(cpu, st, &rsd);
 
 		if (retiring > 0.7)
 			color = PERF_COLOR_GREEN;
 		print_metric(config, ctxp, color, "%8.1f%%", "retiring",
 				retiring * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RECOVERY_BUBBLES)) {
-		double bad_spec = td_bad_spec(ctx, cpu, st);
+		double bad_spec = td_bad_spec(cpu, st, &rsd);
 
 		if (bad_spec > 0.1)
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
 				bad_spec * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_ISSUED)) {
-		double be_bound = td_be_bound(ctx, cpu, st);
+		double be_bound = td_be_bound(cpu, st, &rsd);
 		const char *name = "backend bound";
 		static int have_recovery_bubbles = -1;
 
@@ -1121,43 +1121,43 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
 		if (be_bound > 0.2)
 			color = PERF_COLOR_RED;
-		if (td_total_slots(ctx, cpu, st) > 0)
+		if (td_total_slots(cpu, st, &rsd) > 0)
 			print_metric(config, ctxp, color, "%8.1f%%", name,
 					be_bound * 100.);
 		else
 			print_metric(config, ctxp, NULL, NULL, name, 0);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RETIRING) &&
-			full_td(ctx, cpu, st)) {
-		double retiring = td_metric_ratio(ctx, cpu,
-						  STAT_TOPDOWN_RETIRING, st);
-
+		   full_td(cpu, st, &rsd)) {
+		double retiring = td_metric_ratio(cpu,
+						  STAT_TOPDOWN_RETIRING, st,
+						  &rsd);
 		if (retiring > 0.7)
 			color = PERF_COLOR_GREEN;
 		print_metric(config, ctxp, color, "%8.1f%%", "retiring",
 				retiring * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FE_BOUND) &&
-			full_td(ctx, cpu, st)) {
-		double fe_bound = td_metric_ratio(ctx, cpu,
-						  STAT_TOPDOWN_FE_BOUND, st);
-
+		   full_td(cpu, st, &rsd)) {
+		double fe_bound = td_metric_ratio(cpu,
+						  STAT_TOPDOWN_FE_BOUND, st,
+						  &rsd);
 		if (fe_bound > 0.2)
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
 				fe_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BE_BOUND) &&
-			full_td(ctx, cpu, st)) {
-		double be_bound = td_metric_ratio(ctx, cpu,
-						  STAT_TOPDOWN_BE_BOUND, st);
-
+		   full_td(cpu, st, &rsd)) {
+		double be_bound = td_metric_ratio(cpu,
+						  STAT_TOPDOWN_BE_BOUND, st,
+						  &rsd);
 		if (be_bound > 0.2)
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "backend bound",
 				be_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BAD_SPEC) &&
-			full_td(ctx, cpu, st)) {
-		double bad_spec = td_metric_ratio(ctx, cpu,
-						  STAT_TOPDOWN_BAD_SPEC, st);
-
+		   full_td(cpu, st, &rsd)) {
+		double bad_spec = td_metric_ratio(cpu,
+						  STAT_TOPDOWN_BAD_SPEC, st,
+						  &rsd);
 		if (bad_spec > 0.1)
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
@@ -1165,11 +1165,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
 				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
-	} else if (runtime_stat_n(st, STAT_NSECS, 0, cpu) != 0) {
+	} else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
 		char unit = 'M';
 		char unit_buf[10];
 
-		total = runtime_stat_avg(st, STAT_NSECS, 0, cpu);
+		total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
 
 		if (total)
 			ratio = 1000.0 * avg / total;
@@ -1180,7 +1180,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
 		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
 	} else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
-		print_smi_cost(config, cpu, evsel, out, st);
+		print_smi_cost(config, cpu, out, st, &rsd);
 	} else {
 		num = 0;
 	}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

