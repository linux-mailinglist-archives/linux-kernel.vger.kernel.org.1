Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6156271999
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 05:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIUDef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 23:34:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:56863 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgIUDed (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 23:34:33 -0400
IronPort-SDR: 5nvwV/LhxgUvG42ncUcx3vLPXISgYESBVKjKDcK1NhnD+evCB6umHJD7LMC/0x5Yj+UaYtQOi8
 jfRwAKCEb9TA==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="245136859"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="245136859"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 20:34:33 -0700
IronPort-SDR: I0r+kcFztjOS0pimNKRhtMS0/TAHhutBlB3T7BGVqL6BOVYJOS+0x0RLxMujnKJXPOrkJWfXVP
 k9Tmy4PkwiSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="411943771"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2020 20:34:30 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v7 2/7] perf util: Get the evsel_streams by evsel_idx
Date:   Mon, 21 Sep 2020 11:33:57 +0800
Message-Id: <20200921033402.25129-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921033402.25129-1-yao.jin@linux.intel.com>
References: <20200921033402.25129-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patch, we have created evsel_streams array

This patch returns the specified evsel_streams according to the
evsel_idx.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v7:
   - Rename functions:
	evsel_streams__entry

 v6:
   - Rebase to perf/core

 v5:
   - Rebase to perf/core

 v4:
   - Rename the patch from 'perf util: Return per-event callchain
     streams' to 'perf util: Get the evsel_streams by evsel_idx'

 tools/perf/util/stream.c | 13 +++++++++++++
 tools/perf/util/stream.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
index 31efe4ae0f55..e1c7d6c6126b 100644
--- a/tools/perf/util/stream.c
+++ b/tools/perf/util/stream.c
@@ -162,3 +162,16 @@ struct evlist_streams *evlist__create_streams(struct evlist *evlist,
 
 	return els;
 }
+
+struct evsel_streams *evsel_streams__entry(struct evlist_streams *els,
+					   int evsel_idx)
+{
+	struct evsel_streams *es = els->ev_streams;
+
+	for (int i = 0; i < els->nr_evsel; i++) {
+		if (es[i].evsel_idx == evsel_idx)
+			return &es[i];
+	}
+
+	return NULL;
+}
diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
index 35bc64df554c..f01335677479 100644
--- a/tools/perf/util/stream.h
+++ b/tools/perf/util/stream.h
@@ -27,4 +27,7 @@ void evlist_streams__delete(struct evlist_streams *els);
 struct evlist_streams *evlist__create_streams(struct evlist *evlist,
 					      int nr_streams_max);
 
+struct evsel_streams *evsel_streams__entry(struct evlist_streams *els,
+					   int evsel_idx);
+
 #endif /* __PERF_STREAM_H */
-- 
2.17.1

