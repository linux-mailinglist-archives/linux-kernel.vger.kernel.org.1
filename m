Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104D91DA93F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 06:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgETE34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 00:29:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:54957 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgETE3x (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:29:53 -0400
IronPort-SDR: AGZNd5diqLRI/SEH4qYts9fTxcxMOtBE9/xdHQX2p19rday7cObIWWz0cOyyfQTQqvbRDNewiT
 ypzWwSJu5upg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 21:29:53 -0700
IronPort-SDR: yKSUp6M0MuC3E8fpELjm4V21/+QtS1k2pMmk8UQ5BA00zgYUrXAIJBrrniK1KkX0y68fPCie0T
 S8lakT3rxblQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="289217320"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2020 21:29:50 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 4/5] perf stat: Save aggr value to first member of prev_raw_counts
Date:   Wed, 20 May 2020 12:27:36 +0800
Message-Id: <20200520042737.24160-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520042737.24160-1-yao.jin@linux.intel.com>
References: <20200520042737.24160-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To collect the overall statistics for interval mode, we copy the
counts from evsel->prev_raw_counts to evsel->counts.

For AGGR_GLOBAL mode, because the perf_stat_process_counter creates
aggr values from per cpu values, but the per cpu values are 0,
so the calculated aggr values will be always 0.

This patch uses a trick that saves the previous aggr value to
the first member of perf_counts, then aggr calculation in
process_counter_values can work correctly for AGGR_GLOBAL.

 v6:
 ---
 Add comments in perf_evlist__save_aggr_prev_raw_counts.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/stat.c | 20 ++++++++++++++++++++
 tools/perf/util/stat.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index aadc723ce871..d23109c9bee9 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -249,6 +249,26 @@ void perf_evlist__copy_prev_raw_counts(struct evlist *evlist)
 		perf_evsel__copy_prev_raw_counts(evsel);
 }
 
+void perf_evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	/*
+	 * To collect the overall statistics for interval mode,
+	 * we copy the counts from evsel->prev_raw_counts to
+	 * evsel->counts. The perf_stat_process_counter creates
+	 * aggr values from per cpu values, but the per cpu values
+	 * are 0 for AGGR_GLOBAL. So we use a trick that saves the
+	 * previous aggr value to the first member of perf_counts,
+	 * then aggr calculation in process_counter_values can work
+	 * correctly.
+	 */
+	evlist__for_each_entry(evlist, evsel) {
+		*perf_counts(evsel->prev_raw_counts, 0, 0) =
+			evsel->prev_raw_counts->aggr;
+	}
+}
+
 static void zero_per_pkg(struct evsel *counter)
 {
 	if (counter->per_pkg_mask)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 62cf72c71869..18ead55756cc 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -199,6 +199,7 @@ void perf_evlist__free_stats(struct evlist *evlist);
 void perf_evlist__reset_stats(struct evlist *evlist);
 void perf_evlist__reset_prev_raw_counts(struct evlist *evlist);
 void perf_evlist__copy_prev_raw_counts(struct evlist *evlist);
+void perf_evlist__save_aggr_prev_raw_counts(struct evlist *evlist);
 
 int perf_stat_process_counter(struct perf_stat_config *config,
 			      struct evsel *counter);
-- 
2.17.1

