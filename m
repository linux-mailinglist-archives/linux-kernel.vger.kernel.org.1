Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344112A0E40
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgJ3TDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:03:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:30204 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbgJ3TCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:02:51 -0400
IronPort-SDR: aZyS2rohDoAuMzVG6G9WhDJhb6cfxXS+UG8JWwtLChYwvvKh+PjMANm4JuR0LebmK9o6dHnR5B
 FyUO74DlMCHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="165154842"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="165154842"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:51 -0700
IronPort-SDR: SuIoIL/dDSU08OxuWu8YahYZfn8VQvQTKVMPi4c+6T8GsDkvv3KVoI87AZbhAFxrAVg2m9nEpy
 ZdMoZYP/dKfA==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537167706"
Received: from kingelix-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.139.120])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:50 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] mm/mempolicy: VMA allocation for many preferred
Date:   Fri, 30 Oct 2020 12:02:36 -0700
Message-Id: <20201030190238.306764-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201030190238.306764-1-ben.widawsky@intel.com>
References: <20201030190238.306764-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements MPOL_PREFERRED_MANY for alloc_pages_vma(). Like
alloc_pages_current(), alloc_pages_vma() needs to support policy based
decisions if they've been configured via mbind(2).

The temporary "hack" of treating MPOL_PREFERRED and MPOL_PREFERRED_MANY
can now be removed with this, too.

All the actual machinery to make this work was part of
("mm/mempolicy: Create a page allocator for policy")

Link: https://lore.kernel.org/r/20200630212517.308045-11-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2d19235413db..343340c87f03 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2259,8 +2259,6 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 {
 	struct mempolicy *pol;
 	struct page *page;
-	int preferred_nid;
-	nodemask_t *nmask;
 
 	pol = get_vma_policy(vma, addr);
 
@@ -2274,6 +2272,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 	}
 
 	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
+		nodemask_t *nmask;
 		int hpage_node = node;
 
 		/*
@@ -2287,10 +2286,26 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * does not allow the current node in its nodemask, we allocate
 		 * the standard way.
 		 */
-		if ((pol->mode == MPOL_PREFERRED ||
-		     pol->mode == MPOL_PREFERRED_MANY) &&
-		    !(pol->flags & MPOL_F_LOCAL))
+		if (pol->mode == MPOL_PREFERRED || !(pol->flags & MPOL_F_LOCAL)) {
 			hpage_node = first_node(pol->nodes);
+		} else if (pol->mode == MPOL_PREFERRED_MANY) {
+			struct zoneref *z;
+
+			/*
+			 * In this policy, with direct reclaim, the normal
+			 * policy based allocation will do the right thing - try
+			 * twice using the preferred nodes first, and all nodes
+			 * second.
+			 */
+			if (gfp & __GFP_DIRECT_RECLAIM) {
+				page = alloc_pages_policy(pol, gfp, order, NUMA_NO_NODE);
+				goto out;
+			}
+
+			z = first_zones_zonelist(node_zonelist(numa_node_id(), GFP_HIGHUSER),
+						 gfp_zone(GFP_HIGHUSER), &pol->nodes);
+			hpage_node = zone_to_nid(z->zone);
+		}
 
 		nmask = policy_nodemask(gfp, pol);
 		if (!nmask || node_isset(hpage_node, *nmask)) {
@@ -2316,9 +2331,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		}
 	}
 
-	nmask = policy_nodemask(gfp, pol);
-	preferred_nid = policy_node(gfp, pol, node);
-	page = __alloc_pages_nodemask(gfp, order, preferred_nid, nmask);
+	page = alloc_pages_policy(pol, gfp, order, NUMA_NO_NODE);
 	mpol_cond_put(pol);
 out:
 	return page;
-- 
2.29.2

