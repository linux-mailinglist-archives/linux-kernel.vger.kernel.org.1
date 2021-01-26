Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F9230315D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbhAZBhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 20:37:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:55285 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbhAZBa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:30:59 -0500
IronPort-SDR: cGX5wmeXoyNkH3B+di89KOb1DCr1aYb8oJ12WMLMlXmsOZGCW0/BVw9PH27QfD+FIpBNzEaJ+Z
 Glf+CQh+zsdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159603668"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159603668"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 16:41:44 -0800
IronPort-SDR: PjZAmHZ3H+ri1AAuXp0LSzLrLXT8f16sbk3mCFfOmBkY5c25vEFmYlggoQPl7hGhpma7s9aiGO
 4s4wgQU4meEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="353265040"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2021 16:41:42 -0800
Subject: [RFC][PATCH 06/13] mm/migrate: update migration order during on hotplug events
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 25 Jan 2021 16:34:23 -0800
References: <20210126003411.2AC51464@viggo.jf.intel.com>
In-Reply-To: <20210126003411.2AC51464@viggo.jf.intel.com>
Message-Id: <20210126003423.8D2B5637@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Reclaim-based migration is attempting to optimize data placement in
memory based on the system topology.  If the system changes, so must
the migration ordering.

The implementation here is pretty simple and entirely unoptimized.  On
any memory or CPU hotplug events, assume that a node was added or
removed and recalculate all migration targets.  This ensures that the
node_demotion[] array is always ready to be used in case the new
reclaim mode is enabled.

This recalculation is far from optimal, most glaringly that it does
not even attempt to figure out if nodes are actually coming or going.
But, given the expected paucity of hotplug events, this should be
fine.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>
---

 b/mm/migrate.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 2 deletions(-)

diff -puN mm/migrate.c~enable-numa-demotion mm/migrate.c
--- a/mm/migrate.c~enable-numa-demotion	2021-01-25 16:23:11.850866703 -0800
+++ b/mm/migrate.c	2021-01-25 16:23:11.855866703 -0800
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/ptrace.h>
 #include <linux/oom.h>
+#include <linux/memory.h>
 
 #include <asm/tlbflush.h>
 
@@ -3135,6 +3136,7 @@ void migrate_vma_finalize(struct migrate
 EXPORT_SYMBOL(migrate_vma_finalize);
 #endif /* CONFIG_DEVICE_PRIVATE */
 
+#if defined(CONFIG_MEMORY_HOTPLUG)
 /* Disable reclaim-based migration. */
 static void disable_all_migrate_targets(void)
 {
@@ -3191,7 +3193,7 @@ static int establish_migrate_target(int
  * with itself.  Exclusion is provided by memory hotplug events
  * being single-threaded.
  */
-void __set_migration_target_nodes(void)
+static void __set_migration_target_nodes(void)
 {
 	nodemask_t next_pass	= NODE_MASK_NONE;
 	nodemask_t this_pass	= NODE_MASK_NONE;
@@ -3253,9 +3255,100 @@ again:
 		goto again;
 }
 
-void set_migration_target_nodes(void)
+/*
+ * For callers that do not hold get_online_mems() already.
+ */
+static void set_migration_target_nodes(void)
 {
 	get_online_mems();
 	__set_migration_target_nodes();
 	put_online_mems();
 }
+
+/*
+ * React to hotplug events that might affect the migration targes
+ * like events that online or offline NUMA nodes.
+ *
+ * The ordering is also currently dependent on which nodes have
+ * CPUs.  That means we need CPU on/offline notification too.
+ */
+static int migration_online_cpu(unsigned int cpu)
+{
+	set_migration_target_nodes();
+	return 0;
+}
+
+static int migration_offline_cpu(unsigned int cpu)
+{
+	set_migration_target_nodes();
+	return 0;
+}
+
+/*
+ * This leaves migrate-on-reclaim transiently disabled
+ * between the MEM_GOING_OFFLINE and MEM_OFFLINE events.
+ * This runs reclaim-based micgration is enabled or not.
+ * This ensures that the user can turn reclaim-based
+ * migration at any time without needing to recalcuate
+ * migration targets.
+ *
+ * These callbacks already hold get_online_mems().  That
+ * is why __set_migration_target_nodes() can be used as
+ * opposed to set_migration_target_nodes().
+ */
+static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
+						 unsigned long action, void *arg)
+{
+	switch (action) {
+	case MEM_GOING_OFFLINE:
+		/*
+		 * Make sure there are not transient states where
+		 * an offline node is a migration target.  This
+		 * will leave migration disabled until the offline
+		 * completes and the MEM_OFFLINE case below runs.
+		 */
+		disable_all_migrate_targets();
+		break;
+	case MEM_OFFLINE:
+	case MEM_ONLINE:
+		/*
+		 * Recalculate the target nodes once the node
+		 * reaches its final state (online or offline).
+		 */
+		__set_migration_target_nodes();
+		break;
+	case MEM_CANCEL_OFFLINE:
+		/*
+		 * MEM_GOING_OFFLINE disabled all the migration
+		 * targets.  Reenable them.
+		 */
+		__set_migration_target_nodes();
+		break;
+	case MEM_GOING_ONLINE:
+	case MEM_CANCEL_ONLINE:
+		break;
+	}
+
+	return notifier_from_errno(0);
+}
+
+static int __init migrate_on_reclaim_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "migrate on reclaim",
+				migration_online_cpu,
+				migration_offline_cpu);
+	/*
+	 * In the unlikely case that this fails, the automatic
+	 * migration targets may become suboptimal for nodes
+	 * where N_CPU changes.  With such a small impact in a
+	 * rare case, do not bother trying to do anything special.
+	 */
+	WARN_ON(ret < 0);
+
+	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
+	return 0;
+}
+late_initcall(migrate_on_reclaim_init);
+#endif /* CONFIG_MEMORY_HOTPLUG */
_
