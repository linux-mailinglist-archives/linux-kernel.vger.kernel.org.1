Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51C1EC495
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 23:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgFBVss convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Jun 2020 17:48:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57954 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728537AbgFBVso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:48:44 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-1SgRJBCeM3mLfWNksCcgrQ-1; Tue, 02 Jun 2020 17:48:38 -0400
X-MC-Unique: 1SgRJBCeM3mLfWNksCcgrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46AA9801504;
        Tue,  2 Jun 2020 21:48:36 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A069C1BCBE;
        Tue,  2 Jun 2020 21:48:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 13/13] perf tests: Add parse metric test for frontend metric
Date:   Tue,  2 Jun 2020 23:47:41 +0200
Message-Id: <20200602214741.1218986-14-jolsa@kernel.org>
In-Reply-To: <20200602214741.1218986-1-jolsa@kernel.org>
References: <20200602214741.1218986-1-jolsa@kernel.org>
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

Adding new metric test for frontend metric. It's stolen
from x86 pmu events.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/parse-metric.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 717a73fa7446..1939e567a8b3 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -17,6 +17,11 @@ static struct pmu_event pme_test[] = {
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
@@ -138,8 +143,28 @@ static int test_ipc(void)
 	return 0;
 }
 
+static int test_frontend(void)
+{
+	double ratio;
+	struct value vals[] = {
+		{ .event = "idq_uops_not_delivered.core",        .val = 300 },
+		{ .event = "cpu_clk_unhalted.thread",            .val = 200 },
+		{ .event = "cpu_clk_unhalted.one_thread_active", .val = 400 },
+		{ .event = "cpu_clk_unhalted.ref_xclk",          .val = 600 },
+		{ 0 },
+	};
+
+	TEST_ASSERT_VAL("failed to compute metric",
+			compute_metric("Frontend_Bound_SMT", vals, &ratio) == 0);
+
+	TEST_ASSERT_VAL("Frontend_Bound_SMT failed, wrong ratio",
+			ratio == 0.45);
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

