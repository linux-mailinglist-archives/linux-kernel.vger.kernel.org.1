Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A23E20E99F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 02:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgF2Xsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 19:48:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:23018 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgF2Xsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:48:30 -0400
IronPort-SDR: q1LHfcy0wnFEV+ksDYabLt3raD0zulxS4XQrfp0noT6I9m7AGKbQ2wGlBhHKjyBiNoDChxv/8R
 O5rmAJjziOoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="207619641"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="207619641"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:48:29 -0700
IronPort-SDR: VRSKSVr09Pa/rZrlzH3Vjr4iagEfzf6Hd6WnqUdLcWNMFkdi8glBXAu3Kbl6/7mX0Gnyk6Vqgw
 g2B5KkqF6F4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="320772112"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2020 16:48:29 -0700
Subject: [RFC][PATCH 1/8] mm/numa: node demotion data structure and lookup
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 29 Jun 2020 16:45:05 -0700
References: <20200629234503.749E5340@viggo.jf.intel.com>
In-Reply-To: <20200629234503.749E5340@viggo.jf.intel.com>
Message-Id: <20200629234505.6ABCBDF4@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Prepare for the kernel to auto-migrate pages to other memory nodes
with a user defined node migration table. This allows creating single
migration target for each NUMA node to enable the kernel to do NUMA
page migrations instead of simply reclaiming colder pages. A node
with no target is a "terminal node", so reclaim acts normally there.
The migration target does not fundamentally _need_ to be a single node,
but this implementation starts there to limit complexity.

If you consider the migration path as a graph, cycles (loops) in the
graph are disallowed.  This avoids wasting resources by constantly
migrating (A->B, B->A, A->B ...).  The expectation is that cycles will
never be allowed.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---

 b/mm/migrate.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff -puN mm/migrate.c~0006-node-Define-and-export-memory-migration-path mm/migrate.c
--- a/mm/migrate.c~0006-node-Define-and-export-memory-migration-path	2020-06-29 16:34:36.849312609 -0700
+++ b/mm/migrate.c	2020-06-29 16:34:36.853312609 -0700
@@ -1159,6 +1159,29 @@ out:
 	return rc;
 }
 
+static int node_demotion[MAX_NUMNODES] = {[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
+
+/**
+ * next_demotion_node() - Get the next node in the demotion path
+ * @node: The starting node to lookup the next node
+ *
+ * @returns: node id for next memory node in the demotion path hierarchy
+ * from @node; -1 if @node is terminal
+ */
+int next_demotion_node(int node)
+{
+	get_online_mems();
+	while (true) {
+		node = node_demotion[node];
+		if (node == NUMA_NO_NODE)
+			break;
+		if (node_online(node))
+			break;
+	}
+	put_online_mems();
+	return node;
+}
+
 /*
  * gcc 4.7 and 4.8 on arm get an ICEs when inlining unmap_and_move().  Work
  * around it.
_
