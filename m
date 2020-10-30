Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF972A0AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgJ3QMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:55 -0400
Received: from foss.arm.com ([217.140.110.172]:39126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbgJ3QMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFA3116F2;
        Fri, 30 Oct 2020 09:12:52 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF8BD3F719;
        Fri, 30 Oct 2020 09:12:50 -0700 (PDT)
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
Subject: [PATCH 14/24] x86/resctrl: Make update_domains() learn the affected closids
Date:   Fri, 30 Oct 2020 16:11:10 +0000
Message-Id: <20201030161120.227225-15-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the closid is present in the staged configuration,
update_domains() can learn which low/high values it should update,
instead of being explicitly told. This paves the way for multiple
configuration changes being staged, affecting different indexes
in the ctrlval array.

Remove the single passed in closid, and update msr_param as each
staged config is applied.

Once the L2/L2CODE/L2DATA resources are merged this will allow
update_domains() to be called once for the single resource, even
when CDP is in use. This results in both CODE and DATA
configurations being applied and the two consecutive closids being
updated with a single smp_call_function_many().

This keeps the CDP odd/even behaviour inside the arch code for resctrl,
so that architectures that don't do this don't need to emulate it.

As update_domains() applies the staged configuration to the hw_dom's
configuration array, and updates the hardware, make it part of the
arch code interface.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 40 +++++++++++++++++------
 arch/x86/kernel/cpu/resctrl/internal.h    |  6 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 include/linux/resctrl.h                   |  1 +
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index f7152c7fdc1b..91864c2e5795 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -249,37 +249,44 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	return -EINVAL;
 }
 
-static void apply_config(struct rdt_hw_domain *hw_dom,
+/*
+ * Merge the staged config with the domains configuration array.
+ * Return true if changes were made.
+ */
+static bool apply_config(struct rdt_hw_domain *hw_dom,
 			 struct resctrl_staged_config *cfg,
-			 cpumask_var_t cpu_mask, bool mba_sc)
+			 cpumask_var_t cpu_mask, u32 idx, bool mba_sc)
 {
 	struct rdt_domain *dom = &hw_dom->resctrl;
 	u32 *dc = mba_sc ? hw_dom->mbps_val : hw_dom->ctrl_val;
 
-	if (cfg->new_ctrl != dc[cfg->closid]) {
+	cfg->have_new_ctrl = false;
+	if (cfg->new_ctrl != dc[idx]) {
 		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
-		dc[cfg->closid] = cfg->new_ctrl;
+		dc[idx] = cfg->new_ctrl;
+
+		return true;
 	}
 
-	cfg->have_new_ctrl = false;
+	return false;
 }
 
-int update_domains(struct rdt_resource *r, int closid)
+int resctrl_arch_update_domains(struct rdt_resource *r)
 {
 	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
+	bool msr_param_init = false;
 	struct msr_param msr_param;
 	enum resctrl_conf_type t;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	bool mba_sc;
 	int cpu;
+	u32 idx;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	msr_param.low = closid;
-	msr_param.high = msr_param.low + 1;
 	msr_param.res = r;
 
 	mba_sc = is_mba_sc(r);
@@ -290,10 +297,23 @@ int update_domains(struct rdt_resource *r, int closid)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			apply_config(hw_dom, cfg, cpu_mask, mba_sc);
+			idx = cfg->closid;
+			if (!apply_config(hw_dom, cfg, cpu_mask, idx, mba_sc))
+				continue;
+
+			if (!msr_param_init) {
+				msr_param.low = idx;
+				msr_param.high = idx;
+				msr_param_init = true;
+			} else {
+				msr_param.low = min(msr_param.low, idx);
+				msr_param.high = max(msr_param.high, idx);
+			}
 		}
 	}
 
+	msr_param.high += 1;
+
 	/*
 	 * Avoid writing the control msr with control values when
 	 * MBA software controller is enabled
@@ -387,7 +407,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	list_for_each_entry(s, &resctrl_all_schema, list) {
 		r = s->res;
-		ret = update_domains(r, rdtgrp->closid);
+		ret = resctrl_arch_update_domains(r);
 		if (ret)
 			goto out;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5294ae0c3ed9..e86550d888cc 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -324,8 +324,8 @@ static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
  */
 struct msr_param {
 	struct rdt_resource	*res;
-	int			low;
-	int			high;
+	u32			low;
+	u32			high;
 };
 
 static inline bool is_llc_occupancy_enabled(void)
@@ -498,7 +498,7 @@ void rdt_pseudo_lock_release(void);
 int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
-int update_domains(struct rdt_resource *r, int closid);
+int update_domains(struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5eb14dc9c579..c6689cad1ce7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2870,7 +2870,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 				return ret;
 		}
 
-		ret = update_domains(r, rdtgrp->closid);
+		ret = resctrl_arch_update_domains(r);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
 			return ret;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index e33d6dfce8a1..2b3828df13cf 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -203,5 +203,6 @@ struct resctrl_schema {
 
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+int resctrl_arch_update_domains(struct rdt_resource *r);
 
 #endif /* _RESCTRL_H */
-- 
2.28.0

