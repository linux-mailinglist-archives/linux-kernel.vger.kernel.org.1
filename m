Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC192A0E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgJ3TCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:02:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:30204 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbgJ3TCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:02:50 -0400
IronPort-SDR: sQZbOH0ahMG/swzbENihJnDEH1fFm3T5Y+fKyN5x1dKKoOLGHW0RN148OTTWzU3IKKZHNYYV/u
 9fJ+/cLWAriQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="165154834"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="165154834"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:50 -0700
IronPort-SDR: drrmRt5ZUAZUFt3ysi/VrFEIa4/st4BPncpacxtvvg25cNaYN+zQiHP3lua/xZFCicFdafdqJ3
 x7YCtVvEwcxw==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537167697"
Received: from kingelix-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.139.120])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:47 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] mm/mempolicy: Create a page allocator for policy
Date:   Fri, 30 Oct 2020 12:02:34 -0700
Message-Id: <20201030190238.306764-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201030190238.306764-1-ben.widawsky@intel.com>
References: <20201030190238.306764-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function which takes care of handling multiple preferred
nodes. It will be called by future patches that need to handle this,
specifically VMA based page allocation, and task based page allocation.
Huge pages don't quite fit the same pattern because they use different
underlying page allocation functions. This consumes the previous
interleave policy specific allocation function to make a one stop shop
for policy based allocation.

For now, only interleaved policy will be used so there should be no
functional change yet. However, if bisection points to issues in the
next few commits, it was likely the fault of this patch.

Similar functionality is offered via policy_node() and
policy_nodemask(). By themselves however, neither can achieve this
fallback style of sets of nodes.

Link: https://lore.kernel.org/r/20200630212517.308045-9-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 61 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a991dabb636d..1fd0da0f9631 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2177,22 +2177,56 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 	return ret;
 }
 
-/* Allocate a page in interleaved policy.
-   Own path because it needs to do special accounting. */
-static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
-					unsigned nid)
+/* Handle page allocation for all but interleaved policies */
+static struct page *alloc_pages_policy(struct mempolicy *pol, gfp_t gfp,
+				       unsigned int order, int preferred_nid)
 {
 	struct page *page;
+	gfp_t gfp_mask = gfp;
 
-	page = __alloc_pages(gfp, order, nid);
-	/* skip NUMA_INTERLEAVE_HIT counter update if numa stats is disabled */
-	if (!static_branch_likely(&vm_numa_stat_key))
+	if (pol->mode == MPOL_INTERLEAVE) {
+		page = __alloc_pages(gfp, order, preferred_nid);
+		/* skip NUMA_INTERLEAVE_HIT counter update if numa stats is disabled */
+		if (!static_branch_likely(&vm_numa_stat_key))
+			return page;
+		if (page && page_to_nid(page) == preferred_nid) {
+			preempt_disable();
+			__inc_numa_state(page_zone(page), NUMA_INTERLEAVE_HIT);
+			preempt_enable();
+		}
 		return page;
-	if (page && page_to_nid(page) == nid) {
-		preempt_disable();
-		__inc_numa_state(page_zone(page), NUMA_INTERLEAVE_HIT);
-		preempt_enable();
 	}
+
+	VM_BUG_ON(preferred_nid != NUMA_NO_NODE);
+
+	preferred_nid = numa_node_id();
+
+	/*
+	 * There is a two pass approach implemented here for
+	 * MPOL_PREFERRED_MANY. In the first pass we pretend the preferred nodes
+	 * are bound, but allow the allocation to fail. The below table explains
+	 * how this is achieved.
+	 *
+	 * | Policy                        | preferred nid | nodemask   |
+	 * |-------------------------------|---------------|------------|
+	 * | MPOL_DEFAULT                  | local         | NULL       |
+	 * | MPOL_PREFERRED                | best          | NULL       |
+	 * | MPOL_INTERLEAVE               | ERR           | ERR        |
+	 * | MPOL_BIND                     | local         | pol->nodes |
+	 * | MPOL_PREFERRED_MANY           | best          | pol->nodes |
+	 * | MPOL_PREFERRED_MANY (round 2) | local         | NULL       |
+	 * +-------------------------------+---------------+------------+
+	 */
+	if (pol->mode == MPOL_PREFERRED_MANY)
+		gfp_mask |= __GFP_RETRY_MAYFAIL;
+
+	page = __alloc_pages_nodemask(gfp_mask, order,
+				      policy_node(gfp, pol, preferred_nid),
+				      policy_nodemask(gfp, pol));
+
+	if (unlikely(!page && pol->mode == MPOL_PREFERRED_MANY))
+		page = __alloc_pages_nodemask(gfp, order, preferred_nid, NULL);
+
 	return page;
 }
 
@@ -2234,8 +2268,8 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		unsigned nid;
 
 		nid = interleave_nid(pol, vma, addr, PAGE_SHIFT + order);
+		page = alloc_pages_policy(pol, gfp, order, nid);
 		mpol_cond_put(pol);
-		page = alloc_page_interleave(gfp, order, nid);
 		goto out;
 	}
 
@@ -2319,7 +2353,8 @@ struct page *alloc_pages_current(gfp_t gfp, unsigned order)
 	 * nor system default_policy
 	 */
 	if (pol->mode == MPOL_INTERLEAVE)
-		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
+		page = alloc_pages_policy(pol, gfp, order,
+					  interleave_nodes(pol));
 	else
 		page = __alloc_pages_nodemask(gfp, order,
 				policy_node(gfp, pol, numa_node_id()),
-- 
2.29.2

