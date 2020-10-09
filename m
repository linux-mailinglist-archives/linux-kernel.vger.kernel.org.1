Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050F3288062
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 04:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgJIC3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 22:29:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:51359 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729935AbgJIC3o (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 22:29:44 -0400
IronPort-SDR: NCnAql+2BhTwW64w/Ws8HSR8YS3+pZX5s8Luvmf/Az4DkxCQYgLSLzUEDMyA7Blepp919cclrd
 rOKTNjR2aW5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="182869969"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="182869969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 19:29:42 -0700
IronPort-SDR: 50OckzDK5u0IV0REdd6Yqh+8t204hOjRPhTLb6kKu0hoWY0kNSkl3CgKQo3UEUv9dlejJ3jrnU
 GPdLlQz660DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="354700030"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2020 19:29:40 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v8 7/7] perf diff: Support hot streams comparison
Date:   Fri,  9 Oct 2020 10:28:45 +0800
Message-Id: <20201009022845.13141-8-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009022845.13141-1-yao.jin@linux.intel.com>
References: <20201009022845.13141-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables perf-diff with "--stream" option.

"--stream": Enable hot streams comparison

Now let's see example.

perf record -b ...      Generate perf.data.old with branch data
perf record -b ...      Generate perf.data with branch data
perf diff --stream

[ Matched hot streams ]

hot chain pair 1:
            cycles: 1, hits: 27.77%                  cycles: 1, hits: 9.24%
        ---------------------------              --------------------------
                      main div.c:39                           main div.c:39
                      main div.c:44                           main div.c:44

hot chain pair 2:
           cycles: 34, hits: 20.06%                cycles: 27, hits: 16.98%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380
          __random_r random_r.c:357               __random_r random_r.c:357
              __random random.c:293                   __random random.c:293
              __random random.c:293                   __random random.c:293
              __random random.c:291                   __random random.c:291
              __random random.c:291                   __random random.c:291
              __random random.c:291                   __random random.c:291
              __random random.c:288                   __random random.c:288
                     rand rand.c:27                          rand rand.c:27
                     rand rand.c:26                          rand rand.c:26
                           rand@plt                                rand@plt
                           rand@plt                                rand@plt
              compute_flag div.c:25                   compute_flag div.c:25
              compute_flag div.c:22                   compute_flag div.c:22
                      main div.c:40                           main div.c:40
                      main div.c:40                           main div.c:40
                      main div.c:39                           main div.c:39

hot chain pair 3:
             cycles: 9, hits: 4.48%                  cycles: 6, hits: 4.51%
        ---------------------------              --------------------------
          __random_r random_r.c:360               __random_r random_r.c:360
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:388               __random_r random_r.c:388
          __random_r random_r.c:380               __random_r random_r.c:380

[ Hot streams in old perf data only ]

hot chain 1:
            cycles: 18, hits: 6.75%
         --------------------------
          __random_r random_r.c:360
          __random_r random_r.c:388
          __random_r random_r.c:388
          __random_r random_r.c:380
          __random_r random_r.c:357
              __random random.c:293
              __random random.c:293
              __random random.c:291
              __random random.c:291
              __random random.c:291
              __random random.c:288
                     rand rand.c:27
                     rand rand.c:26
                           rand@plt
                           rand@plt
              compute_flag div.c:25
              compute_flag div.c:22
                      main div.c:40

hot chain 2:
            cycles: 29, hits: 2.78%
         --------------------------
              compute_flag div.c:22
                      main div.c:40
                      main div.c:40
                      main div.c:39

[ Hot streams in new perf data only ]

hot chain 1:
                                                     cycles: 4, hits: 4.54%
                                                 --------------------------
                                                              main div.c:42
                                                      compute_flag div.c:28

