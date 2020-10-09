Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CE928805F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 04:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbgJIC3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 22:29:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:51340 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731276AbgJIC3f (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 22:29:35 -0400
IronPort-SDR: TQgv4py0WsmkubYBBg1Ny51Fe1tX0LlMXiRxM4Kd+uhW+BR+q6DnYF9O7U63qD28ggBVCHmOYM
 Mtn0HTV7K+bA==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="182869960"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="182869960"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 19:29:35 -0700
IronPort-SDR: sLyCYsiztCDBoPDDTxrrraYHIbNDn9qKDrfpvvTmGjyiocUXw8DmVHoec2H0idFfUvJQ3fb4bI
 dNwFZOMyhCuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="354700000"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2020 19:29:33 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v8 4/7] perf util: Link stream pair
Date:   Fri,  9 Oct 2020 10:28:42 +0800
Message-Id: <20201009022845.13141-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009022845.13141-1-yao.jin@linux.intel.com>
References: <20201009022845.13141-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patch, we have created an evsel_streams for one event,
and top N hottest streams will be saved in a stream array in
evsel_streams.

This patch compares total streams among two evsel_streams.

Once two streams are fully matched, they will be linked as
a pair. From the pair, we can know which streams are matched.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v8:
   - No change

 v7:
   - Rename functions with 'stream__' prefix.

 v6:
   - Rebase to perf/core

 v5:
   - Remove enum stream_type

 v4:
   - New patch in v4.

 tools/perf/util/stream.c | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stream.h |  4 ++++
 2 files changed, 44 insertions(+)

diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
index e1c7d6c6126b..0d6a7452320a 100644
--- a/tools/perf/util/stream.c
+++ b/tools/perf/util/stream.c
@@ -175,3 +175,43 @@ struct evsel_streams *evsel_streams__entry(struct evlist_streams *els,
 
 	return NULL;
 }
+
+static struct stream *stream__callchain_match(struct stream *base_stream,
+					      struct evsel_streams *es_pair)
+{
+	for (int i = 0; i < es_pair->nr_streams; i++) {
+		struct stream *pair_stream = &es_pair->streams[i];
+
+		if (callchain_cnode_matched(base_stream->cnode,
+					    pair_stream->cnode)) {
+			return pair_stream;
+		}
+	}
+
+	return NULL;
+}
+
+static struct stream *stream__match(struct stream *base_stream,
+				    struct evsel_streams *es_pair)
+{
+	return stream__callchain_match(base_stream, es_pair);
+}
+
+static void stream__link(struct stream *base_stream, struct stream *pair_stream)
+{
+	base_stream->pair_cnode = pair_stream->cnode;
+	pair_stream->pair_cnode = base_stream->cnode;
+}
+
+void evsel_streams__match(struct evsel_streams *es_base,
+			  struct evsel_streams *es_pair)
+{
+	for (int i = 0; i < es_base->nr_streams; i++) {
+		struct stream *base_stream = &es_base->streams[i];
+		struct stream *pair_stream;
+
+		pair_stream = stream__match(base_stream, es_pair);
+		if (pair_stream)
+			stream__link(base_stream, pair_stream);
+	}
+}
diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
index f01335677479..cb131f41f5b1 100644
--- a/tools/perf/util/stream.h
+++ b/tools/perf/util/stream.h
@@ -6,6 +6,7 @@
 
 struct stream {
 	struct callchain_node	*cnode;
+	struct callchain_node	*pair_cnode;
 };
 
 struct evsel_streams {
@@ -30,4 +31,7 @@ struct evlist_streams *evlist__create_streams(struct evlist *evlist,
 struct evsel_streams *evsel_streams__entry(struct evlist_streams *els,
 					   int evsel_idx);
 
+void evsel_streams__match(struct evsel_streams *es_base,
+			  struct evsel_streams *es_pair);
+
 #endif /* __PERF_STREAM_H */
-- 
2.17.1

