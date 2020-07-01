Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6775B21133F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 21:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgGATHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 15:07:36 -0400
Received: from foss.arm.com ([217.140.110.172]:39840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgGATH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:07:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A26B1FB;
        Wed,  1 Jul 2020 12:07:27 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B6BC3F68F;
        Wed,  1 Jul 2020 12:07:26 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com
Subject: [PATCH v3 6/7] sched/topology: Introduce SD metaflag for flags needing > 1 groups
Date:   Wed,  1 Jul 2020 20:06:54 +0100
Message-Id: <20200701190656.10126-7-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701190656.10126-1-valentin.schneider@arm.com>
References: <20200701190656.10126-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of cleaning up the sd_degenerate*() functions, mark flags
that are only relevant when their associated domain has more than a single
group. With this, build a compile-time mask of those SD flags.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 60 ++++++++++++++++++++++------------
 include/linux/sched/topology.h |  7 ++++
 2 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index c0003b252d48..408832193a94 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -8,7 +8,7 @@
 #endif
 
 /*
- * Expected flag uses
+ * Hierarchical metaflags
  *
  * SHARED_CHILD: These flags are meant to be set from the base domain upwards.
  * If a domain has this flag set, all of its children should have it set. This
@@ -29,36 +29,50 @@
  * certain level (e.g. domain starts spanning CPUs outside of the base CPU's
  * socket).
  */
-#define SDF_SHARED_CHILD 0x1
-#define SDF_SHARED_PARENT 0x2
+#define SDF_SHARED_CHILD       0x1
+#define SDF_SHARED_PARENT      0x2
+
+/*
+ * Behavioural metaflags
+ *
+ * NEEDS_GROUPS: These flags are only relevant if the domain they are set on has
+ * more than one group. This is usually for balancing flags (load balancing
+ * involves equalizing a metric between groups), or for flags describing some
+ * shared resource (which would be shared between groups).
+ */
+#define SDF_NEEDS_GROUPS       0x4
 
 /*
  * Balance when about to become idle
  *
  * SHARED_CHILD: Set from the base domain up to cpuset.sched_relax_domain_level.
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_BALANCE_NEWIDLE,     0, SDF_SHARED_CHILD)
+SD_FLAG(SD_BALANCE_NEWIDLE,     0, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Balance on exec
  *
  * SHARED_CHILD: Set from the base domain up to the NUMA reclaim level.
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_BALANCE_EXEC,        1, SDF_SHARED_CHILD)
+SD_FLAG(SD_BALANCE_EXEC,        1, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Balance on fork, clone
  *
  * SHARED_CHILD: Set from the base domain up to the NUMA reclaim level.
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_BALANCE_FORK,        2, SDF_SHARED_CHILD)
+SD_FLAG(SD_BALANCE_FORK,        2, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Balance on wakeup
  *
  * SHARED_CHILD: Set from the base domain up to cpuset.sched_relax_domain_level.
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_BALANCE_WAKE,        3, SDF_SHARED_CHILD)
+SD_FLAG(SD_BALANCE_WAKE,        3, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Consider waking task on waking CPU.
@@ -71,33 +85,36 @@ SD_FLAG(SD_WAKE_AFFINE,         4, SDF_SHARED_CHILD)
  * Domain members have different CPU capacities
  *
  * SHARED_PARENT: Set from the topmost domain down to the first domain where
- * asymmetry is detected.
+ *                asymmetry is detected.
+ * NEEDS_GROUPS: Per-CPU capacity is asymmetric between groups.
  */
-SD_FLAG(SD_ASYM_CPUCAPACITY,    5, SDF_SHARED_PARENT)
+SD_FLAG(SD_ASYM_CPUCAPACITY,    5, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 
 /*
  * Domain members share CPU capacity (i.e. SMT)
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
- * CPU capacity.
+ *               CPU capacity.
+ * NEEDS_GROUPS: Capacity is shared between groups.
  */
-SD_FLAG(SD_SHARE_CPUCAPACITY,   6, SDF_SHARED_CHILD)
+SD_FLAG(SD_SHARE_CPUCAPACITY,   6, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Domain members share CPU package resources (i.e. caches)
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
- * the same cache(s).
+ *               the same cache(s).
+ * NEEDS_GROUPS: Caches are shared between groups.
  */
-SD_FLAG(SD_SHARE_PKG_RESOURCES, 7, SDF_SHARED_CHILD)
+SD_FLAG(SD_SHARE_PKG_RESOURCES, 7, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Only a single load balancing instance
  *
  * SHARED_PARENT: Set for all NUMA levels above NODE. Could be set from a
- * different level upwards, but it doesn't change that if a domain has this flag
- * set, then all of its parents need to have it too (otherwise the serialization
- * doesn't make sense).
+ *                different level upwards, but it doesn't change that if a
+ *                domain has this flag set, then all of its parents need to have
+ *                it too (otherwise the serialization doesn't make sense).
  */
 SD_FLAG(SD_SERIALIZE,           8, SDF_SHARED_PARENT)
 
@@ -105,16 +122,18 @@ SD_FLAG(SD_SERIALIZE,           8, SDF_SHARED_PARENT)
  * Place busy tasks earlier in the domain
  *
  * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
- * up, but currently assumed to be set from the base domain upwards (see
- * update_top_cache_domain()).
+ *               up, but currently assumed to be set from the base domain
+ *               upwards (see update_top_cache_domain()).
  */
-SD_FLAG(SD_ASYM_PACKING,        9, SDF_SHARED_CHILD)
+SD_FLAG(SD_ASYM_PACKING,        9, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Prefer to place tasks in a sibling domain
  *
  * Set up until domains start spanning NUMA nodes. Close to being a SHARED_CHILD
  * flag, but cleared below domains with SD_ASYM_CPUCAPACITY.
+ *
+ * NEEDS_GROUPS: Load balancing flag.
  */
 SD_FLAG(SD_PREFER_SIBLING,      10, 0)
 
@@ -122,8 +141,9 @@ SD_FLAG(SD_PREFER_SIBLING,      10, 0)
  * sched_groups of this level overlap
  *
  * SHARED_PARENT: Set for all NUMA levels above NODE.
+ * NEEDS_GROUPS: Overlaps can only exist with more than one group.
  */
-SD_FLAG(SD_OVERLAP,             11, SDF_SHARED_PARENT)
+SD_FLAG(SD_OVERLAP,             11, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
 
 /*
  * cross-node balancing
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index fce64dae09af..a6761d5d66dd 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -16,6 +16,13 @@
 #include <linux/sched/sd_flags.h>
 #undef SD_FLAG
 
+/* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
+#define SD_FLAG(name, idx, mflags) (BIT(idx) * (((mflags) & SDF_NEEDS_GROUPS) / SDF_NEEDS_GROUPS)) |
+static const int SD_DEGENERATE_GROUPS_MASK =
+#include<linux/sched/sd_flags.h>
+0;
+#undef SD_FLAG
+
 #ifdef CONFIG_SCHED_DEBUG
 #define SD_FLAG(_name, idx, mflags) [idx] = {.meta_flags = mflags, .name = #_name},
 static const struct {
-- 
2.27.0

