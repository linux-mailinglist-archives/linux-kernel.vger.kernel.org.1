Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91552A0AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgJ3QNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:13:15 -0400
Received: from foss.arm.com ([217.140.110.172]:39240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbgJ3QNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:13:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFA051684;
        Fri, 30 Oct 2020 09:13:12 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15B573F719;
        Fri, 30 Oct 2020 09:13:10 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 20/24] x86/resctrl: Apply offset correction when config is staged
Date:   Fri, 30 Oct 2020 16:11:16 +0000
Message-Id: <20201030161120.227225-21-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When resctrl comes to write the CAT MSR values, it applies an
adjustment based on the style of the resource. CODE and DATA
resources have their closid mapped into an odd/even range.

Previously the ctrlval array was increased to be the same size
regardless of CODE/DATA/BOTH. Move the arithmetic into apply_config()
so that odd/even slots in the ctrlval array are used.

This makes it possible to merge the resources.

In future, the arithmetic will be based on the style of the configuration,
not the resource.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        | 15 +--------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 15 ++++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  7 -------
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b2fda4cd88ba..79b17ece4528 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -195,11 +195,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 };
 
-static unsigned int cbm_idx(struct rdt_resource *r, unsigned int closid)
-{
-	return closid * r->cache.cbm_idx_mult + r->cache.cbm_idx_offset;
-}
-
 /*
  * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
  * as they do not have CPUID enumeration support for Cache allocation.
@@ -438,7 +433,7 @@ cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 	unsigned int i;
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + cbm_idx(r, i), hw_dom->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
@@ -549,14 +544,6 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 
 	m.low = 0;
 	m.high = hw_res->num_closid;
-
-	/*
-	 * temporary: the array is full-size, but cat_wrmsr() still re-maps
-	 * the index.
-	 */
-	if (hw_res->conf_type != CDP_BOTH)
-		m.high /= 2;
-
 	hw_res->msr_update(d, &m, r);
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index f6b4049c67c2..28a251cf3c60 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -249,6 +249,14 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	return -EINVAL;
 }
 
+static unsigned int cbm_idx(struct rdt_resource *r, unsigned int closid)
+{
+	if (r->rid == RDT_RESOURCE_MBA)
+		return closid;
+
+	return closid * r->cache.cbm_idx_mult + r->cache.cbm_idx_offset;
+}
+
 /*
  * Merge the staged config with the domains configuration array.
  * Return true if changes were made.
@@ -297,7 +305,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			idx = cfg->closid;
+			idx = cbm_idx(r, cfg->closid);
 			if (!apply_config(hw_dom, cfg, cpu_mask, idx, mba_sc))
 				continue;
 
@@ -432,11 +440,12 @@ void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 closid, enum resctrl_conf_type type, u32 *value)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	u32 idx = cbm_idx(r, closid);
 
 	if (!is_mba_sc(r))
-		*value = hw_dom->ctrl_val[closid];
+		*value = hw_dom->ctrl_val[idx];
 	else
-		*value = hw_dom->mbps_val[closid];
+		*value = hw_dom->mbps_val[idx];
 }
 
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 4fa6c386d751..162e415d5d09 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2379,13 +2379,6 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	msr_param.low = 0;
 	msr_param.high = hw_res->num_closid;
 
-	/*
-	 * temporary: the array is full-sized, but cat_wrmsr() still re-maps
-	 * the index.
-	 */
-	if (hw_res->cdp_enabled)
-		msr_param.high /= 2;
-
 	/*
 	 * Disable resource control for this resource by setting all
 	 * CBMs in all domains to the maximum mask value. Pick one CPU
-- 
2.28.0

