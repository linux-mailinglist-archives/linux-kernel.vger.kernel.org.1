Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5F71E03C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 00:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbgEXWnP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 24 May 2020 18:43:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55301 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388629AbgEXWnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:43:12 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-2RDheh4OMEyjmavDF6JLtQ-1; Sun, 24 May 2020 18:43:07 -0400
X-MC-Unique: 2RDheh4OMEyjmavDF6JLtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3195835B40;
        Sun, 24 May 2020 22:43:05 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7643A6ED9C;
        Sun, 24 May 2020 22:43:03 +0000 (UTC)
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
Subject: [PATCH 14/14] perf tests: Add parse metric test for frontend metric
Date:   Mon, 25 May 2020 00:42:19 +0200
Message-Id: <20200524224219.234847-15-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-1-jolsa@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new metri test for frontend metric. It's stolen
from x86 pmu events.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/parse-metric.c | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 3005d27c5c48..38f20850bba3 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -15,6 +15,11 @@ static struct pmu_event pme_test[] = {
 	.metric_expr	= "inst_retired.any / cpu_clk_unhalted.thread",
 	.metric_name	= "IPC",
 },
+{
+	.metric_expr	= "idq_uops_not_delivered.core / (4 * (( ( cpu_clk_unhalted.thread / 2 ) * "
+			  "( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) )))",
+	.metric_name	= "Frontend_Bound_SMT",
+},
 };
 
 static struct pmu_events_map map = {
@@ -110,8 +115,49 @@ static int test_ipc(void)
 	return 0;
 }
 
+static int test_frontend(void)
+{
+	double ratio;
+	struct rblist metric_events = { 0 };
+	struct evlist *evlist;
+	struct evsel *evsel;
+	struct value vals[] = {
+		{ .event = "idq_uops_not_delivered.core",        .val = 300 },
+		{ .event = "cpu_clk_unhalted.thread",            .val = 200 },
+		{ .event = "cpu_clk_unhalted.one_thread_active", .val = 400 },
+		{ .event = "cpu_clk_unhalted.ref_xclk",          .val = 600 },
+		{ 0 },
+	};
+	struct runtime_stat st;
+	int err;
+
+	evlist = evlist__new();
+	if (!evlist)
+		return -1;
+
+	err = metricgroup__parse_groups_test(evlist, &map,
+					     "Frontend_Bound_SMT",
+					     false, false,
+					     &metric_events);
+
+	TEST_ASSERT_VAL("failed to parse metrics", err == 0);
+
+	runtime_stat__init(&st);
+	load_runtime_stat(&st, evlist, vals);
+
+	evsel = evlist__first(evlist);
+	ratio = compute_single(&metric_events, evsel, &st);
+
+	TEST_ASSERT_VAL("Frontend_Bound_SMT failed, wrong ratio", ratio == 0.45);
+
+	runtime_stat__exit(&st);
+	evlist__delete(evlist);
+	return 0;
+}
+
 int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
+	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
 	return 0;
 }
-- 
2.25.4

