Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F082ACF59
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbgKJGAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:00:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:16590 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732060AbgKJGAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:00:49 -0500
IronPort-SDR: HcM2UWeVFCwLuiPZAuV0SZEsRGpw6pSvgjyUp2l5BJUHnGEw/YkrRUFOpWPoIP1RHRWI2S/0wD
 9AuJZpFZNhnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="149773105"
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="149773105"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 22:00:47 -0800
IronPort-SDR: /SathYVwYsMAXVfDTBFf2Ua3xMNyHJ/3pBunkzJzZyRBqWpkoROn55Tb8mEZVimt3h+EBwyGLB
 aEb2MZCiB5QQ==
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="473300211"
Received: from yhuang-mobile.sh.intel.com ([10.238.5.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 22:00:44 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH -V3 2/2] autonuma: Migrate on fault among multiple bound nodes
Date:   Tue, 10 Nov 2020 13:59:51 +0800
Message-Id: <20201110055951.85085-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110055951.85085-1-ying.huang@intel.com>
References: <20201110055951.85085-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, AutoNUMA can only optimize the page placement among the NUMA nodes if the
default memory policy is used.  Because the memory policy specified explicitly
should take precedence.  But this seems too strict in some situations.  For
example, on a system with 4 NUMA nodes, if the memory of an application is bound
to the node 0 and 1, AutoNUMA can potentially migrate the pages between the node
0 and 1 to reduce cross-node accessing without breaking the explicit memory
binding policy.

So in this patch, if mbind(.mode=MPOL_BIND, .flags=MPOL_MF_LAZY) is used to bind
the memory of the application to multiple nodes, and in the hint page fault
handler both the faulting page node and the accessing node are in the policy
nodemask, the page will be tried to be migrated to the accessing node to reduce
the cross-node accessing.

[Peter Zijlstra: provided the simplified implementation method.]

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
---
 mm/mempolicy.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 63d91fbd3ce6..40f2ff2607b3 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2490,15 +2490,19 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		break;
 
 	case MPOL_BIND:
-
 		/*
-		 * allows binding to multiple nodes.
-		 * use current page if in policy nodemask,
-		 * else select nearest allowed node, if any.
-		 * If no allowed nodes, use current [!misplaced].
+		 * Allows binding to multiple nodes.  If both current and
+		 * accessing nodes are in policy nodemask, migrate to
+		 * accessing node to optimize page placement. Otherwise,
+		 * use current page if in policy nodemask, else select
+		 * nearest allowed node, if any.  If no allowed nodes, use
+		 * current [!misplaced].
 		 */
-		if (node_isset(curnid, pol->v.nodes))
+		if (node_isset(curnid, pol->v.nodes)) {
+			if (node_isset(thisnid, pol->v.nodes))
+				goto mopron;
 			goto out;
+		}
 		z = first_zones_zonelist(
 				node_zonelist(numa_node_id(), GFP_HIGHUSER),
 				gfp_zone(GFP_HIGHUSER),
@@ -2512,6 +2516,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 
 	/* Migrate the page towards the node whose CPU is referencing it */
 	if (pol->flags & MPOL_F_MOPRON) {
+mopron:
 		polnid = thisnid;
 
 		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
-- 
2.28.0

