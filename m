Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EBD27199A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 05:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgIUDeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 23:34:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:56863 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgIUDef (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 23:34:35 -0400
IronPort-SDR: O+u+9XrGvh5BNrj9pGi8LwqHZrBjMMbKD/Efb1nokZLXYEts27YpNnJKbHkfPjRa6k/WcxPH+k
 278TTlQAdMJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="245136862"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="245136862"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 20:34:35 -0700
IronPort-SDR: NWMhBn5Qda+mD9o3Vh25UJL7TCYqNbl9zP/C9yKpXF6IeOVtDu/NOnk2njTT5H+iugXUsFnJav
 tpn/ehvTqKjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="411943777"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2020 20:34:33 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v7 3/7] perf util: Compare two streams
Date:   Mon, 21 Sep 2020 11:33:58 +0800
Message-Id: <20200921033402.25129-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921033402.25129-1-yao.jin@linux.intel.com>
References: <20200921033402.25129-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stream is the branch history which is aggregated by the branch
records from perf samples. Now we support the callchain as
stream.

If the callchain entries of one stream are fully matched with
the callchain entries of another stream, we think two streams
are matched.

For example,

   cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
   -----------------------                 -----------------------
             main div.c:39                           main div.c:39
             main div.c:44                           main div.c:44

Above two streams are matched (we don't consider the case that
source code is changed).

The matching logic is, compare the chain string first. If it's not
matched, fallback to dso address comparison.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v7:
   - No change

 v6:
   - Rebase to perf/core

 v5:
   - Remove enum stream_type
   - Rebase to perf/core

 v4:
   - Remove original source line comparison code.

 tools/perf/util/callchain.c | 54 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/callchain.h |  4 +++
 2 files changed, 58 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 2775b752f2fa..d356e73c5622 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1613,3 +1613,57 @@ void callchain_param_setup(u64 sample_type)
 			callchain_param.record_mode = CALLCHAIN_FP;
 	}
 }
+
+static bool chain_match(struct callchain_list *base_chain,
+			struct callchain_list *pair_chain)
+{
+	enum match_result match;
+
+	match = match_chain_strings(base_chain->srcline,
+				    pair_chain->srcline);
+	if (match != MATCH_ERROR)
+		return match == MATCH_EQ;
+
+	match = match_chain_dso_addresses(base_chain->ms.map,
+					  base_chain->ip,
+					  pair_chain->ms.map,
+					  pair_chain->ip);
+
+	return match == MATCH_EQ;
+}
+
+bool callchain_cnode_matched(struct callchain_node *base_cnode,
+			     struct callchain_node *pair_cnode)
+{
+	struct callchain_list *base_chain, *pair_chain;
+	bool match = false;
+
+	pair_chain = list_first_entry(&pair_cnode->val,
+				      struct callchain_list,
+				      list);
+
+	list_for_each_entry(base_chain, &base_cnode->val, list) {
+		if (&pair_chain->list == &pair_cnode->val)
+			return false;
+
+		if (!base_chain->srcline || !pair_chain->srcline) {
+			pair_chain = list_next_entry(pair_chain, list);
+			continue;
+		}
+
+		match = chain_match(base_chain, pair_chain);
+		if (!match)
+			return false;
+
+		pair_chain = list_next_entry(pair_chain, list);
+	}
+
+	/*
+	 * Say chain1 is ABC, chain2 is ABCD, we consider they are
+	 * not fully matched.
+	 */
+	if (pair_chain && (&pair_chain->list != &pair_cnode->val))
+		return false;
+
+	return match;
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index fe36a9e5ccd1..ad27fc8c7948 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -298,4 +298,8 @@ int callchain_branch_counts(struct callchain_root *root,
 			    u64 *abort_count, u64 *cycles_count);
 
 void callchain_param_setup(u64 sample_type);
+
+bool callchain_cnode_matched(struct callchain_node *base_cnode,
+			     struct callchain_node *pair_cnode);
+
 #endif	/* __PERF_CALLCHAIN_H */
-- 
2.17.1

