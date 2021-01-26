Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D900C303148
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbhAZBa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 20:30:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:55285 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730484AbhAZB1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:27:38 -0500
IronPort-SDR: wMDSRCaUOBekKodHUMyC314IOfwssGY5EWwtK7mw3sAeZUY6Ug9YDU7TcmYdWfvadaHn0VjTHr
 EVnFP4vowN1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159603664"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159603664"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 16:41:41 -0800
IronPort-SDR: fc/X8K9y05Pr1mhru+giHLxQVW8LAF42oFEoqlw70j5Iu/qt8MTDikaqhL4RrLaD1AGFYvTxKw
 iIivcob160Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="368924671"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga002.jf.intel.com with ESMTP; 25 Jan 2021 16:41:41 -0800
Subject: [RFC][PATCH 05/13] mm/numa: automatically generate node migration order
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 25 Jan 2021 16:34:21 -0800
References: <20210126003411.2AC51464@viggo.jf.intel.com>
In-Reply-To: <20210126003411.2AC51464@viggo.jf.intel.com>
Message-Id: <20210126003421.45897BF4@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

When memory fills up on a node, memory contents can be
automatically migrated to another node.  The biggest problems are
knowing when to migrate and to where the migration should be
targeted.

The most straightforward way to generate the "to where" list
would be to follow the page allocator fallback lists.  Those
lists already tell us if memory is full where to look next.  It
would also be logical to move memory in that order.

But, the allocator fallback lists have a fatal flaw: most nodes
appear in all the lists.  This would potentially lead to
migration cycles (A->B, B->A, A->B, ...).

Instead of using the allocator fallback lists directly, keep a
separate node migration ordering.  But, reuse the same data used
to generate page allocator fallback in the first place:
find_next_best_node().

This means that the firmware data used to populate node distances
essentially dictates the ordering for now.  It should also be
architecture-neutral since all NUMA architectures have a working
find_next_best_node().

The protocol for node_demotion[] access and writing is not
standard.  It has no specific locking and is intended to be read
locklessly.  Readers must take care to avoid observing changes
that appear incoherent.  This was done so that node_demotion[]
locking has no chance of becoming a bottleneck on large systems
with lots of CPUs in direct reclaim.

This code is unused for now.  It will be called later in the
series.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>
---

 b/mm/internal.h   |    5 +
 b/mm/migrate.c    |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 b/mm/page_alloc.c |    2 
 3 files changed, 142 insertions(+), 2 deletions(-)

diff -puN mm/internal.h~auto-setup-default-migration-path-from-firmware mm/internal.h
--- a/mm/internal.h~auto-setup-default-migration-path-from-firmware	2021-01-25 16:23:10.607866706 -0800
+++ b/mm/internal.h	2021-01-25 16:23:10.616866706 -0800
@@ -515,12 +515,17 @@ static inline void mminit_validate_memmo
 
 #ifdef CONFIG_NUMA
 extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
+extern int find_next_best_node(int node, nodemask_t *used_node_mask);
 #else
 static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
 				unsigned int order)
 {
 	return NODE_RECLAIM_NOSCAN;
 }
+static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
+{
+	return NUMA_NO_NODE;
+}
 #endif
 
 extern int hwpoison_filter(struct page *p);
diff -puN mm/migrate.c~auto-setup-default-migration-path-from-firmware mm/migrate.c
--- a/mm/migrate.c~auto-setup-default-migration-path-from-firmware	2021-01-25 16:23:10.609866706 -0800
+++ b/mm/migrate.c	2021-01-25 16:23:10.617866706 -0800
@@ -1161,6 +1161,10 @@ out:
 	return rc;
 }
 
