Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AD126BD28
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgIPGcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgIPGbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:31:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18011C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:31:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bd2so2645886plb.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rps1h9ra698tJdTpkbyViJsRK79aEnA5XOr65AtbmzQ=;
        b=BTQLKZrGRs3wXo0i4paZ8I1pruz1p1rDC4Y5IXwmKi9OVv5PKdZ2qk//e3g5pRdtdE
         wwtg+oBsETzBtnzkuZ6LQilG2lFgVIlUj9nYJSGbfPxh2bxEMlVO/0k2F0B5413z8qvy
         Ruk/2teG4G+jS9h5ohwRtBQvr4RXfKDZVBzdlBGGdZBmPM4AsCmhHvGQZPWguAbGFg1u
         2BWXXbdPA7X0jETHRJ4OHqVCAGQOINSYcIfXLDD5LTAWoyOkHFhwaw0P+m8izkf8rd/1
         B1Nn+NRmMj3yeDlnSmcZ10S0AaMCyIzROklcx/x9NnJG/0853BWt5Ms1jaDS2YOQbTS3
         JWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Rps1h9ra698tJdTpkbyViJsRK79aEnA5XOr65AtbmzQ=;
        b=HNT0ZqfdtxB/JoplyzFdHC3kf5iASLE+Nq65llqn/q8nrSZGlBp/qMWehoB0c9cYs4
         6P4t1DIEpAItHg9AWLWtylUScvRF6FhHqheEW0eg69cMwFxw7pehb2H1CroASjw8VgA0
         08ecEm1uPeEpktxDsYUUf9MTGyvmmaFo1tsw3QMSMiZbHSMHxcWAWsSpCmPoJTYxqJoN
         9J0wtxCgz/S4a2IfBnFcFGUeJa2KC/mJysQ44I+ek3iWHo+yz27aS97+gBGxP5Ju+ILS
         9AmYmZmXfKunASwmbEZqUGf8OezbZ4qbyaz1KwaBpwFOcoWWgM8j4I4fUKnqIKRrr4tu
         xHhg==
X-Gm-Message-State: AOAM530yt6J7MnPqqYfZG4Wpi2B6Ekdy5+EnoCPrXLcklXiUxlsp2UCQ
        ecgajKaJJRH9WIuWdR28NUg=
X-Google-Smtp-Source: ABdhPJx5Q7c/sjFyHTCqbdR+gtr1pNAgf6ZPoUxg44JZQfTR/PtEr2IYSGuSrVFfsQ0N8W79FvXlzQ==
X-Received: by 2002:a17:902:9f84:b029:d1:f2de:d850 with SMTP id g4-20020a1709029f84b02900d1f2ded850mr272354plq.68.1600237911390;
        Tue, 15 Sep 2020 23:31:51 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 203sm15401388pfz.131.2020.09.15.23.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 23:31:50 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 4/4] perf test: Add expand cgroup event test
Date:   Wed, 16 Sep 2020 15:31:29 +0900
Message-Id: <20200916063129.1061487-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200916063129.1061487-1-namhyung@kernel.org>
References: <20200916063129.1061487-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It'll expand given events for cgroups A, B and C.

  $ ./perf test -v expansion
  69: Event expansion for cgroups                      :
  --- start ---
  test child forked, pid 983140
  metric expr 1 / IPC for CPI
  metric expr instructions / cycles for IPC
  found event instructions
  found event cycles
  adding {instructions,cycles}:W
  copying metric event for cgroup 'A': instructions (idx=0)
  copying metric event for cgroup 'B': instructions (idx=0)
  copying metric event for cgroup 'C': instructions (idx=0)
  test child finished with 0
  ---- end ----
  Event expansion for cgroups: Ok

Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c        |   2 +-
 tools/perf/tests/Build           |   1 +
 tools/perf/tests/builtin-test.c  |   4 +
 tools/perf/tests/expand-cgroup.c | 241 +++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h         |   1 +
 tools/perf/util/cgroup.c         |  19 ++-
 tools/perf/util/cgroup.h         |   2 +-
 7 files changed, 261 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/tests/expand-cgroup.c

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8b81d62ab18b..f00600d9903e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2249,7 +2249,7 @@ int cmd_stat(int argc, const char **argv)
 
 	if (stat_config.cgroup_list) {
 		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
-					  &stat_config.metric_events) < 0)
+					  &stat_config.metric_events, true) < 0)
 			goto out;
 	}
 
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 69bea7996f18..4d15bf6041fb 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -61,6 +61,7 @@ perf-y += demangle-java-test.o
 perf-y += pfm.o
 perf-y += parse-metric.o
 perf-y += pe-file-parsing.o
+perf-y += expand-cgroup.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 651b8ea3354a..132bdb3e6c31 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -345,6 +345,10 @@ static struct test generic_tests[] = {
 		.desc = "PE file support",
 		.func = test__pe_file_parsing,
 	},
