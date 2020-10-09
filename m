Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A183728805D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 04:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgJIC3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 22:29:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:51340 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgJIC3a (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 22:29:30 -0400
IronPort-SDR: GY/FnlIYjoq6GGOJTPUdTNQjrX/HzaB96/uvA0A4bVLlZpI2+yJWGUnDVCfI/qXMQ1/IHGuaZM
 Mtnavp45a0zA==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="182869958"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="182869958"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 19:29:30 -0700
IronPort-SDR: E9wgKm/Py0oyphbus/tHqB5fYYrrBLiOO6SJlNJ9gmsUmKniZdgyg3vIWCCx8A4zeyhsAjVb4n
 R1y7kb2p0lAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="354699981"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2020 19:29:28 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v8 2/7] perf util: Get the evsel_streams by evsel_idx
Date:   Fri,  9 Oct 2020 10:28:40 +0800
Message-Id: <20201009022845.13141-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009022845.13141-1-yao.jin@linux.intel.com>
References: <20201009022845.13141-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous patch, we have created evsel_streams array

This patch returns the specified evsel_streams according to the
evsel_idx.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v8:
   - No change

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

