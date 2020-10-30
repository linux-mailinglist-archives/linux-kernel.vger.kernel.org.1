Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8E32A0E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgJ3TCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:02:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:30185 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbgJ3TCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:02:47 -0400
IronPort-SDR: Rh01aI5cspG5wUAasz1ce/5TRBVDXp97bnFm+3oBUBJS3SmXEPXi1FxM5c+a6RLPHdUdkFSVkE
 yc7TWCyRq2Pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="165154823"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="165154823"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:47 -0700
IronPort-SDR: 7ado/V/MftgPZt36C4q29kh3mPCOcl6vDSJ88+BpJB93JCfMaEwvz2q3GX1aach8CqEbHJXq8f
 Vlwxwg9VlCbQ==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537167680"
Received: from kingelix-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.139.120])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:46 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] mm/mempolicy: kill v.preferred_nodes
Date:   Fri, 30 Oct 2020 12:02:32 -0700
Message-Id: <20201030190238.306764-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201030190238.306764-1-ben.widawsky@intel.com>
References: <20201030190238.306764-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that preferred_nodes is just a mask, and policies are mutually
exclusive, there is no reason to have a separate mask.

This patch is optional. It definitely helps clean up code in future
patches, but there is no functional difference to leaving it with the
previous name. I do believe it helps demonstrate the exclusivity of the
fields.

