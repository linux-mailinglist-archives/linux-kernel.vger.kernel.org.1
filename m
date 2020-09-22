Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594FC273B40
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgIVGye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:54:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:63428 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbgIVGyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:54:33 -0400
IronPort-SDR: 9E4BYeie6ROSMnkO9OqKOOEWpOYx1NFRxeW62lGliITZFPkUnzXBe5jLIbp0/zJ0iwUhXFsmC8
 Xu7yX7jWsc0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="245386212"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="245386212"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 23:54:33 -0700
IronPort-SDR: uL6ZEh4+QkK4B7jYVcpSqFTt11KDoZHGeimnATf6+7xFTr8WG3QICWTd1zEhfHQ33LDV5UGrNZ
 F8XxaCiSS9eQ==
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="485834643"
Received: from yhuang-mobile.sh.intel.com ([10.238.4.22])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 23:54:29 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: [RFC -V2] autonuma: Migrate on fault among multiple bound nodes
Date:   Tue, 22 Sep 2020 14:54:01 +0800
Message-Id: <20200922065401.376348-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
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

Questions:

Sysctl knob kernel.numa_balancing can enable/disable AutoNUMA optimizing
globally.  But for the memory areas that are bound to multiple NUMA nodes, even
if the AutoNUMA is enabled globally via the sysctl knob, we still need to enable
AutoNUMA again with a special flag.  Why not just optimize the page placement if
possible as long as AutoNUMA is enabled globally?  The interface would look
simpler with that.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
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
index eddbe4e56c73..273969204732 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2494,15 +2494,19 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
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
+				goto moron;
 			goto out;
+		}
 		z = first_zones_zonelist(
 				node_zonelist(numa_node_id(), GFP_HIGHUSER),
 				gfp_zone(GFP_HIGHUSER),
@@ -2516,6 +2520,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 
 	/* Migrate the page towards the node whose CPU is referencing it */
 	if (pol->flags & MPOL_F_MORON) {
+moron:
 		polnid = thisnid;
 
 		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
-- 
2.28.0

