Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F94F1C0391
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgD3REn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 13:04:43 -0400
Received: from foss.arm.com ([217.140.110.172]:59262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgD3REk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:04:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C355B1045;
        Thu, 30 Apr 2020 10:04:39 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 748003F73D;
        Thu, 30 Apr 2020 10:04:38 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2 10/10] cacheinfo: Move resctrl's get_cache_id() to the cacheinfo header file
Date:   Thu, 30 Apr 2020 18:04:00 +0100
Message-Id: <20200430170400.21501-11-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200430170400.21501-1-james.morse@arm.com>
References: <20200430170400.21501-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl/core.c defines get_cache_id() for use in its cpu-hotplug
callbacks. This gets the id attribute of the cache at the corresponding
level of a cpu.

Later rework means this private function needs to be shared. Move
it to the header file.

The name conflicts with a different definition in intel_cacheinfo.c,
name it get_cpu_cacheinfo_id() to show its relation with
get_cpu_cacheinfo().

Now this is visible on other architectures, check the id attribute
has actually been set.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 17 ++---------------
 include/linux/cacheinfo.h          | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 00c88f42742c..f6458cefcac3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -350,19 +350,6 @@ static void rdt_get_cdp_l2_config(void)
 	rdt_get_cdp_config(RDT_RESOURCE_L2, RDT_RESOURCE_L2CODE);
 }
 
-static int get_cache_id(int cpu, int level)
-{
-	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
-	int i;
-
-	for (i = 0; i < ci->num_leaves; i++) {
-		if (ci->info_list[i].level == level)
-			return ci->info_list[i].id;
-	}
-
-	return -1;
-}
-
 static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
@@ -560,7 +547,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
  */
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cache_id(cpu, r->cache_level);
+	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
 	struct list_head *add_pos = NULL;
 	struct rdt_domain *d;
 
@@ -606,7 +593,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cache_id(cpu, r->cache_level);
+	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
 	struct rdt_domain *d;
 
 	d = rdt_find_domain(r, id, NULL);
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 46b92cd61d0c..4f72b47973c3 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -3,6 +3,7 @@
 #define _LINUX_CACHEINFO_H
 
 #include <linux/bitops.h>
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/smp.h>
 
@@ -119,4 +120,24 @@ int acpi_find_last_cache_level(unsigned int cpu);
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
+/*
+ * Get the id of the cache associated with @cpu at level @level.
+ * cpuhp lock must be held.
+ */
+static inline int get_cpu_cacheinfo_id(int cpu, int level)
+{
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
+	int i;
+
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == level) {
+			if (ci->info_list[i].attributes & CACHE_ID)
+				return ci->info_list[i].id;
+			return -1;
+		}
+	}
+
+	return -1;
+}
+
 #endif /* _LINUX_CACHEINFO_H */
-- 
2.26.1