hot chain 2:
                                                     cycles: 5, hits: 3.51%
                                                 --------------------------
                                                              main div.c:39
                                                              main div.c:44
                                                              main div.c:42
                                                      compute_flag div.c:28

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v8:
   - No change

 v7:
   - Use new struct evlist_streams in data__file.
   - Free the streams in data__free.

 v6:
   - Rebase to perf/core

 v5:
   - Remove enum stream_type
   - Rebase to perf/core

 v4:
   - Remove the "--before" and "--after" options since they are for
     source line based comparison. In this patchset, we will not
     support source line based comparison.

 tools/perf/Documentation/perf-diff.txt |   4 +
 tools/perf/builtin-diff.c              | 119 ++++++++++++++++++++++---
 2 files changed, 110 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index f50ca0fef0a4..be65bd55ab2a 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -182,6 +182,10 @@ OPTIONS
 --tid=::
 	Only diff samples for given thread ID (comma separated list).
 
+--stream::
+	Enable hot streams comparison. Stream can be a callchain which is
+	aggregated by the branch records from samples.
+
 COMPARISON
 ----------
 The comparison is governed by the baseline file. The baseline perf.data
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index f8c9bdd8269a..584e2e1a3793 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -25,6 +25,7 @@
 #include "util/map.h"
 #include "util/spark.h"
 #include "util/block-info.h"
+#include "util/stream.h"
 #include <linux/err.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
@@ -42,6 +43,7 @@ struct perf_diff {
 	int				 range_size;
 	int				 range_num;
 	bool				 has_br_stack;
+	bool				 stream;
 };
 
 /* Diff command specific HPP columns. */
@@ -72,6 +74,7 @@ struct data__file {
 	struct perf_data	 data;
 	int			 idx;
 	struct hists		*hists;
+	struct evlist_streams	*evlist_streams;
 	struct diff_hpp_fmt	 fmt[PERF_HPP_DIFF__MAX_INDEX];
 };
 
