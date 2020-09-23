Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94A8274ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgIWCAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIWCAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:00:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6FCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 19:00:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fa1so2406953pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 19:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPGrsxjc6QkcLCG/vgH0MrqubH3+gm8LWJMcuvOD5/Q=;
        b=IeHGG5DJgZ9znIhaX7oMlqEHRoQo9yuVEKVDsKmFqPFFJfuZ7bBrsRf7+ipLgAtFLy
         EFiyKTPhpkoWSLvJLml1sXoXKYo0WMK+NuPX8J7FU1LHuslZUZKf8EIque5QY2NYroun
         V0LfiBxfj6N3vyr01irlw+omRxbjj4k8WqrSrU6HQHyctEpp9IEHINIAhdS3gxh1SAQG
         z2jbcS67L3VGaqLvne8BUbZWAvmisqGhaaH5s4bhWXBR4gUuzRzgCazJY1YWtx2hsvOk
         /C2kN+U7xgTpXEDppvEa98TKNidX20SQWW+s8L7/qLxf4M9YjU6x2hP4xFiF0WSkeIbR
         CJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aPGrsxjc6QkcLCG/vgH0MrqubH3+gm8LWJMcuvOD5/Q=;
        b=KNDx3afzm85/DBFmEfYkkduoPVjK0WknRjVmURc8h+X6M8kkZlkf6F91PwpXrHctPi
         GLF+nAwKluBPk4uTfPtqRjtyA5tr78DPMVJrtcZbJfPI3iMXTJO9W0522V5XqYucZMLn
         WhuM7X1MMsw/QfBs5MX12NPyxbKfTw3HQd8WNlzEtk7ikZelSkD4fwZ/8WOkEwU+40N9
         dH+V9YlSlAiP+hvQljRrBoHbzmhkvhRAYzZNv49FpzOu+Cw5sAJJDukYTNy5A4EQjSN+
         nzu4reQ2YNLqhGoivIT9hp4LfBq+dY2wCowSuAVqwDNg2xpZNkZyg1PEsdo2Eu2APugO
         RvjA==
X-Gm-Message-State: AOAM533zCK8cOtS42ZuYYcVtdNxQaKV0QEzFMHz35bN4Z2V2lo2+8GqE
        RH04Y7z/TULyM3limi5lOjgiZtwiKNs=
X-Google-Smtp-Source: ABdhPJwrwnr0cZ4mJD2L9yV1W17G3j9MWHYIkTuWxX2QvMR3GcIlbcH/rv+PtlGDXesGC1zjnPc5Ww==
X-Received: by 2002:a17:90a:e513:: with SMTP id t19mr6151746pjy.137.1600826403447;
        Tue, 22 Sep 2020 19:00:03 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v13sm3367741pjr.12.2020.09.22.18.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 19:00:02 -0700 (PDT)
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
Date:   Wed, 23 Sep 2020 10:59:43 +0900
Message-Id: <20200923015945.47535-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923015945.47535-1-namhyung@kernel.org>
References: <20200923015945.47535-1-namhyung@kernel.org>
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
 tools/perf/util/metricgroup.c | 85 +++++++++++++++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  6 +++
 7 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 23abf14b6e16..66a33d97192d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2255,7 +2255,8 @@ int cmd_stat(int argc, const char **argv)
 			goto out;
 		}
 
-		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list) < 0)
+		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
+					  &stat_config.metric_events) < 0)
 			goto out;
 	}
 
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 8b6a4fa49082..dcd18ef268a1 100644
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
@@ -216,6 +221,8 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
 	/* save original events and init evlist */
 	perf_evlist__splice_list_tail(orig_list, &evlist->core.entries);
 	evlist->core.nr_entries = 0;
+	orig_metric_events = *metric_events;
+	rblist__init(metric_events);
 
 	for (;;) {
 		p = strchr(str, ',');
@@ -255,6 +262,11 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
 		cgroup__put(cgrp);
 		nr_cgroups++;
 
+		perf_stat__collect_metric_expr(tmp_list);
+		if (metricgroup__copy_metric_events(tmp_list, cgrp, metric_events,
+						    &orig_metric_events) < 0)
+			break;
+
 		perf_evlist__splice_list_tail(evlist, &tmp_list->core.entries);
 		tmp_list->core.nr_entries = 0;
 
@@ -268,6 +280,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str)
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
index ee7b576d3b12..aae79b2b5041 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1964,3 +1964,14 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 
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
index d03bac65a3c2..14e8f13e07f7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -24,6 +24,7 @@
 #include <api/fs/fs.h>
 #include "util.h"
 #include <asm/bug.h>
+#include "cgroup.h"
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
@@ -1105,3 +1106,87 @@ bool metricgroup__has_metric(const char *metric)
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
-- 
2.28.0.681.g6f77f65b4e-goog

