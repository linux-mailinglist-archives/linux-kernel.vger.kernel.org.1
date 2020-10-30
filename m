Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606482A0E47
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgJ3TDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:03:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:30184 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbgJ3TCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:02:46 -0400
IronPort-SDR: IHoh/R5tWz05eUqaU6HaGEmVbXRDWk2eMJVx5VM5xuzBL+IYbaEHaLYF1wGRfsECaXugq3ypUE
 y/w8iomv+usA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="165154810"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="165154810"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:45 -0700
IronPort-SDR: BM1BL2+VRKeofJNnoSPAEDwLhT9tJ8TG5YNC98pI7lQR0Gni6oRexQ+vYG6ZdgQLc6LAg7knfc
 thwppUTdUNLg==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537167656"
Received: from kingelix-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.139.120])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:44 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] mm/mempolicy: Add MPOL_PREFERRED_MANY for multiple preferred nodes
Date:   Fri, 30 Oct 2020 12:02:29 -0700
Message-Id: <20201030190238.306764-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201030190238.306764-1-ben.widawsky@intel.com>
References: <20201030190238.306764-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

MPOL_PREFERRED honors only a single node set in the nodemask.  Add the
bare define for a new mode which will allow more than one.

The patch does all the plumbing without actually adding the new policy
type.

v2:
Plumb most MPOL_PREFERRED_MANY without exposing UAPI (Ben)
Fixes for checkpatch (Ben)

Link: https://lore.kernel.org/r/20200630212517.308045-4-ben.widawsky@intel.com
Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 mm/mempolicy.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ba3bc4f28d27..21a6f80f91a9 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -31,6 +31,9 @@
  *                but useful to set in a VMA when you have a non default
  *                process policy.
  *
+ * preferred many Try a set of nodes first before normal fallback. This is
+ *                similar to preferred without the special case.
+ *
  * default        Allocate on the local node first, or when on a VMA
  *                use the process policy. This is what Linux always did
  *		  in a NUMA aware kernel and still does by, ahem, default.
@@ -105,6 +108,8 @@
 
 #include "internal.h"
 
+#define MPOL_PREFERRED_MANY MPOL_MAX
+
 /* Internal flags */
 #define MPOL_MF_DISCONTIG_OK (MPOL_MF_INTERNAL << 0)	/* Skip checks for continuous vmas */
 #define MPOL_MF_INVERT (MPOL_MF_INTERNAL << 1)		/* Invert check for nodemask */
@@ -175,7 +180,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
 static const struct mempolicy_operations {
 	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
 	void (*rebind)(struct mempolicy *pol, const nodemask_t *nodes);
-} mpol_ops[MPOL_MAX];
+} mpol_ops[MPOL_MAX + 1];
 
 static inline int mpol_store_user_nodemask(const struct mempolicy *pol)
 {
@@ -415,7 +420,7 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 	mmap_write_unlock(mm);
 }
 
-static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
+static const struct mempolicy_operations mpol_ops[MPOL_MAX + 1] = {
 	[MPOL_DEFAULT] = {
 		.rebind = mpol_rebind_default,
 	},
@@ -432,6 +437,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.rebind = mpol_rebind_nodemask,
 	},
 	/* [MPOL_LOCAL] - see mpol_new() */
+	[MPOL_PREFERRED_MANY] = {
+		.create = NULL,
+		.rebind = NULL,
+	},
 };
 
 static int migrate_page_add(struct page *page, struct list_head *pagelist,
@@ -914,6 +923,9 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	case MPOL_INTERLEAVE:
 		*nodes = p->v.nodes;
 		break;
+	case MPOL_PREFERRED_MANY:
+		*nodes = p->v.preferred_nodes;
+		break;
 	case MPOL_PREFERRED:
 		if (!(p->flags & MPOL_F_LOCAL))
 			*nodes = p->v.preferred_nodes;
@@ -1889,7 +1901,9 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 /* Return the node id preferred by the given mempolicy, or the given id */
 static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 {
-	if (policy->mode == MPOL_PREFERRED && !(policy->flags & MPOL_F_LOCAL)) {
+	if ((policy->mode == MPOL_PREFERRED ||
+	     policy->mode == MPOL_PREFERRED_MANY) &&
+	    !(policy->flags & MPOL_F_LOCAL)) {
 		nd = first_node(policy->v.preferred_nodes);
 	} else {
 		/*
@@ -1932,6 +1946,7 @@ unsigned int mempolicy_slab_node(void)
 		return node;
 
 	switch (policy->mode) {
+	case MPOL_PREFERRED_MANY:
 	case MPOL_PREFERRED:
 		/*
 		 * handled MPOL_F_LOCAL above
@@ -2066,6 +2081,9 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	task_lock(current);
 	mempolicy = current->mempolicy;
 	switch (mempolicy->mode) {
+	case MPOL_PREFERRED_MANY:
+		*mask = mempolicy->v.preferred_nodes;
+		break;
 	case MPOL_PREFERRED:
 		if (mempolicy->flags & MPOL_F_LOCAL)
 			nid = numa_node_id();
@@ -2120,6 +2138,9 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 		 * nodes in mask.
 		 */
 		break;
+	case MPOL_PREFERRED_MANY:
+		ret = nodes_intersects(mempolicy->v.preferred_nodes, *mask);
+		break;
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		ret = nodes_intersects(mempolicy->v.nodes, *mask);
@@ -2204,10 +2225,13 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * node and don't fall back to other nodes, as the cost of
 		 * remote accesses would likely offset THP benefits.
 		 *
-		 * If the policy is interleave, or does not allow the current
-		 * node in its nodemask, we allocate the standard way.
+		 * If the policy is interleave or multiple preferred nodes, or
+		 * does not allow the current node in its nodemask, we allocate
+		 * the standard way.
 		 */
-		if (pol->mode == MPOL_PREFERRED && !(pol->flags & MPOL_F_LOCAL))
+		if ((pol->mode == MPOL_PREFERRED ||
+		     pol->mode == MPOL_PREFERRED_MANY) &&
+		    !(pol->flags & MPOL_F_LOCAL))
 			hpage_node = first_node(pol->v.preferred_nodes);
 
 		nmask = policy_nodemask(gfp, pol);
@@ -2343,6 +2367,9 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		return !!nodes_equal(a->v.nodes, b->v.nodes);
+	case MPOL_PREFERRED_MANY:
+		return !!nodes_equal(a->v.preferred_nodes,
+				     b->v.preferred_nodes);
 	case MPOL_PREFERRED:
 		/* a's ->flags is the same as b's */
 		if (a->flags & MPOL_F_LOCAL)
@@ -2511,6 +2538,8 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		polnid = zone_to_nid(z->zone);
 		break;
 
+		/* case MPOL_PREFERRED_MANY: */
+
 	default:
 		BUG();
 	}
@@ -2862,6 +2891,7 @@ static const char * const policy_modes[] =
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
 	[MPOL_LOCAL]      = "local",
+	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
 
 
@@ -2941,6 +2971,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		if (!nodelist)
 			err = 0;
 		goto out;
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 		/*
 		 * Insist on a nodelist
@@ -3023,6 +3054,9 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	switch (mode) {
 	case MPOL_DEFAULT:
 		break;
+	case MPOL_PREFERRED_MANY:
+		WARN_ON(flags & MPOL_F_LOCAL);
+		fallthrough;
 	case MPOL_PREFERRED:
 		if (flags & MPOL_F_LOCAL)
 			mode = MPOL_LOCAL;
-- 
2.29.2