+/*
+ * Writes to this array occur without locking.  READ_ONCE()
+ * is recommended for readers to ensure consistent reads.
+ */
 static int node_demotion[MAX_NUMNODES] = {[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
 
 /**
@@ -1174,7 +1178,13 @@ static int node_demotion[MAX_NUMNODES] =
  */
 int next_demotion_node(int node)
 {
-	return node_demotion[node];
+	/*
+	 * node_demotion[] is updated without excluding
+	 * this function from running.  READ_ONCE() avoids
+	 * reading multiple, inconsistent 'node' values
+	 * during an update.
+	 */
+	return READ_ONCE(node_demotion[node]);
 }
 
 /*
@@ -3124,3 +3134,128 @@ void migrate_vma_finalize(struct migrate
 }
 EXPORT_SYMBOL(migrate_vma_finalize);
 #endif /* CONFIG_DEVICE_PRIVATE */
+
+/* Disable reclaim-based migration. */
+static void disable_all_migrate_targets(void)
+{
+	int node;
+
+	for_each_online_node(node)
+		node_demotion[node] = NUMA_NO_NODE;
+}
+
+/*
+ * Find an automatic demotion target for 'node'.
+ * Failing here is OK.  It might just indicate
+ * being at the end of a chain.
+ */
+static int establish_migrate_target(int node, nodemask_t *used)
+{
+	int migration_target;
+
+	/*
+	 * Can not set a migration target on a
+	 * node with it already set.
+	 *
+	 * No need for READ_ONCE() here since this
+	 * in the write path for node_demotion[].
+	 * This should be the only thread writing.
+	 */
+	if (node_demotion[node] != NUMA_NO_NODE)
+		return NUMA_NO_NODE;
+
+	migration_target = find_next_best_node(node, used);
+	if (migration_target == NUMA_NO_NODE)
+		return NUMA_NO_NODE;
+
+	node_demotion[node] = migration_target;
+
+	return migration_target;
+}
+
+/*
+ * When memory fills up on a node, memory contents can be
+ * automatically migrated to another node instead of
+ * discarded at reclaim.
+ *
+ * Establish a "migration path" which will start at nodes
+ * with CPUs and will follow the priorities used to build the
+ * page allocator zonelists.
+ *
+ * The difference here is that cycles must be avoided.  If
+ * node0 migrates to node1, then neither node1, nor anything
+ * node1 migrates to can migrate to node0.
+ *
+ * This function can run simultaneously with readers of
+ * node_demotion[].  However, it can not run simultaneously
+ * with itself.  Exclusion is provided by memory hotplug events
+ * being single-threaded.
+ */
+void __set_migration_target_nodes(void)
+{
+	nodemask_t next_pass	= NODE_MASK_NONE;
+	nodemask_t this_pass	= NODE_MASK_NONE;
+	nodemask_t used_targets = NODE_MASK_NONE;
+	int node;
+
+	/*
+	 * Avoid any oddities like cycles that could occur
+	 * from changes in the topology.  This will leave
+	 * a momentary gap when migration is disabled.
+	 */
+	disable_all_migrate_targets();
+
+	/*
+	 * Ensure that the "disable" is visible across the system.
+	 * Readers will see either a combination of before+disable
+	 * state or disable+after.  They will never see before and
+	 * after state together.
+	 *
+	 * The before+after state together might have cycles and
+	 * could cause readers to do things like loop until this
+	 * function finishes.  This ensures they can only see a
+	 * single "bad" read and would, for instance, only loop
+	 * once.
+	 */
+	smp_wmb();
+
+	/*
+	 * Allocations go close to CPUs, first.  Assume that
+	 * the migration path starts at the nodes with CPUs.
+	 */
+	next_pass = node_states[N_CPU];
+again:
+	this_pass = next_pass;
+	next_pass = NODE_MASK_NONE;
+	/*
+	 * To avoid cycles in the migration "graph", ensure
+	 * that migration sources are not future targets by
+	 * setting them in 'used_targets'.  Do this only
+	 * once per pass so that multiple source nodes can
+	 * share a target node.
+	 *
+	 * 'used_targets' will become unavailable in future
+	 * passes.  This limits some opportunities for
+	 * multiple source nodes to share a desintation.
+	 */
+	nodes_or(used_targets, used_targets, this_pass);
+	for_each_node_mask(node, this_pass) {
+		int target_node = establish_migrate_target(node, &used_targets);
+
+		if (target_node == NUMA_NO_NODE)
+			continue;
+
+		/* Visit targets from this pass in the next pass: */
+		node_set(target_node, next_pass);
+	}
+	/* Is another pass necessary? */
+	if (!nodes_empty(next_pass))
+		goto again;
+}
+
+void set_migration_target_nodes(void)
+{
+	get_online_mems();
+	__set_migration_target_nodes();
+	put_online_mems();
+}
diff -puN mm/page_alloc.c~auto-setup-default-migration-path-from-firmware mm/page_alloc.c
--- a/mm/page_alloc.c~auto-setup-default-migration-path-from-firmware	2021-01-25 16:23:10.612866706 -0800
+++ b/mm/page_alloc.c	2021-01-25 16:23:10.619866706 -0800
@@ -5704,7 +5704,7 @@ static int node_load[MAX_NUMNODES];
  *
  * Return: node id of the found node or %NUMA_NO_NODE if no node is found.
  */
-static int find_next_best_node(int node, nodemask_t *used_node_mask)
+int find_next_best_node(int node, nodemask_t *used_node_mask)
 {
 	int n, val;
 	int min_val = INT_MAX;
_
