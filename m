Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30461EBACD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 13:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgFBLvo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Jun 2020 07:51:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45593 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728234AbgFBLvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:39 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-YPX-_1ziP6mfQ9NV3VyN8Q-1; Tue, 02 Jun 2020 07:51:32 -0400
X-MC-Unique: YPX-_1ziP6mfQ9NV3VyN8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 249EE1030980;
        Tue,  2 Jun 2020 11:51:31 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4DD110013D7;
        Tue,  2 Jun 2020 11:51:28 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 12/13] perf tests: Add parse metric test for ipc metric
Date:   Tue,  2 Jun 2020 13:50:54 +0200
Message-Id: <20200602115055.1168446-13-jolsa@kernel.org>
In-Reply-To: <20200602115055.1168446-1-jolsa@kernel.org>
References: <20200602115055.1168446-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new test that process metrics code and checks
the expected results. Starting with easy ipc metric.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   4 +
 tools/perf/tests/parse-metric.c | 145 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 4 files changed, 151 insertions(+)
 create mode 100644 tools/perf/tests/parse-metric.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index cd00498a5dce..84352fc49a20 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -59,6 +59,7 @@ perf-y += genelf.o
 perf-y += api-io.o
 perf-y += demangle-java-test.o
 perf-y += pfm.o
+perf-y += parse-metric.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index da5b6cc23f25..d328caaba45d 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -337,6 +337,10 @@ static struct test generic_tests[] = {
 		.desc = "Demangle Java",
 		.func = test__demangle_java,
 	},
+	{
+		.desc = "Parse and process metrics",
+		.func = test__parse_metric,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
new file mode 100644
index 000000000000..717a73fa7446
--- /dev/null
+++ b/tools/perf/tests/parse-metric.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <string.h>
+#include <perf/cpumap.h>
+#include <perf/evlist.h>
+#include "metricgroup.h"
+#include "tests.h"
+#include "pmu-events/pmu-events.h"
+#include "evlist.h"
+#include "rblist.h"
+#include "debug.h"
+#include "expr.h"
+#include "stat.h"
+
+static struct pmu_event pme_test[] = {
+{
+	.metric_expr	= "inst_retired.any / cpu_clk_unhalted.thread",
+	.metric_name	= "IPC",
+},
+};
+
+static struct pmu_events_map map = {
+	.cpuid		= "test",
+	.version	= "1",
+	.type		= "core",
+	.table		= pme_test,
+};
+
+struct value {
+	const char	*event;
+	u64		 val;
+};
+
+static u64 find_value(const char *name, struct value *values)
+{
+	struct value *v = values;
+
+	while (v->event) {
+		if (!strcmp(name, v->event))
+			return v->val;
+		v++;
+	};
+	return 0;
+}
+
+static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
+			      struct value *vals)
+{
+	struct evsel *evsel;
+	u64 count;
+
+	evlist__for_each_entry(evlist, evsel) {
+		count = find_value(evsel->name, vals);
+		perf_stat__update_shadow_stats(evsel, count, 0, st);
+	}
+}
+
+static double compute_single(struct rblist *metric_events, struct evlist *evlist,
+			     struct runtime_stat *st)
+{
+	struct evsel *evsel = evlist__first(evlist);
+	struct metric_event *me;
+
+	me = metricgroup__lookup(metric_events, evsel, false);
+	if (me != NULL) {
+		struct metric_expr *mexp;
+
+		mexp = list_first_entry(&me->head, struct metric_expr, nd);
+		return test_generic_metric(mexp, 0, st);
+	}
+	return 0.;
+}
+
+static int compute_metric(const char *name, struct value *vals, double *ratio)
+{
+	struct rblist metric_events = {
+		.nr_entries = 0,
+	};
+	struct perf_cpu_map *cpus;
+	struct runtime_stat st;
+	struct evlist *evlist;
+	int err;
+
+	/*
+	 * We need to prepare evlist for stat mode running on CPU 0
+	 * because that's where all the stats are going to be created.
+	 */
+	evlist = evlist__new();
+	if (!evlist)
+		return -ENOMEM;
+
+	cpus = perf_cpu_map__new("0");
+	if (!cpus)
+		return -ENOMEM;
+
+	perf_evlist__set_maps(&evlist->core, cpus, NULL);
+
+	/* Parse the metric into metric_events list. */
+	err = metricgroup__parse_groups_test(evlist, &map, name,
+					     false, false,
+					     &metric_events);
+
+	TEST_ASSERT_VAL("failed to parse metric", err == 0);
+
+	if (perf_evlist__alloc_stats(evlist, false))
+		return -1;
+
+	/* Load the runtime stats with given numbers for events. */
+	runtime_stat__init(&st);
+	load_runtime_stat(&st, evlist, vals);
+
+	/* And execute the metric */
+	*ratio = compute_single(&metric_events, evlist, &st);
+
+	/* ... clenup. */
+	metricgroup__rblist_exit(&metric_events);
+	runtime_stat__exit(&st);
+	perf_evlist__free_stats(evlist);
+	perf_cpu_map__put(cpus);
+	evlist__delete(evlist);
+	return 0;
+}
+
+static int test_ipc(void)
+{
+	double ratio;
+	struct value vals[] = {
+		{ .event = "inst_retired.any",        .val = 300 },
+		{ .event = "cpu_clk_unhalted.thread", .val = 200 },
+		{ 0 },
+	};
+
+	TEST_ASSERT_VAL("failed to compute metric",
+			compute_metric("IPC", vals, &ratio) == 0);
+
+	TEST_ASSERT_VAL("IPC failed, wrong ratio",
+			ratio == 1.5);
+	return 0;
+}
+
+int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
+	return 0;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 76a4e352eaaf..4447a516c689 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -121,6 +121,7 @@ int test__demangle_java(struct test *test, int subtest);
 int test__pfm(struct test *test, int subtest);
 const char *test__pfm_subtest_get_desc(int subtest);
 int test__pfm_subtest_get_nr(void);
+int test__parse_metric(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__bp_account_is_supported(void);
-- 
2.25.4

