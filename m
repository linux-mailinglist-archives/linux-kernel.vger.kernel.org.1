Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55270211341
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 21:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGATHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 15:07:45 -0400
Received: from foss.arm.com ([217.140.110.172]:39796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbgGATHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:07:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEE78101E;
        Wed,  1 Jul 2020 12:07:22 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B04BE3F68F;
        Wed,  1 Jul 2020 12:07:21 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: [PATCH v3 2/7] sched/topology: Define and assign sched_domain flag metadata
Date:   Wed,  1 Jul 2020 20:06:50 +0100
Message-Id: <20200701190656.10126-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701190656.10126-1-valentin.schneider@arm.com>
References: <20200701190656.10126-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some expectations regarding how sched domain flags should be laid
out, but none of them are checked or asserted in
sched_domain_debug_one(). After staring at said flags for a while, I've
come to realize they all (except *one*) fall in either of two categories:

- Shared with children: those flags are set from the base CPU domain
  upwards. Any domain that has it set will have it set in its children. It
  hints at "some property holds true / some behaviour is enabled until this
  level".

- Shared with parents: those flags are set from the topmost domain
  downwards. Any domain that has it set will have it set in its parents. It
  hints at "some property isn't visible / some behaviour is disabled until
  this level".

The odd one out is SD_PREFER_SIBLING, which is cleared below levels with
SD_ASYM_CPUCAPACITY. The change was introduced by commit

  9c63e84db29b ("sched/core: Disable SD_PREFER_SIBLING on asymmetric CPU capacity domains")

as it could break misfit migration on some systems. In light of this, we
might want to change it back to make it fit one of the two categories and
fix the issue another way.

Tweak the sched_domain flag declaration to assign each flag an expected
layout, and include the rationale for each flag "meta type" assignment as a
comment. Consolidate the flag metadata into an array; the index of a flag's
metadata can easily be found with log2(flag), IOW __ffs(flag).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 164 +++++++++++++++++++++++++++------
 include/linux/sched/topology.h |  13 ++-
 2 files changed, 148 insertions(+), 29 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 685bbe736945..b5a11df0afe4 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -3,31 +3,139 @@
  * sched-domains (multiprocessor balancing) flag declarations.
  */
 
-/* Balance when about to become idle */
-SD_FLAG(SD_BALANCE_NEWIDLE,     0)
-/* Balance on exec */
-SD_FLAG(SD_BALANCE_EXEC,        1)
-/* Balance on fork, clone */
-SD_FLAG(SD_BALANCE_FORK,        2)
-/* Balance on wakeup */
-SD_FLAG(SD_BALANCE_WAKE,        3)
-/* Wake task to waking CPU */
-SD_FLAG(SD_WAKE_AFFINE,         4)
-/* Domain members have different CPU capacities */
-SD_FLAG(SD_ASYM_CPUCAPACITY,    5)
-/* Domain members share CPU capacity */
-SD_FLAG(SD_SHARE_CPUCAPACITY,   6)
-/* Domain members share power domain */
-SD_FLAG(SD_SHARE_POWERDOMAIN,   7)
-/* Domain members share CPU pkg resources */
-SD_FLAG(SD_SHARE_PKG_RESOURCES, 8)
-/* Only a single load balancing instance */
-SD_FLAG(SD_SERIALIZE,           9)
-/* Place busy groups earlier in the domain */
-SD_FLAG(SD_ASYM_PACKING,        10)
-/* Prefer to place tasks in a sibling domain */
-SD_FLAG(SD_PREFER_SIBLING,      11)
-/* sched_domains of this level overlap */
-SD_FLAG(SD_OVERLAP,             12)
-/* cross-node balancing */
-SD_FLAG(SD_NUMA,                13)
+#ifndef SD_FLAG
+#define SD_FLAG(x, y, z)
+#endif
+
+/*
+ * Expected flag uses
+ *
+ * SHARED_CHILD: These flags are meant to be set from the base domain upwards.
+ * If a domain has this flag set, all of its children should have it set. This
+ * is usually because the flag describes some shared resource (all CPUs in that
+ * domain share the same foobar), or because they are tied to a scheduling
+ * behaviour that we want to disable at some point in the hierarchy for
+ * scalability reasons.
+ *
+ * In those cases it doesn't make sense to have the flag set for a domain but
+ * not have it in (some of) its children: sched domains ALWAYS span their child
+ * domains, so operations done with parent domains will cover CPUs in the lower
+ * child domains.
+ *
+ *
+ * SHARED_PARENT: These flags are meant to be set from the highest domain
+ * downwards. If a domain has this flag set, all of its parents should have it
+ * set. This is usually for topology properties that start to appear above a
+ * certain level (e.g. domain starts spanning CPUs outside of the base CPU's
+ * socket).
+ */
+#define SDF_SHARED_CHILD 0x1
+#define SDF_SHARED_PARENT 0x2
+
+/*
+ * Balance when about to become idle
+ *
+ * SHARED_CHILD: Set from the base domain up to cpuset.sched_relax_domain_level.
+ */
+SD_FLAG(SD_BALANCE_NEWIDLE,     0, SDF_SHARED_CHILD)
+
+/*
+ * Balance on exec
+ *
+ * SHARED_CHILD: Set from the base domain up to the NUMA reclaim level.
+ */
+SD_FLAG(SD_BALANCE_EXEC,        1, SDF_SHARED_CHILD)
+
+/*
+ * Balance on fork, clone
+ *
+ * SHARED_CHILD: Set from the base domain up to the NUMA reclaim level.
+ */
+SD_FLAG(SD_BALANCE_FORK,        2, SDF_SHARED_CHILD)
+
+/*
+ * Balance on wakeup
+ *
+ * SHARED_CHILD: Set from the base domain up to cpuset.sched_relax_domain_level.
+ */
+SD_FLAG(SD_BALANCE_WAKE,        3, SDF_SHARED_CHILD)
+
+/*
+ * Consider waking task on waking CPU.
+ *
+ * SHARED_CHILD: Set from the base domain up to the NUMA reclaim level.
+ */
+SD_FLAG(SD_WAKE_AFFINE,         4, SDF_SHARED_CHILD)
+
+/*
+ * Domain members have different CPU capacities
+ *
+ * SHARED_PARENT: Set from the topmost domain down to the first domain where
+ * asymmetry is detected.
+ */
+SD_FLAG(SD_ASYM_CPUCAPACITY,    5, SDF_SHARED_PARENT)
+
+/*
+ * Domain members share CPU capacity (i.e. SMT)
+ *
+ * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
+ * CPU capacity.
+ */
+SD_FLAG(SD_SHARE_CPUCAPACITY,   6, SDF_SHARED_CHILD)
+
+/*
+ * Domain members share power domain
+ *
+ * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
+ * the same power domain.
+ */
+SD_FLAG(SD_SHARE_POWERDOMAIN,   7, SDF_SHARED_CHILD)
+
+/*
+ * Domain members share CPU package resources (i.e. caches)
+ *
+ * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
+ * the same cache(s).
+ */
+SD_FLAG(SD_SHARE_PKG_RESOURCES, 8, SDF_SHARED_CHILD)
+
+/*
+ * Only a single load balancing instance
+ *
+ * SHARED_PARENT: Set for all NUMA levels above NODE. Could be set from a
+ * different level upwards, but it doesn't change that if a domain has this flag
+ * set, then all of its parents need to have it too (otherwise the serialization
+ * doesn't make sense).
+ */
+SD_FLAG(SD_SERIALIZE,           9, SDF_SHARED_PARENT)
+
+/*
+ * Place busy tasks earlier in the domain
+ *
+ * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
+ * up, but currently assumed to be set from the base domain upwards (see
+ * update_top_cache_domain()).
+ */
+SD_FLAG(SD_ASYM_PACKING,        10, SDF_SHARED_CHILD)
+
+/*
+ * Prefer to place tasks in a sibling domain
+ *
+ * Set up until domains start spanning NUMA nodes. Close to being a SHARED_CHILD
+ * flag, but cleared below domains with SD_ASYM_CPUCAPACITY.
+ */
+SD_FLAG(SD_PREFER_SIBLING,      11, 0)
+
+/*
+ * sched_groups of this level overlap
+ *
+ * SHARED_PARENT: Set for all NUMA levels above NODE.
+ */
+SD_FLAG(SD_OVERLAP,             12, SDF_SHARED_PARENT)
+
+/*
+ * cross-node balancing
+ *
+ * SHARED_PARENT: Set for all NUMA levels above NODE.
+ */
+SD_FLAG(SD_NUMA,                13, SDF_SHARED_PARENT)
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index f274eca282de..fce64dae09af 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -12,10 +12,21 @@
 #ifdef CONFIG_SMP
 
 /* Generate SD_FOO = VALUE */
-#define SD_FLAG(name, idx) static const unsigned int name = BIT(idx);
+#define SD_FLAG(name, idx, mflags) static const unsigned int name = BIT(idx);
 #include <linux/sched/sd_flags.h>
 #undef SD_FLAG
 
+#ifdef CONFIG_SCHED_DEBUG
+#define SD_FLAG(_name, idx, mflags) [idx] = {.meta_flags = mflags, .name = #_name},
+static const struct {
+	unsigned int meta_flags;
+	char *name;
+} sd_flag_debug[] = {
+#include <linux/sched/sd_flags.h>
+};
+#undef SD_FLAG
+#endif
+
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
 {
-- 
2.27.0

