Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78807277152
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgIXMp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgIXMpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3271C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x123so1827482pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPIN9YERRC7AdqxIx0r0A/EiSGysWqeb1qLsd73tUTs=;
        b=T5VrPL2AFshxa8UmIujGJ09TXTq+gJGwDD82Dbn4LvhdkR+FExKtuY0nBnvC/uilgI
         4YIk0rGXIyasffNM8r9tBhPCYOMKJdWiMrtBvwpV6RIb9LNHpt5byCkc5aMXAQE/dmt+
         bC8J0Vzxbe4bdngl0SEoXYS0qnEug7q6ezve4YRyBvLO9nNqzHDNi8et06vzTPiTkzdS
         QXn9a0X3RNJ74gEd4omWEEiFPqyQDSg30hBogMs7mTa6V89bZOMS1U7j2x0jjx5mh/83
         AOvEb2AkVCRamoxrOyN/HvacvpHAtull53OJjrtEtwBDMdk44D258KclwSKFEYCq12aS
         MJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fPIN9YERRC7AdqxIx0r0A/EiSGysWqeb1qLsd73tUTs=;
        b=S4Z9IbhoAI51jzOsed/UOOkE4fMnCZnlFB3gUbFYxrlGmwE1P8H5ifScb2w2eIiQPx
         Zvu33VDyBtDvMsYGWwAAbcPBjIOISU/g42JwyCXeRRkBujEq8gZJaUi3y8a9qGNPsYyQ
         L6fqT6xBxwq18hib5vtx9ZRIEWHFi6PQr9mrHTFLsWljxTf1elx3LZd5HdmTePtpyzyH
         hQmwIhgXVmmAI7pFHfdoWk8IeL31QTbqVBUazzd5jNcjYhpGxZrr6h2dIhVCNYrOwZqu
         BzDpwK9oQc1S7dF8xrqDaoaz7OFkpD8RzE0bL1g5ibQHO4Q7WoGPCFKmKGOUSn+qtNg6
         8ONg==
X-Gm-Message-State: AOAM530vJThceIRQaRrCesWFieXokEUBjoVyl8Ad8De1TaL/j1ohnL+G
        MwcaCsmztttfRgVlSrdIEPE=
X-Google-Smtp-Source: ABdhPJyWX26cM0aFEdEK+dhdUZLaf62Zgd9Bp/0ixx5i9mZKmEVKmOVzwRVWtevv74MgRnHjlOKNJg==
X-Received: by 2002:a65:4342:: with SMTP id k2mr3798603pgq.343.1600951517519;
        Thu, 24 Sep 2020 05:45:17 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 194sm2690310pfy.44.2020.09.24.05.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:16 -0700 (PDT)
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
        Kajol Jain <kjain@linux.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH 3/5] perf tools: Copy metric events properly when expand cgroups
Date:   Thu, 24 Sep 2020 21:44:53 +0900
Message-Id: <20200924124455.336326-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200924124455.336326-1-namhyung@kernel.org>
References: <20200924124455.336326-1-namhyung@kernel.org>
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

Also kernel test robot found an issue in the python module import
so add empty implementations of those two functions to fix it.

Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c     |  3 +-
 tools/perf/util/cgroup.c      | 23 +++++++++-
 tools/perf/util/cgroup.h      |  4 +-
 tools/perf/util/evlist.c      | 11 +++++
 tools/perf/util/evlist.h      |  1 +
 tools/perf/util/metricgroup.c | 85 +++++++++++++++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  6 +++
 tools/perf/util/python.c      | 19 ++++++++
 8 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0c9e21a29795..2751699a8969 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2234,7 +2234,8 @@ int cmd_stat(int argc, const char **argv)
 			goto out;
 		}
 
-		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list) < 0)
+		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
+					  &stat_config.metric_events) < 0)
 			goto out;
 	}
 
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 8b6a4fa49082..6e64c908fa71 100644
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
@@ -193,10 +196,12 @@ int parse_cgroups(const struct option *opt, const char *str,
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
@@ -217,6 +222,13 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
 	perf_evlist__splice_list_tail(orig_list, &evlist->core.entries);
 	evlist->core.nr_entries = 0;
 
+	if (metric_events) {
+		orig_metric_events = *metric_events;
+		rblist__init(metric_events);
+	} else {
+		rblist__init(&orig_metric_events);
+	}
+
 	for (;;) {
 		p = strchr(str, ',');
 		e = p ? p : eos;
@@ -255,6 +267,14 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
 		cgroup__put(cgrp);
 		nr_cgroups++;
 
+		if (metric_events) {
+			perf_stat__collect_metric_expr(tmp_list);
+			if (metricgroup__copy_metric_events(tmp_list, cgrp,
+							    metric_events,
+							    &orig_metric_events) < 0)
+				break;
+		}
+
 		perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
 		tmp_list->core.nr_entries = 0;
 
@@ -268,6 +288,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
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
index e971daf946d0..8bdf3d2c907c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1969,3 +1969,14 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 
 	return err;
 }
+
+struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
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
index bc38a53f6a1a..e1a450322bc5 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -386,4 +386,5 @@ int evlist__ctlfd_ack(struct evlist *evlist);
 #define EVLIST_ENABLED_MSG "Events enabled\n"
 #define EVLIST_DISABLED_MSG "Events disabled\n"
 
+struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 941702cb6a79..55ea514ac0ce 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -24,6 +24,7 @@
 #include <api/fs/fs.h>
 #include "util.h"
 #include <asm/bug.h>
+#include "cgroup.h"
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
@@ -1120,3 +1121,87 @@ bool metricgroup__has_metric(const char *metric)
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
+		evsel = evlist__find_evsel(evlist, old_me->evsel->idx);
+		if (!evsel)
+			return -EINVAL;
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
+				evsel = evlist__find_evsel(evlist, evsel->idx);
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
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 74f85948d101..ae8edde7c50e 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -15,6 +15,8 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
+#include "stat.h"
+#include "metricgroup.h"
 #include "util/env.h"
 #include <internal/lib.h>
 #include "util.h"
@@ -60,6 +62,23 @@ int parse_callchain_record(const char *arg __maybe_unused,
  */
 struct perf_env perf_env;
 
+/*
+ * Add this one here not to drag util/stat-shadow.c
+ */
+void perf_stat__collect_metric_expr(struct evlist *evsel_list)
+{
+}
+
+/*
+ * Add this one here not to drag util/metricgroup.c
+ */
+int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
+				    struct rblist *new_metric_events,
+				    struct rblist *old_metric_events)
+{
+	return 0;
+}
+
 /*
  * Support debug printing even though util/debug.c is not linked.  That means
  * implementing 'verbose' and 'eprintf'.
-- 
2.28.0.681.g6f77f65b4e-goog

