Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDEF274ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgIWCAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgIWCAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:00:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9578EC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 19:00:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r19so6019790pls.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 19:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0J1GZssblsauExJHfvbe1syeV45yN+2xWBnYdzuIJ3E=;
        b=cI2uriB/TThzgV6pAOzQorUW9I1CVBbqJ0zbMbQoOC0yyO8OC2WDI2GQvyi64RB+wk
         P+If2GqU7CLFwYbE7nTWWYhGGfFoYuE8gaOHQLbtn/JjQqxLC42xnCtM6g6yMQ68MA6y
         r0tJITQRS0hgmPv0NpDw/bi9YNHz2OaQ+dz0k0gFCPzt6Y3DLtw13x5titXcMdYe77UG
         ZvFrF1RrrYllaTnMr+Hr8hG6xMbV9MkyhLvGtUN9Nns4AusRoMO0JTnCsux0bqCHgSxL
         yG8auKXeYY2U5nB39IxKYVo80or5oxzLVkzSwY3WKB+A38ZY8rh4SfLxwjAPxT6/kMRX
         Ij3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0J1GZssblsauExJHfvbe1syeV45yN+2xWBnYdzuIJ3E=;
        b=ssLJNgvh+f1cEKzQDuIZxZpoWWQcaEQCPl7H+b+TVTd3DlLX59Sg70XqECqLQxeb34
         62gGpUI6KqNUV9cslS7RR29MOJQ1Ts6EUuRjp/kJxkssFjRxzd6ftlIAZsxsSdrVHtrq
         5H3jXC/y/j59nFLG+cjNM66XqsvkfXSOu8NGOnAWgYQwEbKAFYhA08qM9v4shMTqEtXF
         iSe81xYPftEv/KoKYG7S7vnYPWOZCzcAbxMxMvDnfgFlEJhChODUFn8Z7Jzq1hnGhjbl
         3ytMrn8RJI+nhQUwtRcFnp66ED3VCoIRrxU6bMdDa9hV0i49wJLYNB3UQIJEoin2KAK0
         hxWA==
X-Gm-Message-State: AOAM531iVIrqze8sijjIJa7X0IPygzG2a0EexIcxatPtSbTSYrSdp3UH
        s/d/ovsmZ8Mu9MqlTaZ0Gq0=
X-Google-Smtp-Source: ABdhPJxoMPU8H+7OXm7gjNhPcovP5UTZ0b1M2OOaR78DhEAEvCEHYluOZgAjE8fSVQpimhV4wIWL+w==
X-Received: by 2002:a17:90a:7144:: with SMTP id g4mr5784424pjs.80.1600826411028;
        Tue, 22 Sep 2020 19:00:11 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v13sm3367741pjr.12.2020.09.22.19.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 19:00:10 -0700 (PDT)
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
        John Garry <john.garry@huawei.com>
Subject: [PATCH 5/5] perf test: Add expand cgroup event test
Date:   Wed, 23 Sep 2020 10:59:45 +0900
Message-Id: <20200923015945.47535-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923015945.47535-1-namhyung@kernel.org>
References: <20200923015945.47535-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 tools/perf/tests/Build           |   1 +
 tools/perf/tests/builtin-test.c  |   4 +
 tools/perf/tests/expand-cgroup.c | 241 +++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h         |   1 +
 4 files changed, 247 insertions(+)
 create mode 100644 tools/perf/tests/expand-cgroup.c

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
-- 
2.28.0.681.g6f77f65b4e-goog

