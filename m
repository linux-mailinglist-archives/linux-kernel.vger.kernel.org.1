Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D098A27199C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 05:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgIUDeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 23:34:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:56863 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgIUDek (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 23:34:40 -0400
IronPort-SDR: uv73AKC99XnkNvxA7ozZUwG8CT02Sg20KEQQuhxEN3GfEauOh1ca348YOGbKBeYV3GcvGZdRb6
 87XJqmVdEWrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="245136868"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="245136868"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 20:34:40 -0700
IronPort-SDR: bt7uumvbzw6sCa/Hzr4O4WX7L70Kxck5w7MjraEVu5VFNPMpi1OcV41WYVkNsaIEKPA5UknEr6
 h+U3x+FWKI4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="411943790"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2020 20:34:37 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v7 5/7] perf util: Calculate the sum of total streams hits
Date:   Mon, 21 Sep 2020 11:34:00 +0800
Message-Id: <20200921033402.25129-6-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921033402.25129-1-yao.jin@linux.intel.com>
References: <20200921033402.25129-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have used callchain_node->hit to measure the hot level of one
stream. This patch calculates the sum of hits of total streams.

Thus in next patch, we can use following formula to report hot
percent for one stream.

hot percent = callchain_node->hit / sum of total hits

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v7:
   - No change

 v6:
   - Rebase to perf/core

 v5:
   - Rebase to perf/core

 v4:
   - No functional change.

 v2:
   - Combine the variable decl line with its initial assignment
     in total_callchain_hits().

 tools/perf/util/callchain.c | 32 ++++++++++++++++++++++++++++++++
 tools/perf/util/callchain.h |  3 +++
 tools/perf/util/stream.c    |  2 ++
 tools/perf/util/stream.h    |  1 +
 4 files changed, 38 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d356e73c5622..4f824bfcc072 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1667,3 +1667,35 @@ bool callchain_cnode_matched(struct callchain_node *base_cnode,
 
 	return match;
 }
+
+static u64 count_callchain_hits(struct hist_entry *he)
+{
+	struct rb_root *root = &he->sorted_chain;
+	struct rb_node *rb_node = rb_first(root);
+	struct callchain_node *node;
+	u64 chain_hits = 0;
+
+	while (rb_node) {
+		node = rb_entry(rb_node, struct callchain_node, rb_node);
+		chain_hits += node->hit;
+		rb_node = rb_next(rb_node);
+	}
+
+	return chain_hits;
+}
+
+u64 callchain_total_hits(struct hists *hists)
+{
+	struct rb_node *next = rb_first_cached(&hists->entries);
+	u64 chain_hits = 0;
+
+	while (next) {
+		struct hist_entry *he = rb_entry(next, struct hist_entry,
+						 rb_node);
+
+		chain_hits += count_callchain_hits(he);
+		next = rb_next(&he->rb_node);
+	}
+
+	return chain_hits;
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index ad27fc8c7948..ac5bea9c1eb7 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -13,6 +13,7 @@ struct ip_callchain;
 struct map;
 struct perf_sample;
 struct thread;
+struct hists;
 
 #define HELP_PAD "\t\t\t\t"
 
@@ -302,4 +303,6 @@ void callchain_param_setup(u64 sample_type);
 bool callchain_cnode_matched(struct callchain_node *base_cnode,
 			     struct callchain_node *pair_cnode);
 
+u64 callchain_total_hits(struct hists *hists);
+
 #endif	/* __PERF_CALLCHAIN_H */
diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
index 0d6a7452320a..47c5956b3378 100644
--- a/tools/perf/util/stream.c
+++ b/tools/perf/util/stream.c
@@ -121,6 +121,8 @@ static void init_hot_callchain(struct hists *hists, struct evsel_streams *es)
 		update_hot_callchain(he, es);
 		next = rb_next(&he->rb_node);
 	}
+
+	es->streams_hits = callchain_total_hits(hists);
 }
 
 static int evlist__init_callchain_streams(struct evlist *evlist,
diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
index cb131f41f5b1..a61072eda64d 100644
--- a/tools/perf/util/stream.h
+++ b/tools/perf/util/stream.h
@@ -14,6 +14,7 @@ struct evsel_streams {
 	int			nr_streams_max;
 	int			nr_streams;
 	int			evsel_idx;
+	u64			streams_hits;
 };
 
 struct evlist_streams {
-- 
2.17.1

