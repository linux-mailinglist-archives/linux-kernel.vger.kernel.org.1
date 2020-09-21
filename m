Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906F827199B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 05:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIUDek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 23:34:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:56863 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgIUDei (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 23:34:38 -0400
IronPort-SDR: qp6igGxLKZwnNEyH5TazuX1WkuAqanDpPEjM5RI04kZ9wlFbSiPC9AycSvyTDVW5RmTNx3mu7C
 PAbMfsA0eF3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="245136864"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="245136864"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 20:34:37 -0700
IronPort-SDR: qtrx70Jw1CcTgYIqtAi5jSR7vIESiCZeWGD1YW1JiHcaAnoYy+4QS57ZOwCH6fjEb8W4HXy1gM
 WOxITWNBll/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="411943782"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2020 20:34:35 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v7 4/7] perf util: Link stream pair
Date:   Mon, 21 Sep 2020 11:33:59 +0800
Message-Id: <20200921033402.25129-5-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921033402.25129-1-yao.jin@linux.intel.com>
References: <20200921033402.25129-1-yao.jin@linux.intel.com>
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