@@ -106,6 +109,7 @@ enum {
 	COMPUTE_DELTA_ABS,
 	COMPUTE_CYCLES,
 	COMPUTE_MAX,
+	COMPUTE_STREAM,	/* After COMPUTE_MAX to avoid use current compute arrays */
 };
 
 const char *compute_names[COMPUTE_MAX] = {
@@ -393,6 +397,11 @@ static int diff__process_sample_event(struct perf_tool *tool,
 	struct perf_diff *pdiff = container_of(tool, struct perf_diff, tool);
 	struct addr_location al;
 	struct hists *hists = evsel__hists(evsel);
+	struct hist_entry_iter iter = {
+		.evsel	= evsel,
+		.sample	= sample,
+		.ops	= &hist_iter_normal,
+	};
 	int ret = -1;
 
 	if (perf_time__ranges_skip_sample(pdiff->ptime_range, pdiff->range_num,
@@ -411,14 +420,8 @@ static int diff__process_sample_event(struct perf_tool *tool,
 		goto out_put;
 	}
 
-	if (compute != COMPUTE_CYCLES) {
-		if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample,
-				      true)) {
-			pr_warning("problem incrementing symbol period, "
-				   "skipping event\n");
-			goto out_put;
-		}
-	} else {
+	switch (compute) {
+	case COMPUTE_CYCLES:
 		if (!hists__add_entry_ops(hists, &block_hist_ops, &al, NULL,
 					  NULL, NULL, sample, true)) {
 			pr_warning("problem incrementing symbol period, "
@@ -428,6 +431,23 @@ static int diff__process_sample_event(struct perf_tool *tool,
 
 		hist__account_cycles(sample->branch_stack, &al, sample, false,
 				     NULL);
+		break;
+
+	case COMPUTE_STREAM:
+		if (hist_entry_iter__add(&iter, &al, PERF_MAX_STACK_DEPTH,
+					 NULL)) {
+			pr_debug("problem adding hist entry, skipping event\n");
+			goto out_put;
+		}
+		break;
+
+	default:
+		if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample,
+				      true)) {
+			pr_warning("problem incrementing symbol period, "
+				   "skipping event\n");
+			goto out_put;
+		}
 	}
 
 	/*
@@ -996,10 +1016,55 @@ static void data_process(void)
 	}
 }
 
+static int process_base_stream(struct data__file *data_base,
+			       struct data__file *data_pair,
+			       const char *title __maybe_unused)
+{
+	struct evlist *evlist_base = data_base->session->evlist;
+	struct evlist *evlist_pair = data_pair->session->evlist;
+	struct evsel *evsel_base, *evsel_pair;
+	struct evsel_streams *es_base, *es_pair;
+
+	evlist__for_each_entry(evlist_base, evsel_base) {
+		evsel_pair = evsel_match(evsel_base, evlist_pair);
+		if (!evsel_pair)
+			continue;
+
+		es_base = evsel_streams__entry(data_base->evlist_streams,
+					       evsel_base->idx);
+		if (!es_base)
+			return -1;
+
+		es_pair = evsel_streams__entry(data_pair->evlist_streams,
+					       evsel_pair->idx);
+		if (!es_pair)
+			return -1;
+
+		evsel_streams__match(es_base, es_pair);
+		evsel_streams__report(es_base, es_pair);
+	}
+
+	return 0;
+}
+
+static void stream_process(void)
+{
+	/*
+	 * Stream comparison only supports two data files.
+	 * perf.data.old and perf.data. data__files[0] is perf.data.old,
+	 * data__files[1] is perf.data.
+	 */
+	process_base_stream(&data__files[0], &data__files[1],
+			    "# Output based on old perf data:\n#\n");
+}
+
 static void data__free(struct data__file *d)
 {
 	int col;
 
+	if (d->evlist_streams)
+		evlist_streams__delete(d->evlist_streams);
+
 	for (col = 0; col < PERF_HPP_DIFF__MAX_INDEX; col++) {
 		struct diff_hpp_fmt *fmt = &d->fmt[col];
 
@@ -1153,9 +1218,19 @@ static int __cmd_diff(void)
 
 		if (pdiff.ptime_range)
 			zfree(&pdiff.ptime_range);
+
+		if (compute == COMPUTE_STREAM) {
+			d->evlist_streams = evlist__create_streams(
+						d->session->evlist, 5);
+			if (!d->evlist_streams)
+				goto out_delete;
+		}
 	}
 
-	data_process();
+	if (compute == COMPUTE_STREAM)
+		stream_process();
+	else
+		data_process();
 
  out_delete:
 	data__for_each_file(i, d) {
@@ -1228,6 +1303,8 @@ static const struct option options[] = {
 		   "only consider symbols in these pids"),
 	OPT_STRING(0, "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
 		   "only consider symbols in these tids"),
+	OPT_BOOLEAN(0, "stream", &pdiff.stream,
+		    "Enable hot streams comparison."),
 	OPT_END()
 };
 
@@ -1887,6 +1964,9 @@ int cmd_diff(int argc, const char **argv)
 	if (cycles_hist && (compute != COMPUTE_CYCLES))
 		usage_with_options(diff_usage, options);
 
+	if (pdiff.stream)
+		compute = COMPUTE_STREAM;
+
 	symbol__annotation_init();
 
 	if (symbol__init(NULL) < 0)
@@ -1898,13 +1978,26 @@ int cmd_diff(int argc, const char **argv)
 	if (check_file_brstack() < 0)
 		return -1;
 
-	if (compute == COMPUTE_CYCLES && !pdiff.has_br_stack)
+	if ((compute == COMPUTE_CYCLES || compute == COMPUTE_STREAM)
+	    && !pdiff.has_br_stack) {
 		return -1;
+	}
 
-	if (ui_init() < 0)
-		return -1;
+	if (compute == COMPUTE_STREAM) {
+		symbol_conf.show_branchflag_count = true;
+		symbol_conf.disable_add2line_warn = true;
+		callchain_param.mode = CHAIN_FLAT;
+		callchain_param.key = CCKEY_SRCLINE;
+		callchain_param.branch_callstack = 1;
+		symbol_conf.use_callchain = true;
+		callchain_register_param(&callchain_param);
+		sort_order = "srcline,symbol,dso";
+	} else {
+		if (ui_init() < 0)
+			return -1;
 
-	sort__mode = SORT_MODE__DIFF;
+		sort__mode = SORT_MODE__DIFF;
+	}
 
 	if (setup_sorting(NULL) < 0)
 		usage_with_options(diff_usage, options);
-- 
2.17.1

