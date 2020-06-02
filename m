Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6439A1EBACC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 13:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgFBLvj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Jun 2020 07:51:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44404 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728145AbgFBLvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-4v8k6PzbP1On0sDJq3xXJQ-1; Tue, 02 Jun 2020 07:51:30 -0400
X-MC-Unique: 4v8k6PzbP1On0sDJq3xXJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C0BF464;
        Tue,  2 Jun 2020 11:51:28 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39A2810013D7;
        Tue,  2 Jun 2020 11:51:26 +0000 (UTC)
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
Subject: [PATCH 11/13] perf tools: Add test_generic_metric function
Date:   Tue,  2 Jun 2020 13:50:53 +0200
Message-Id: <20200602115055.1168446-12-jolsa@kernel.org>
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

Adding test_generic_metric that prepares and runs given metric
over the data from psswd struct runtime_stat object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/stat-shadow.c | 14 ++++++++++++++
 tools/perf/util/stat.h        |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 27be7ce2fff4..8fdef47005e6 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -842,6 +842,20 @@ static void generic_metric(struct perf_stat_config *config,
 	expr__ctx_clear(&pctx);
 }
 
+double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_stat *st)
+{
+	struct expr_parse_ctx pctx;
+	double ratio;
+
+	if (prepare_metric(mexp->metric_events, &pctx, cpu, st) < 0)
+		return 0.;
+
+	if (expr__parse(&ratio, &pctx, mexp->metric_expr, 1))
+		return 0.;
+
+	return ratio;
+}
+
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   double avg, int cpu,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index f75ae679eb28..6911c7249199 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -230,4 +230,7 @@ perf_evlist__print_counters(struct evlist *evlist,
 			    struct target *_target,
 			    struct timespec *ts,
 			    int argc, const char **argv);
+
+struct metric_expr;
+double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_stat *st);
 #endif
-- 
2.25.4