+	{
+		.desc = "Event expansion for cgroups",
+		.func = test__expand_cgroup_events,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
new file mode 100644
index 000000000000..d5771e4d094f
--- /dev/null
+++ b/tools/perf/tests/expand-cgroup.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tests.h"
+#include "debug.h"
+#include "evlist.h"
+#include "cgroup.h"
+#include "rblist.h"
+#include "metricgroup.h"
+#include "parse-events.h"
+#include "pmu-events/pmu-events.h"
+#include "pfm.h"
+#include <subcmd/parse-options.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+static int test_expand_events(struct evlist *evlist,
+			      struct rblist *metric_events)
+{
+	int i, ret = TEST_FAIL;
+	int nr_events;
+	bool was_group_event;
+	int nr_members;  /* for the first evsel only */
+	const char cgrp_str[] = "A,B,C";
+	const char *cgrp_name[] = { "A", "B", "C" };
+	int nr_cgrps = ARRAY_SIZE(cgrp_name);
+	char **ev_name;
+	struct evsel *evsel;
+
+	TEST_ASSERT_VAL("evlist is empty", !perf_evlist__empty(evlist));
+
+	nr_events = evlist->core.nr_entries;
+	ev_name = calloc(nr_events, sizeof(*ev_name));
+	if (ev_name == NULL) {
+		pr_debug("memory allocation failure\n");
+		return TEST_FAIL;
+	}
+	i = 0;
+	evlist__for_each_entry(evlist, evsel) {
+		ev_name[i] = strdup(evsel->name);
+		if (ev_name[i] == NULL) {
+			pr_debug("memory allocation failure\n");
+			goto out;
+		}
+		i++;
+	}
+	/* remember grouping info */
+	was_group_event = evsel__is_group_event(evlist__first(evlist));
+	nr_members = evlist__first(evlist)->core.nr_members;
+
+	ret = evlist__expand_cgroup(evlist, cgrp_str, metric_events, false);
+	if (ret < 0) {
+		pr_debug("failed to expand events for cgroups\n");
+		goto out;
+	}
+
+	ret = TEST_FAIL;
+	if (evlist->core.nr_entries != nr_events * nr_cgrps) {
+		pr_debug("event count doesn't match\n");
+		goto out;
+	}
+
+	i = 0;
+	evlist__for_each_entry(evlist, evsel) {
+		if (strcmp(evsel->name, ev_name[i % nr_events])) {
+			pr_debug("event name doesn't match:\n");
+			pr_debug("  evsel[%d]: %s\n  expected: %s\n",
+				 i, evsel->name, ev_name[i % nr_events]);
+			goto out;
+		}
+		if (strcmp(evsel->cgrp->name, cgrp_name[i / nr_events])) {
+			pr_debug("cgroup name doesn't match:\n");
+			pr_debug("  evsel[%d]: %s\n  expected: %s\n",
+				 i, evsel->cgrp->name, cgrp_name[i / nr_events]);
+			goto out;
+		}
+
+		if ((i % nr_events) == 0) {
+			if (evsel__is_group_event(evsel) != was_group_event) {
+				pr_debug("event group doesn't match: got %s, expect %s\n",
+					 evsel__is_group_event(evsel) ? "true" : "false",
+					 was_group_event ? "true" : "false");
+				goto out;
+			}
+			if (evsel->core.nr_members != nr_members) {
+				pr_debug("event group member doesn't match: %d vs %d\n",
+					 evsel->core.nr_members, nr_members);
+				goto out;
+			}
+		}
+		i++;
+	}
+	ret = TEST_OK;
+
+out:	for (i = 0; i < nr_events; i++)
+		free(ev_name[i]);
+	free(ev_name);
+	return ret;
+}
+
+static int expand_default_events(void)
+{
+	int ret;
+	struct evlist *evlist;
+	struct rblist metric_events;
+
+	evlist = perf_evlist__new_default();
+	TEST_ASSERT_VAL("failed to get evlist", evlist);
+
+	rblist__init(&metric_events);
+	ret = test_expand_events(evlist, &metric_events);
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int expand_group_events(void)
+{
+	int ret;
+	struct evlist *evlist;
+	struct rblist metric_events;
+	struct parse_events_error err;
+	const char event_str[] = "{cycles,instructions}";
+
+	symbol_conf.event_group = true;
+
+	evlist = evlist__new();
+	TEST_ASSERT_VAL("failed to get evlist", evlist);
+
+	ret = parse_events(evlist, event_str, &err);
+	if (ret < 0) {
+		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
+			 event_str, ret, err.str);
+		parse_events_print_error(&err, event_str);
+		goto out;
+	}
+
+	rblist__init(&metric_events);
+	ret = test_expand_events(evlist, &metric_events);
+out:
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int expand_libpfm_events(void)
+{
+	int ret;
+	struct evlist *evlist;
+	struct rblist metric_events;
+	const char event_str[] = "UNHALTED_CORE_CYCLES";
+	struct option opt = {
+		.value = &evlist,
+	};
+
+	symbol_conf.event_group = true;
+
+	evlist = evlist__new();
+	TEST_ASSERT_VAL("failed to get evlist", evlist);
+
+	ret = parse_libpfm_events_option(&opt, event_str, 0);
+	if (ret < 0) {
+		pr_debug("failed to parse libpfm event '%s', err %d\n",
+			 event_str, ret);
+		goto out;
+	}
+	if (perf_evlist__empty(evlist)) {
+		pr_debug("libpfm was not enabled\n");
+		goto out;
+	}
+
+	rblist__init(&metric_events);
+	ret = test_expand_events(evlist, &metric_events);
+out:
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int expand_metric_events(void)
+{
+	int ret;
+	struct evlist *evlist;
+	struct rblist metric_events;
+	const char metric_str[] = "CPI";
+
+	struct pmu_event pme_test[] = {
+		{
+			.metric_expr	= "instructions / cycles",
+			.metric_name	= "IPC",
+		},
+		{
+			.metric_expr	= "1 / IPC",
+			.metric_name	= "CPI",
+		},
+		{
+			.metric_expr	= NULL,
+			.metric_name	= NULL,
+		},
+	};
+	struct pmu_events_map ev_map = {
+		.cpuid		= "test",
+		.version	= "1",
+		.type		= "core",
+		.table		= pme_test,
+	};
+
+	evlist = evlist__new();
+	TEST_ASSERT_VAL("failed to get evlist", evlist);
+
+	rblist__init(&metric_events);
+	ret = metricgroup__parse_groups_test(evlist, &ev_map, metric_str,
+					     false, false, &metric_events);
+	if (ret < 0) {
+		pr_debug("failed to parse '%s' metric\n", metric_str);
+		goto out;
+	}
+
+	ret = test_expand_events(evlist, &metric_events);
+
+out:
+	metricgroup__rblist_exit(&metric_events);
+	evlist__delete(evlist);
+	return ret;
+}
+
+int test__expand_cgroup_events(struct test *test __maybe_unused,
+			       int subtest __maybe_unused)
+{
+	int ret;
+
+	ret = expand_default_events();
+	TEST_ASSERT_EQUAL("failed to expand default events", ret, 0);
+
+	ret = expand_group_events();
+	TEST_ASSERT_EQUAL("failed to expand event group", ret, 0);
+
+	ret = expand_libpfm_events();
+	TEST_ASSERT_EQUAL("failed to expand event group", ret, 0);
+
+	ret = expand_metric_events();
+	TEST_ASSERT_EQUAL("failed to expand metric events", ret, 0);
+
+	return ret;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index ef0f33c6ba23..c85a2c08e407 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -123,6 +123,7 @@ const char *test__pfm_subtest_get_desc(int subtest);
 int test__pfm_subtest_get_nr(void);
 int test__parse_metric(struct test *test, int subtest);
 int test__pe_file_parsing(struct test *test, int subtest);
+int test__expand_cgroup_events(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index a1bf345a770b..eeffa08251b5 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -52,7 +52,7 @@ static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str
 	return NULL;
 }
 
-static struct cgroup *cgroup__new(const char *name)
+static struct cgroup *cgroup__new(const char *name, bool do_open)
 {
 	struct cgroup *cgroup = zalloc(sizeof(*cgroup));
 
@@ -62,9 +62,14 @@ static struct cgroup *cgroup__new(const char *name)
 		cgroup->name = strdup(name);
 		if (!cgroup->name)
 			goto out_err;
-		cgroup->fd = open_cgroup(name);
-		if (cgroup->fd == -1)
-			goto out_free_name;
+
+		if (do_open) {
+			cgroup->fd = open_cgroup(name);
+			if (cgroup->fd == -1)
+				goto out_free_name;
+		} else {
+			cgroup->fd = -1;
+		}
 	}
 
 	return cgroup;
@@ -80,7 +85,7 @@ struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name)
 {
 	struct cgroup *cgroup = evlist__find_cgroup(evlist, name);
 
-	return cgroup ?: cgroup__new(name);
+	return cgroup ?: cgroup__new(name, true);
 }
 
 static int add_cgroup(struct evlist *evlist, const char *str)
@@ -202,7 +207,7 @@ int parse_cgroups(const struct option *opt, const char *str,
 }
 
 int evlist__expand_cgroup(struct evlist *evlist, const char *str,
-			  struct rblist *metric_events)
+			  struct rblist *metric_events, bool open_cgroup)
 {
 	struct evlist *orig_list, *tmp_list;
 	struct evsel *pos, *evsel, *leader;
@@ -240,7 +245,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 			if (!name)
 				break;
 
-			cgrp = cgroup__new(name);
+			cgrp = cgroup__new(name, open_cgroup);
 			free(name);
 			if (cgrp == NULL)
 				break;
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index eea6df8ee373..162906f3412a 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -26,7 +26,7 @@ struct rblist;
 
 struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
 int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups,
-			  struct rblist *metric_events);
+			  struct rblist *metric_events, bool open_cgroup);
 
 void evlist__set_default_cgroup(struct evlist *evlist, struct cgroup *cgroup);
 
-- 
2.28.0.618.gf4bc123cb7-goog

