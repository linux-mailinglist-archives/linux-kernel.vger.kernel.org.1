Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A639D271F30
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgIUJqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIUJq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:46:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7AAC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:46:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id bw23so4327070pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gxHmioJ8Hf4fLHexw3SoFoKqCG3plhPBfB3eOUlXog=;
        b=ge8tnC+/adcu90FgQ2UCX7MfY+wEaWdb69pViBUsadei8cIzh6D8KRYR1fNFTNFkww
         405CJmoYxD1gFuIDF7vPDzQE5gmY+dngJjHRH8l48YeOJg0AcBD7Mlec8Z9WTauvskQd
         liKolxfOQiehqu67Wm3TZWhS0W5VhIHTACvm2jfiPP39dPrEKALmB/bHIV00Ts9Y+CWu
         6afoF2DRbBilv61YOOFlV1yd6mNelu8nycsVpJ89jg61lGJf0TsXatr+/411n87qzzoN
         Ifl7SeKuGeWCK6tV4930MiboPAFVsUvX9geSGjS5LK+PRJT/5q/rzGfUgHfo03rVsKGP
         VgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0gxHmioJ8Hf4fLHexw3SoFoKqCG3plhPBfB3eOUlXog=;
        b=s2/mvpnnnYko0P6Agkn79xAMeMrcXqycfiNK+BnxF9d+n1PCibDirobv+l6Sd07BXj
         FSwqpe3wWuFUxBduLlKztQoULGP8xLe9MpXlRcHYFgR1fXo/2/HN1yC/aF1RRzTyTxhV
         nusiARmcCO4kWYtxtUSJgLCO/Y2X1nr6t8ZP4c7b2ihkEYABDawHUEV/s4Ey+U/Rp2aX
         11Ku/GH+ITRVRajfLsnUdFwxJsrqRJoWOIuvgSZnf5Y4dCHFJBaMkAE7MGj3YqFr9FI8
         tlkEhZbb1hi1/mj4jIvTNbBj9VqpBn4gmQfVdtI0hd0nfs0Wiy/mH5e32AISKV+BxXpU
         XlCQ==
X-Gm-Message-State: AOAM532y6gb19wb1GsZR57wfTAb7fDoVtPpGsaXSGyJjlgMd1ro70bJg
        wUGgFDVsmuCfn65hMifUix4=
X-Google-Smtp-Source: ABdhPJwld/mbTNzQ3+diySDjeiqqJ76fDaO3OilWmI3q4YBhgZQkypb5Fmv7gahzxNEJyGtie88VXA==
X-Received: by 2002:a17:90a:f992:: with SMTP id cq18mr23976331pjb.172.1600681587484;
        Mon, 21 Sep 2020 02:46:27 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id x192sm11199984pfc.142.2020.09.21.02.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 02:46:26 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH 3/5] perf tools: Copy metric events properly when expand cgroups
Date:   Mon, 21 Sep 2020 18:46:08 +0900
Message-Id: <20200921094610.83736-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200921094610.83736-1-namhyung@kernel.org>
References: <20200921094610.83736-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The metricgroup__copy_metric_events() is to handle metrics events when
expanding event for cgroups.  As the metric events keep pointers to
evsel, it should be refreshed when events are cloned during the
operation.

The perf_stat__collect_metric_expr() is also called in case an event
has a metric directly.

During the copy, it references evsel by index as the evlist now has
cloned evsels for the given cgroup.

Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c     |  3 +-
 tools/perf/util/cgroup.c      | 15 ++++++-
 tools/perf/util/cgroup.h      |  4 +-
 tools/perf/util/evlist.c      | 11 +++++
 tools/perf/util/evlist.h      |  1 +
 tools/perf/util/metricgroup.c | 83 +++++++++++++++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  6 +++
 7 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a43e58e0a088..8b81d62ab18b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2248,7 +2248,8 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 
 	if (stat_config.cgroup_list) {
-		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list) < 0)
+		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
+					  &stat_config.metric_events) < 0)
 			goto out;
 	}
 
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index e4916ed740ac..adf60597520b 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -3,6 +3,9 @@
 #include "evsel.h"
 #include "cgroup.h"
 #include "evlist.h"
+#include "rblist.h"
+#include "metricgroup.h"
+#include "stat.h"
 #include <linux/zalloc.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -198,10 +201,12 @@ int parse_cgroups(const struct option *opt, const char *str,
 	return 0;
 }
 
-int evlist__expand_cgroup(struct evlist *evlist, const char *str)
+int evlist__expand_cgroup(struct evlist *evlist, const char *str,
+			  struct rblist *metric_events)
 {
 	struct evlist *orig_list, *tmp_list;
 	struct evsel *pos, *evsel, *leader;
+	struct rblist orig_metric_events;
 	struct cgroup *cgrp = NULL;
 	const char *p, *e, *eos = str + strlen(str);
 	int ret = -1;
@@ -221,6 +226,8 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
 	/* save original events and init evlist */
 	perf_evlist__splice_list_tail(orig_list, &evlist->core.entries);
 	evlist->core.nr_entries = 0;
+	orig_metric_events = *metric_events;
+	rblist__init(metric_events);
 
 	for (;;) {
 		p = strchr(str, ',');
@@ -260,6 +267,11 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
 		cgroup__put(cgrp);
 		nr_cgroups++;
 
+		perf_stat__collect_metric_expr(tmp_list);
+		if (metricgroup__copy_metric_events(tmp_list, cgrp, metric_events,
+						    &orig_metric_events) < 0)
+			break;
+
 		perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
 		tmp_list->core.nr_entries = 0;
 
@@ -273,6 +285,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
 out_err:
 	evlist__delete(orig_list);
 	evlist__delete(tmp_list);
+	rblist__exit(&orig_metric_events);
 
 	return ret;
 }
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 32893018296f..eea6df8ee373 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -22,9 +22,11 @@ struct cgroup *cgroup__get(struct cgroup *cgroup);
 void cgroup__put(struct cgroup *cgroup);
 
 struct evlist;
+struct rblist;
 
 struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
-int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups);
+int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups,
+			  struct rblist *metric_events);
 
 void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ee7b576d3b12..424209c4bcd2 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1964,3 +1964,14 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 
 	return err;
 }
