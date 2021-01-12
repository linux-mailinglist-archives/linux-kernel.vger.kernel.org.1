Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548F02F2846
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbhALGPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731792AbhALGPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:15:23 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29ECC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 22:14:42 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id iq13so953237pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 22:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wN9pLJiwK94HF3eBalWpr7E3v2RrQ3uXi1ew2mIgxXg=;
        b=FB5divKvTIkY6EikiTSJ3/yMthNyLFHWrU5gMwC/250lcG6oyKY23nrdwZRt9kMpEP
         hf8TAwHTW6P6Rpjv+lHrnawRSqTZvRhgtsKFdnMGCBM5H9BWDfALhNHCxQb8NsVihnL/
         ERjayeMOG92dYfLzwQkFffGanV08HFCJfbN57ZsQsRpCrmPGheLmMjdoXuWy7FCf0tY8
         9l47EJdiFlnga8IvfZZwzDxhuXl+puTdhoajP9HF9a+KYTDflVFS9NKmlBG2lnJw2UrV
         hwm39ogCO6+s7gfaqQfu2+nD7PR2ORpWMpbM1hnj8yNrdtVBVmczlmWAylSZtA6ksvje
         zdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wN9pLJiwK94HF3eBalWpr7E3v2RrQ3uXi1ew2mIgxXg=;
        b=n6tjqGkxcWzS9pPPDKUg2E7qM9Q+BeKo9WfiExXO7pJRICpc+BtA05z1wMlXd3Lvnr
         l239W4WijC88pWSOk0DaCDYDfQcW0011YgoZetUWXPr0OkSBH8BFEWqV4iL3rspudbEY
         DBq7QRkrAtQeroJHp9C4mzYKQr8YqBggavs+bPULVCH5jVmCDwfm+vSkfB5V2tHclfK4
         owTN8wXPr9zb3nkqPauYPTmkmp+AkPwI+2/kmA9DuYQmLRe10t/OPvCdz4c+ZfyTho4G
         xRXGglhAy3mNepaZM9LB1KUJtPSeY/xqiPXPtwLcqNgW/+CMPb2xlj7KddZ70lmixKPy
         Zd8A==
X-Gm-Message-State: AOAM533+Jh61KLObZCoe0h3xwt1D8qyUFM8jwCFaoleQFH1chRoIqu+/
        onZiNIEh/Y+KZ48UIZxVTM4=
X-Google-Smtp-Source: ABdhPJwODX+GZkcqJEnvaeMu/3G0PJt8tdbT6OPbVqnomFj3dNlIkJghnfz6aSxLySLb6KhLgdu+Rg==
X-Received: by 2002:a17:90a:5a86:: with SMTP id n6mr208504pji.65.1610432082344;
        Mon, 11 Jan 2021 22:14:42 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id a19sm1616514pfi.130.2021.01.11.22.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 22:14:41 -0800 (PST)
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
Subject: [PATCH v2 2/2] perf stat: Take cgroups into account for shadow stats
Date:   Tue, 12 Jan 2021 15:14:31 +0900
Message-Id: <20210112061431.1122838-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210112061431.1122838-1-namhyung@kernel.org>
References: <20210112061431.1122838-1-namhyung@kernel.org>
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
 tools/perf/util/stat-shadow.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index a1565b6e38f2..12eafd12a693 100644
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
@@ -197,6 +204,7 @@ void perf_stat__reset_shadow_per_stat(struct runtime_stat *st)
 
 struct runtime_stat_data {
 	int ctx;
+	struct cgroup *cgrp;
 };
 
 static void update_runtime_stat(struct runtime_stat *st,
@@ -205,7 +213,7 @@ static void update_runtime_stat(struct runtime_stat *st,
 				struct runtime_stat_data *rsd)
 {
 	struct saved_value *v = saved_value_lookup(NULL, cpu, true, type,
-						   rsd->ctx, st);
+						   rsd->ctx, st, rsd->cgrp);
 
 	if (v)
 		update_stats(&v->stats, count);
@@ -223,6 +231,7 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 	struct saved_value *v;
 	struct runtime_stat_data rsd = {
 		.ctx = evsel_context(counter),
+		.cgrp = counter->cgrp,
 	};
 
 	count *= counter->scale;
@@ -290,13 +299,14 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 		update_runtime_stat(st, STAT_APERF, cpu, count, &rsd);
 
 	if (counter->collect_stat) {
-		v = saved_value_lookup(counter, cpu, true, STAT_NONE, 0, st);
+		v = saved_value_lookup(counter, cpu, true, STAT_NONE, 0, st,
+				       rsd.cgrp);
 		update_stats(&v->stats, count);
 		if (counter->metric_leader)
 			v->metric_total += count;
 	} else if (counter->metric_leader) {
 		v = saved_value_lookup(counter->metric_leader,
-				       cpu, true, STAT_NONE, 0, st);
+				       cpu, true, STAT_NONE, 0, st, rsd.cgrp);
 		v->metric_total += count;
 		v->metric_other++;
 	}
@@ -438,7 +448,7 @@ static double runtime_stat_avg(struct runtime_stat *st,
 {
 	struct saved_value *v;
 
-	v = saved_value_lookup(NULL, cpu, false, type, rsd->ctx, st);
+	v = saved_value_lookup(NULL, cpu, false, type, rsd->ctx, st, rsd->cgrp);
 	if (!v)
 		return 0.0;
 
@@ -451,7 +461,7 @@ static double runtime_stat_n(struct runtime_stat *st,
 {
 	struct saved_value *v;
 
-	v = saved_value_lookup(NULL, cpu, false, type, rsd->ctx, st);
+	v = saved_value_lookup(NULL, cpu, false, type, rsd->ctx, st, rsd->cgrp);
 	if (!v)
 		return 0.0;
 
@@ -805,7 +815,8 @@ static int prepare_metric(struct evsel **metric_events,
 			scale = 1e-9;
 		} else {
 			v = saved_value_lookup(metric_events[i], cpu, false,
-					       STAT_NONE, 0, st);
+					       STAT_NONE, 0, st,
+					       metric_events[i]->cgrp);
 			if (!v)
 				break;
 			stats = &v->stats;
@@ -933,6 +944,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	const char *color = NULL;
 	struct runtime_stat_data rsd = {
 		.ctx = evsel_context(evsel),
+		.cgrp = evsel->cgrp,
 	};
 	struct metric_event *me;
 	int num = 1;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

