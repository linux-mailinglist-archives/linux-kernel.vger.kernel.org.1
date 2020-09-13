Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CAC26814F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgIMVGN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:06:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23864 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726069AbgIMVFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:05:20 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-1o2gZlrGNMGJLKCnL55AQw-1; Sun, 13 Sep 2020 17:04:10 -0400
X-MC-Unique: 1o2gZlrGNMGJLKCnL55AQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66C3D801AAE;
        Sun, 13 Sep 2020 21:04:08 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1A771002388;
        Sun, 13 Sep 2020 21:04:02 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/26] perf tools: Enable mmap3 map event when supported
Date:   Sun, 13 Sep 2020 23:02:57 +0200
Message-Id: <20200913210313.1985612-11-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-1-jolsa@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling mmap3 map event when supported and adding
its disable fallback when it fails.

Also adding mmap3 bit to verbose open output:

  $ perf record -vv kill
  perf_event_attr:
    size                             120
    { sample_period, sample_freq }   4000
    ...
    bpf_event                        1
    mmap3                            1

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evsel.c                   | 9 ++++++++-
 tools/perf/util/evsel.h                   | 1 +
 tools/perf/util/perf_event_attr_fprintf.c | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 14baf8542b40..c2cc9b4b30bf 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1065,6 +1065,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	attr->task  = track;
 	attr->mmap  = track;
 	attr->mmap2 = track && !perf_missing_features.mmap2;
+	attr->mmap3 = track && !perf_missing_features.mmap3;
 	attr->comm  = track;
 	/*
 	 * ksymbol is tracked separately with text poke because it needs to be
@@ -1657,6 +1658,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		evsel->core.attr.bpf_event = 0;
 	if (perf_missing_features.branch_hw_idx)
 		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_HW_INDEX;
+	if (perf_missing_features.mmap3)
+		evsel->core.attr.mmap3 = 0;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->core.attr.sample_id_all = 0;
@@ -1770,7 +1773,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-        if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
+	if (!perf_missing_features.mmap3 && evsel->core.attr.mmap3) {
+		perf_missing_features.mmap3 = true;
+		pr_debug2("switching off mmap3\n");
+		goto fallback_missing_features;
+	} else if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
 		perf_missing_features.cgroup = true;
 		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
 		goto out_close;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 35e3f6d66085..d49922b22eca 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -119,6 +119,7 @@ struct perf_missing_features {
 	bool sample_id_all;
 	bool exclude_guest;
 	bool mmap2;
+	bool mmap3;
 	bool cloexec;
 	bool clockid;
 	bool clockid_wrong;
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index e67a227c0ce7..3c52c081693d 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -134,6 +134,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(bpf_event, p_unsigned);
 	PRINT_ATTRf(aux_output, p_unsigned);
 	PRINT_ATTRf(cgroup, p_unsigned);
+	PRINT_ATTRf(mmap3, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
-- 
2.26.2