Link: https://lore.kernel.org/r/20200630212517.308045-7-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 include/linux/mempolicy.h |   6 +-
 mm/mempolicy.c            | 112 ++++++++++++++++++--------------------
 2 files changed, 55 insertions(+), 63 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 23ee10556b82..ec811c35513e 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -46,11 +46,7 @@ struct mempolicy {
 	atomic_t refcnt;
 	unsigned short mode; 	/* See MPOL_* above */
 	unsigned short flags;	/* See set_mempolicy() MPOL_F_* above */
-	union {
-		nodemask_t preferred_nodes; /* preferred */
-		nodemask_t nodes; /* interleave/bind */
-		/* undefined for default */
-	} v;
+	nodemask_t nodes;	/* interleave/bind/many */
 	union {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1b88c133f5c5..f15dae340333 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -199,7 +199,7 @@ static int mpol_new_interleave(struct mempolicy *pol, const nodemask_t *nodes)
 {
 	if (nodes_empty(*nodes))
 		return -EINVAL;
-	pol->v.nodes = *nodes;
+	pol->nodes = *nodes;
 	return 0;
 }
 
@@ -211,7 +211,7 @@ static int mpol_new_preferred_many(struct mempolicy *pol,
 	else if (nodes_empty(*nodes))
 		return -EINVAL;			/*  no allowed nodes */
 	else
-		pol->v.preferred_nodes = *nodes;
+		pol->nodes = *nodes;
 	return 0;
 }
 
@@ -231,7 +231,7 @@ static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
 {
 	if (nodes_empty(*nodes))
 		return -EINVAL;
-	pol->v.nodes = *nodes;
+	pol->nodes = *nodes;
 	return 0;
 }
 
@@ -348,15 +348,15 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 	else if (pol->flags & MPOL_F_RELATIVE_NODES)
 		mpol_relative_nodemask(&tmp, &pol->w.user_nodemask, nodes);
 	else {
-		nodes_remap(tmp, pol->v.nodes,pol->w.cpuset_mems_allowed,
-								*nodes);
+		nodes_remap(tmp, pol->nodes, pol->w.cpuset_mems_allowed,
+			    *nodes);
 		pol->w.cpuset_mems_allowed = *nodes;
 	}
 
 	if (nodes_empty(tmp))
 		tmp = *nodes;
 
-	pol->v.nodes = tmp;
+	pol->nodes = tmp;
 }
 
 static void mpol_rebind_preferred_common(struct mempolicy *pol,
@@ -369,17 +369,17 @@ static void mpol_rebind_preferred_common(struct mempolicy *pol,
 		int node = first_node(pol->w.user_nodemask);
 
 		if (node_isset(node, *nodes)) {
-			pol->v.preferred_nodes = nodemask_of_node(node);
+			pol->nodes = nodemask_of_node(node);
 			pol->flags &= ~MPOL_F_LOCAL;
 		} else
 			pol->flags |= MPOL_F_LOCAL;
 	} else if (pol->flags & MPOL_F_RELATIVE_NODES) {
 		mpol_relative_nodemask(&tmp, &pol->w.user_nodemask, nodes);
-		pol->v.preferred_nodes = tmp;
+		pol->nodes = tmp;
 	} else if (!(pol->flags & MPOL_F_LOCAL)) {
-		nodes_remap(tmp, pol->v.preferred_nodes,
-			    pol->w.cpuset_mems_allowed, *preferred_nodes);
-		pol->v.preferred_nodes = tmp;
+		nodes_remap(tmp, pol->nodes, pol->w.cpuset_mems_allowed,
+			    *preferred_nodes);
+		pol->nodes = tmp;
 		pol->w.cpuset_mems_allowed = *nodes;
 	}
 }
@@ -949,14 +949,14 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	switch (p->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		*nodes = p->v.nodes;
+		*nodes = p->nodes;
 		break;
 	case MPOL_PREFERRED_MANY:
-		*nodes = p->v.preferred_nodes;
+		*nodes = p->nodes;
 		break;
 	case MPOL_PREFERRED:
 		if (!(p->flags & MPOL_F_LOCAL))
-			*nodes = p->v.preferred_nodes;
+			*nodes = p->nodes;
 		/* else return empty node mask for local allocation */
 		break;
 	default:
@@ -1042,7 +1042,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 			*policy = err;
 		} else if (pol == current->mempolicy &&
 				pol->mode == MPOL_INTERLEAVE) {
-			*policy = next_node_in(current->il_prev, pol->v.nodes);
+			*policy = next_node_in(current->il_prev, pol->nodes);
 		} else {
 			err = -EINVAL;
 			goto out;
@@ -1898,14 +1898,14 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 	BUG_ON(dynamic_policy_zone == ZONE_MOVABLE);
 
 	/*
-	 * if policy->v.nodes has movable memory only,
+	 * if policy->nodes has movable memory only,
 	 * we apply policy when gfp_zone(gfp) = ZONE_MOVABLE only.
 	 *
-	 * policy->v.nodes is intersect with node_states[N_MEMORY].
+	 * policy->nodes is intersect with node_states[N_MEMORY].
 	 * so if the following test faile, it implies
-	 * policy->v.nodes has movable memory only.
+	 * policy->nodes has movable memory only.
 	 */
-	if (!nodes_intersects(policy->v.nodes, node_states[N_HIGH_MEMORY]))
+	if (!nodes_intersects(policy->nodes, node_states[N_HIGH_MEMORY]))
 		dynamic_policy_zone = ZONE_MOVABLE;
 
 	return zone >= dynamic_policy_zone;
@@ -1919,9 +1919,9 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 {
 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
 	if (unlikely(policy->mode == MPOL_BIND) &&
-			apply_policy_zone(policy, gfp_zone(gfp)) &&
-			cpuset_nodemask_valid_mems_allowed(&policy->v.nodes))
-		return &policy->v.nodes;
+	    apply_policy_zone(policy, gfp_zone(gfp)) &&
+	    cpuset_nodemask_valid_mems_allowed(&policy->nodes))
+		return &policy->nodes;
 
 	return NULL;
 }
@@ -1932,7 +1932,7 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 	if ((policy->mode == MPOL_PREFERRED ||
 	     policy->mode == MPOL_PREFERRED_MANY) &&
 	    !(policy->flags & MPOL_F_LOCAL)) {
-		nd = first_node(policy->v.preferred_nodes);
+		nd = first_node(policy->nodes);
 	} else {
 		/*
 		 * __GFP_THISNODE shouldn't even be used with the bind policy
@@ -1951,7 +1951,7 @@ static unsigned interleave_nodes(struct mempolicy *policy)
 	unsigned next;
 	struct task_struct *me = current;
 
-	next = next_node_in(me->il_prev, policy->v.nodes);
+	next = next_node_in(me->il_prev, policy->nodes);
 	if (next < MAX_NUMNODES)
 		me->il_prev = next;
 	return next;
@@ -1979,7 +1979,7 @@ unsigned int mempolicy_slab_node(void)
 		/*
 		 * handled MPOL_F_LOCAL above
 		 */
-		return first_node(policy->v.preferred_nodes);
+		return first_node(policy->nodes);
 
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
@@ -1995,7 +1995,7 @@ unsigned int mempolicy_slab_node(void)
 		enum zone_type highest_zoneidx = gfp_zone(GFP_KERNEL);
 		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
 		z = first_zones_zonelist(zonelist, highest_zoneidx,
-							&policy->v.nodes);
+					 &policy->nodes);
 		return z->zone ? zone_to_nid(z->zone) : node;
 	}
 