+
+struct evsel *evlist__get_evsel(struct evlist *evlist, int idx)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->idx == idx)
+			return evsel;
+	}
+	return NULL;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index bc38a53f6a1a..8c5721cb14b2 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -386,4 +386,5 @@ int evlist__ctlfd_ack(struct evlist *evlist);
 #define EVLIST_ENABLED_MSG "Events enabled\n"
 #define EVLIST_DISABLED_MSG "Events disabled\n"
 
+struct evsel *evlist__get_evsel(struct evlist *evlist, int idx);
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index d03bac65a3c2..a88bd125880a 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -24,6 +24,7 @@
 #include <api/fs/fs.h>
 #include "util.h"
 #include <asm/bug.h>
+#include "cgroup.h"
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
@@ -1105,3 +1106,85 @@ bool metricgroup__has_metric(const char *metric)
 	}
 	return false;
 }
+
+int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
+				    struct rblist *new_metric_events,
+				    struct rblist *old_metric_events)
+{
+	unsigned i;
+
+	for (i = 0; i < rblist__nr_entries(old_metric_events); i++) {
+		struct rb_node *nd;
+		struct metric_event *old_me, *new_me;
+		struct metric_expr *old_expr, *new_expr;
+		struct evsel *evsel;
+		size_t alloc_size;
+		int idx, nr;
+
+		nd = rblist__entry(old_metric_events, i);
+		old_me = container_of(nd, struct metric_event, nd);
+
+		evsel = evlist__get_evsel(evlist, old_me->evsel->idx);
+		new_me = metricgroup__lookup(new_metric_events, evsel, true);
+		if (!new_me)
+			return -ENOMEM;
+
+		pr_debug("copying metric event for cgroup '%s': %s (idx=%d)\n",
+			 cgrp ? cgrp->name : "root", evsel->name, evsel->idx);
+
+		list_for_each_entry(old_expr, &old_me->head, nd) {
+			new_expr = malloc(sizeof(*new_expr));
+			if (!new_expr)
+				return -ENOMEM;
+
+			new_expr->metric_expr = old_expr->metric_expr;
+			new_expr->metric_name = old_expr->metric_name;
+			new_expr->metric_unit = old_expr->metric_unit;
+			new_expr->runtime = old_expr->runtime;
+
+			if (old_expr->metric_refs) {
+				/* calculate number of metric_events */
+				for (nr = 0; old_expr->metric_refs[nr].metric_name; nr++)
+					continue;
+				alloc_size = sizeof(*new_expr->metric_refs);
+				new_expr->metric_refs = calloc(nr + 1, alloc_size);
+				if (!new_expr->metric_refs) {
+					free(new_expr);
+					return -ENOMEM;
+				}
+
+				memcpy(new_expr->metric_refs, old_expr->metric_refs,
+				       nr * alloc_size);
+			} else {
+				new_expr->metric_refs = NULL;
+			}
+
+			/* calculate number of metric_events */
+			for (nr = 0; old_expr->metric_events[nr]; nr++)
+				continue;
+			alloc_size = sizeof(*new_expr->metric_events);
+			new_expr->metric_events = calloc(nr + 1, alloc_size);
+			if (!new_expr->metric_events) {
+				free(new_expr->metric_refs);
+				free(new_expr);
+				return -ENOMEM;
+			}
+
+			/* copy evsel in the same position */
+			for (idx = 0; idx < nr; idx++) {
+				evsel = old_expr->metric_events[idx];
+				evsel = evlist__get_evsel(evlist, evsel->idx);
+				if (evsel == NULL) {
+					free(new_expr->metric_events);
+					free(new_expr->metric_refs);
+					free(new_expr);
+					return -EINVAL;
+				}
+				new_expr->metric_events[idx] = evsel;
+			}
+
+			list_add(&new_expr->nd, &new_me->head);
+		}
+	}
+	return 0;
+}
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 491a5d78252d..ed1b9392e624 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -7,11 +7,13 @@
 #include <stdbool.h>
 #include "pmu-events/pmu-events.h"
 
+struct evlist;
 struct evsel;
 struct evlist;
 struct option;
 struct rblist;
 struct pmu_events_map;
+struct cgroup;
 
 struct metric_event {
 	struct rb_node nd;
@@ -55,4 +57,8 @@ void metricgroup__print(bool metrics, bool groups, char *filter,
 bool metricgroup__has_metric(const char *metric);
 int arch_get_runtimeparam(struct pmu_event *pe __maybe_unused);
 void metricgroup__rblist_exit(struct rblist *metric_events);
+
+int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
+				    struct rblist *new_metric_events,
+				    struct rblist *old_metric_events);
 #endif
-- 
2.28.0.681.g6f77f65b4e-goog

