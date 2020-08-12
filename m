Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91862429D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 14:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgHLMyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 08:54:24 -0400
Received: from foss.arm.com ([217.140.110.172]:44596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbgHLMxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:53:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 045E413D5;
        Wed, 12 Aug 2020 05:53:23 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C32C13F792;
        Wed, 12 Aug 2020 05:53:21 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v5 07/17] sched/topology: Introduce SD metaflag for flags needing > 1 groups
Date:   Wed, 12 Aug 2020 13:52:50 +0100
Message-Id: <20200812125300.11889-8-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812125300.11889-1-valentin.schneider@arm.com>
References: <20200812125300.11889-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of cleaning up the sd_degenerate*() functions, mark flags
used in sd_degenerate() with the new SDF_NEEDS_GROUPS flag. With this,
build a compile-time mask of those SD flags.

Note that sd_parent_degenerate() uses an extra flag in its mask,
SD_PREFER_SIBLING, which remains singled out for now.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 39 ++++++++++++++++++++++++----------
 include/linux/sched/topology.h |  7 ++++++
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index ea0ec1a33da4..21a43ad6f26a 100644
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
@@ -29,29 +29,42 @@
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
-SD_FLAG(SD_BALANCE_NEWIDLE, SDF_SHARED_CHILD)
+SD_FLAG(SD_BALANCE_NEWIDLE, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Balance on exec
  *
  * SHARED_CHILD: Set from the base domain up to the NUMA reclaim level.
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_BALANCE_EXEC, SDF_SHARED_CHILD)
+SD_FLAG(SD_BALANCE_EXEC, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Balance on fork, clone
  *
  * SHARED_CHILD: Set from the base domain up to the NUMA reclaim level.
+ * NEEDS_GROUPS: Load balancing flag.
  */
-SD_FLAG(SD_BALANCE_FORK, SDF_SHARED_CHILD)
+SD_FLAG(SD_BALANCE_FORK, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Balance on wakeup
@@ -69,24 +82,28 @@ SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
 
 /*
  * Domain members have different CPU capacities
+ *
+ * NEEDS_GROUPS: Per-CPU capacity is asymmetric between groups.
  */
-SD_FLAG(SD_ASYM_CPUCAPACITY, 0)
+SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_NEEDS_GROUPS)
 
 /*
  * Domain members share CPU capacity (i.e. SMT)
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
- * CPU capacity.
+ *               CPU capacity.
+ * NEEDS_GROUPS: Capacity is shared between groups.
  */
-SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD)
+SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Domain members share CPU package resources (i.e. caches)
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
- * the same cache(s).
+ *               the same cache(s).
+ * NEEDS_GROUPS: Caches are shared between groups.
  */
-SD_FLAG(SD_SHARE_PKG_RESOURCES, SDF_SHARED_CHILD)
+SD_FLAG(SD_SHARE_PKG_RESOURCES, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
 
 /*
  * Only a single load balancing instance
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 32f602ff37a0..2d59ca77103e 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -25,6 +25,13 @@ enum {
 };
 #undef SD_FLAG
 
+/* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
+#define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_NEEDS_GROUPS)) |
+static const unsigned int SD_DEGENERATE_GROUPS_MASK =
+#include <linux/sched/sd_flags.h>
+0;
+#undef SD_FLAG
+
 #ifdef CONFIG_SCHED_DEBUG
 #define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
 static const struct {
-- 
2.27.0