@@ -2006,12 +2006,12 @@ unsigned int mempolicy_slab_node(void)
 
 /*
  * Do static interleaving for a VMA with known offset @n.  Returns the n'th
- * node in pol->v.nodes (starting from n=0), wrapping around if n exceeds the
+ * node in pol->nodes (starting from n=0), wrapping around if n exceeds the
  * number of present nodes.
  */
 static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 {
-	unsigned nnodes = nodes_weight(pol->v.nodes);
+	unsigned nnodes = nodes_weight(pol->nodes);
 	unsigned target;
 	int i;
 	int nid;
@@ -2019,9 +2019,9 @@ static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 	if (!nnodes)
 		return numa_node_id();
 	target = (unsigned int)n % nnodes;
-	nid = first_node(pol->v.nodes);
+	nid = first_node(pol->nodes);
 	for (i = 0; i < target; i++)
-		nid = next_node(nid, pol->v.nodes);
+		nid = next_node(nid, pol->nodes);
 	return nid;
 }
 
@@ -2077,7 +2077,7 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
 	} else {
 		nid = policy_node(gfp_flags, *mpol, numa_node_id());
 		if ((*mpol)->mode == MPOL_BIND)
-			*nodemask = &(*mpol)->v.nodes;
+			*nodemask = &(*mpol)->nodes;
 	}
 	return nid;
 }
