Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6DF2FC188
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389819AbhASUsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:48:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:26412 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392051AbhASUrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:47:15 -0500
IronPort-SDR: uCrYlPJ9PCAmYlWfJ17SPKZSGXsIS9dalSkcrT6KxeKUo+9jA7+8Z0419XXk8YvniNSYF4O+Cr
 hMA7ejz9s4Ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="243064939"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="243064939"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 12:42:09 -0800
IronPort-SDR: p+ljf6Z9TxmkLrzNStxGF4xDt263pyqgNGRp63aTmuRTDzUl9sZhaN7cevoGBbIgS54C7Eh7Fl
 bGUGiSist+qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="365990808"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2021 12:42:09 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 08/12] perf tools: Support PERF_SAMPLE_WEIGHT_EXT
Date:   Tue, 19 Jan 2021 12:38:27 -0800
Message-Id: <1611088711-17177-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The new sample type, PERF_SAMPLE_WEIGHT_EXT, is an extension of the
PERF_SAMPLE_WEIGHT sample type. Enable the sample type if the sample by
weight option is applied.

Add weight_ext in the struct perf_sample to record the value of the new
sample type. For the old kernel which doesn't support the new sample
type, clear the sample type.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/event.h            |  1 +
 tools/perf/util/evsel.c            | 22 +++++++++++++++++++---
 tools/perf/util/evsel.h            |  1 +
 tools/perf/util/synthetic-events.c |  8 ++++++++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index ff403ea..0852c86 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -128,6 +128,7 @@ struct perf_sample {
 	u64 stream_id;
 	u64 period;
 	u64 weight;
+	union perf_weight_ext weight_ext;
 	u64 transaction;
 	u64 insn_cnt;
 	u64 cyc_cnt;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 97acde2..bb05687 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1165,8 +1165,10 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		attr->branch_sample_type = opts->branch_stack;
 	}
 
-	if (opts->sample_weight)
+	if (opts->sample_weight) {
 		evsel__set_sample_bit(evsel, WEIGHT);
+		evsel__set_sample_bit(evsel, WEIGHT_EXT);
+	}
 
 	attr->task  = track;
 	attr->mmap  = track;
@@ -1735,6 +1737,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	}
 
 fallback_missing_features:
+	if (perf_missing_features.weight_ext)
+		evsel__reset_sample_bit(evsel, WEIGHT_EXT);
 	if (perf_missing_features.clockid_wrong)
 		evsel->core.attr.clockid = CLOCK_MONOTONIC; /* should always work */
 	if (perf_missing_features.clockid) {
@@ -1873,8 +1877,13 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-        if (!perf_missing_features.data_page_size &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) {
+	if (!perf_missing_features.weight_ext &&
+	    (evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_EXT)) {
+		perf_missing_features.weight_ext = true;
+		pr_debug2("switching off weight extension support\n");
+		goto fallback_missing_features;
+	} else if (!perf_missing_features.data_page_size &&
+		   (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) {
 		perf_missing_features.data_page_size = true;
 		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
 		goto out_close;
@@ -2382,6 +2391,13 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
+	data->weight_ext.val = 0;
+	if (type & PERF_SAMPLE_WEIGHT_EXT) {
+		OVERFLOW_CHECK_u64(array);
+		data->weight_ext.val = *array;
+		array++;
+	}
+
 	return 0;
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cd1d8dd..ec598a6 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -145,6 +145,7 @@ struct perf_missing_features {
 	bool branch_hw_idx;
 	bool cgroup;
 	bool data_page_size;
+	bool weight_ext;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2947e3f..69291a9 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1417,6 +1417,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		result += sample->aux_sample.size;
 	}
 
+	if (type & PERF_SAMPLE_WEIGHT_EXT)
+		result += sizeof(u64);
+
 	return result;
 }
 
@@ -1603,6 +1606,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array = (void *)array + sz;
 	}
 
+	if (type & PERF_SAMPLE_WEIGHT_EXT) {
+		*array = sample->weight_ext.val;
+		array++;
+	}
+
 	return 0;
 }
 
-- 
2.7.4

