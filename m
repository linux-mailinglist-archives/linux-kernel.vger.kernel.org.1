Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE842A0E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgJ3TCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:02:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:30187 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgJ3TCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:02:48 -0400
IronPort-SDR: hedyexmQcMQ5/7z/CNfsIG/nJhIRgn4CtYpftYt2kQAEzGBGk6LaUnaYfDC33mIOXIUzcjHkxy
 2Fcv6FbuzTIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="165154829"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="165154829"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:47 -0700
IronPort-SDR: 24CKGV2ZTWdkoHTRAXXx5t8VkNBk6e7V/ORJK960s9NkdXGjaSh5lsQSjeXxcpceLeui7AbRs8
 K1wjTTiXBtLA==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537167692"
Received: from kingelix-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.139.120])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:47 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] mm/mempolicy: handle MPOL_PREFERRED_MANY like BIND
Date:   Fri, 30 Oct 2020 12:02:33 -0700
Message-Id: <20201030190238.306764-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201030190238.306764-1-ben.widawsky@intel.com>
References: <20201030190238.306764-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Begin the real plumbing for handling this new policy. Now that the
internal representation for preferred nodes and bound nodes is the same,
and we can envision what multiple preferred nodes will behave like,
there are obvious places where we can simply reuse the bind behavior.

In v1 of this series, the moral equivalent was:
"mm: Finish handling MPOL_PREFERRED_MANY". Like that, this attempts to
implement the easiest spots for the new policy. Unlike that, this just
reuses BIND.

Link: https://lore.kernel.org/r/20200630212517.308045-8-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f15dae340333..a991dabb636d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -949,8 +949,6 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	switch (p->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		*nodes = p->nodes;
-		break;
 	case MPOL_PREFERRED_MANY:
 		*nodes = p->nodes;
 		break;
@@ -1918,7 +1916,8 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 {
 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
-	if (unlikely(policy->mode == MPOL_BIND) &&
+	if (unlikely(policy->mode == MPOL_BIND ||
+		     policy->mode == MPOL_PREFERRED_MANY) &&
 	    apply_policy_zone(policy, gfp_zone(gfp)) &&
 	    cpuset_nodemask_valid_mems_allowed(&policy->nodes))
 		return &policy->nodes;
@@ -1974,7 +1973,6 @@ unsigned int mempolicy_slab_node(void)
 		return node;
 
 	switch (policy->mode) {
-	case MPOL_PREFERRED_MANY:
 	case MPOL_PREFERRED:
 		/*
 		 * handled MPOL_F_LOCAL above
@@ -1984,6 +1982,7 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
 
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND: {
 		struct zoneref *z;
 
@@ -2109,9 +2108,6 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	task_lock(current);
 	mempolicy = current->mempolicy;
 	switch (mempolicy->mode) {
-	case MPOL_PREFERRED_MANY:
-		*mask = mempolicy->nodes;
-		break;
 	case MPOL_PREFERRED:
 		if (mempolicy->flags & MPOL_F_LOCAL)
 			nid = numa_node_id();
@@ -2122,6 +2118,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_MANY:
 		*mask = mempolicy->nodes;
 		break;
 
@@ -2165,12 +2162,11 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 		 * Thus, it's possible for tsk to have allocated memory from
 		 * nodes in mask.
 		 */
-		break;
-	case MPOL_PREFERRED_MANY:
 		ret = nodes_intersects(mempolicy->nodes, *mask);
 		break;
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_MANY:
 		ret = nodes_intersects(mempolicy->nodes, *mask);
 		break;
 	default:
@@ -2394,7 +2390,6 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	switch (a->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_PREFERRED_MANY:
 		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_PREFERRED:
@@ -2548,6 +2543,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 			polnid = first_node(pol->nodes);
 		break;
 
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 
 		/*
@@ -2564,8 +2560,6 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		polnid = zone_to_nid(z->zone);
 		break;
 
-		/* case MPOL_PREFERRED_MANY: */
-
 	default:
 		BUG();
 	}
@@ -3078,15 +3072,13 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	switch (mode) {
 	case MPOL_DEFAULT:
 		break;
-	case MPOL_PREFERRED_MANY:
-		WARN_ON(flags & MPOL_F_LOCAL);
-		fallthrough;
 	case MPOL_PREFERRED:
 		if (flags & MPOL_F_LOCAL)
 			mode = MPOL_LOCAL;
 		else
 			nodes_or(nodes, nodes, pol->nodes);
 		break;
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		nodes = pol->nodes;
-- 
2.29.2