@@ -2110,19 +2110,19 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	mempolicy = current->mempolicy;
 	switch (mempolicy->mode) {
 	case MPOL_PREFERRED_MANY:
-		*mask = mempolicy->v.preferred_nodes;
+		*mask = mempolicy->nodes;
 		break;
 	case MPOL_PREFERRED:
 		if (mempolicy->flags & MPOL_F_LOCAL)
 			nid = numa_node_id();
 		else
-			nid = first_node(mempolicy->v.preferred_nodes);
+			nid = first_node(mempolicy->nodes);
 		init_nodemask_of_node(mask, nid);
 		break;
 
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		*mask =  mempolicy->v.nodes;
+		*mask = mempolicy->nodes;
 		break;
 
 	default:
@@ -2167,11 +2167,11 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 		 */
 		break;
 	case MPOL_PREFERRED_MANY:
-		ret = nodes_intersects(mempolicy->v.preferred_nodes, *mask);
+		ret = nodes_intersects(mempolicy->nodes, *mask);
 		break;
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		ret = nodes_intersects(mempolicy->v.nodes, *mask);
+		ret = nodes_intersects(mempolicy->nodes, *mask);
 		break;
 	default:
 		BUG();
@@ -2260,7 +2260,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		if ((pol->mode == MPOL_PREFERRED ||
 		     pol->mode == MPOL_PREFERRED_MANY) &&
 		    !(pol->flags & MPOL_F_LOCAL))
-			hpage_node = first_node(pol->v.preferred_nodes);
+			hpage_node = first_node(pol->nodes);
 
 		nmask = policy_nodemask(gfp, pol);
 		if (!nmask || node_isset(hpage_node, *nmask)) {
@@ -2394,15 +2394,14 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	switch (a->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		return !!nodes_equal(a->v.nodes, b->v.nodes);
+		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_PREFERRED_MANY:
-		return !!nodes_equal(a->v.preferred_nodes,
-				     b->v.preferred_nodes);
+		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_PREFERRED:
 		/* a's ->flags is the same as b's */
 		if (a->flags & MPOL_F_LOCAL)
 			return true;
-		return nodes_equal(a->v.preferred_nodes, b->v.preferred_nodes);
+		return nodes_equal(a->nodes, b->nodes);
 	default:
 		BUG();
 		return false;
@@ -2546,7 +2545,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		if (pol->flags & MPOL_F_LOCAL)
 			polnid = numa_node_id();
 		else
-			polnid = first_node(pol->v.preferred_nodes);
+			polnid = first_node(pol->nodes);
 		break;
 
 	case MPOL_BIND:
@@ -2557,12 +2556,11 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		 * else select nearest allowed node, if any.
 		 * If no allowed nodes, use current [!misplaced].
 		 */
-		if (node_isset(curnid, pol->v.nodes))
+		if (node_isset(curnid, pol->nodes))
 			goto out;
-		z = first_zones_zonelist(
-				node_zonelist(numa_node_id(), GFP_HIGHUSER),
-				gfp_zone(GFP_HIGHUSER),
-				&pol->v.nodes);
+		z = first_zones_zonelist(node_zonelist(numa_node_id(),
+						       GFP_HIGHUSER),
+					 gfp_zone(GFP_HIGHUSER), &pol->nodes);
 		polnid = zone_to_nid(z->zone);
 		break;
 
@@ -2763,11 +2761,9 @@ int mpol_set_shared_policy(struct shared_policy *info,
 	struct sp_node *new = NULL;
 	unsigned long sz = vma_pages(vma);
 
-	pr_debug("set_shared_policy %lx sz %lu %d %d %lx\n",
-		 vma->vm_pgoff,
-		 sz, npol ? npol->mode : -1,
-		 npol ? npol->flags : -1,
-		 npol ? nodes_addr(npol->v.nodes)[0] : NUMA_NO_NODE);
+	pr_debug("set_shared_policy %lx sz %lu %d %d %lx\n", vma->vm_pgoff, sz,
+		 npol ? npol->mode : -1, npol ? npol->flags : -1,
+		 npol ? nodes_addr(npol->nodes)[0] : NUMA_NO_NODE);
 
 	if (npol) {
 		new = sp_alloc(vma->vm_pgoff, vma->vm_pgoff + sz, npol);
@@ -2861,11 +2857,11 @@ void __init numa_policy_init(void)
 				     0, SLAB_PANIC, NULL);
 
 	for_each_node(nid) {
-		preferred_node_policy[nid] = (struct mempolicy) {
+		preferred_node_policy[nid] = (struct mempolicy){
 			.refcnt = ATOMIC_INIT(1),
 			.mode = MPOL_PREFERRED,
 			.flags = MPOL_F_MOF | MPOL_F_MORON,
-			.v = { .preferred_nodes = nodemask_of_node(nid), },
+			.nodes = nodemask_of_node(nid),
 		};
 	}
 
@@ -3031,9 +3027,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	 * for /proc/mounts, /proc/pid/mounts and /proc/pid/mountinfo.
 	 */
 	if (mode != MPOL_PREFERRED)
-		new->v.nodes = nodes;
+		new->nodes = nodes;
 	else if (nodelist)
-		new->v.preferred_nodes = nodemask_of_node(first_node(nodes));
+		new->nodes = nodemask_of_node(first_node(nodes));
 	else
 		new->flags |= MPOL_F_LOCAL;
 
@@ -3089,11 +3085,11 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		if (flags & MPOL_F_LOCAL)
 			mode = MPOL_LOCAL;
 		else
-			nodes_or(nodes, nodes, pol->v.preferred_nodes);
+			nodes_or(nodes, nodes, pol->nodes);
 		break;
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		nodes = pol->v.nodes;
+		nodes = pol->nodes;
 		break;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.29.2

