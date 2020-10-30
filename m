Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40742A0AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgJ3QMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:19 -0400
Received: from foss.arm.com ([217.140.110.172]:38844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3QMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EFED143B;
        Fri, 30 Oct 2020 09:12:16 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64ACD3F719;
        Fri, 30 Oct 2020 09:12:14 -0700 (PDT)
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
Subject: [PATCH 02/24] x86/resctrl: Split struct rdt_domain
Date:   Fri, 30 Oct 2020 16:10:58 +0000
Message-Id: <20201030161120.227225-3-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl is the defacto Linux ABI for SoC resource partitioning features.
To support it on another architecture, it needs to be abstracted from
Intel RDT, and moved it to /fs/.

Split struct rdt_domain up too. Move everything that that is particular
to resctrl into a new header file. resctrl code paths touching a 'hw'
struct indicates where an abstraction is needed.

No change in behaviour, this patch just moves types around.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        | 32 +++++++++++-------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++++--
 arch/x86/kernel/cpu/resctrl/internal.h    | 40 +++++------------------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  8 +++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 ++++++++++------
 include/linux/resctrl.h                   | 35 +++++++++++++++++++-
 6 files changed, 94 insertions(+), 60 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 470661f2eb68..97040a54cc9a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -385,10 +385,11 @@ static void
 mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	unsigned int i;
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + i, d->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
 }
 
 /*
@@ -410,21 +411,23 @@ mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
 		struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	unsigned int i;
 
 	/*  Write the delay values for mba. */
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + i, delay_bw_map(d->ctrl_val[i], r));
+		wrmsrl(hw_res->msr_base + i, delay_bw_map(hw_dom->ctrl_val[i], r));
 }
 
 static void
 cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	unsigned int i;
 
 	for (i = m->low; i < m->high; i++)
-		wrmsrl(hw_res->msr_base + cbm_idx(r, i), d->ctrl_val[i]);
+		wrmsrl(hw_res->msr_base + cbm_idx(r, i), hw_dom->ctrl_val[i]);
 }
 
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
@@ -510,21 +513,22 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct msr_param m;
 	u32 *dc, *dm;
 
-	dc = kmalloc_array(hw_res->num_closid, sizeof(*d->ctrl_val), GFP_KERNEL);
+	dc = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
 	if (!dc)
 		return -ENOMEM;
 
-	dm = kmalloc_array(hw_res->num_closid, sizeof(*d->mbps_val), GFP_KERNEL);
+	dm = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->mbps_val), GFP_KERNEL);
 	if (!dm) {
 		kfree(dc);
 		return -ENOMEM;
 	}
 
-	d->ctrl_val = dc;
-	d->mbps_val = dm;
+	hw_dom->ctrl_val = dc;
+	hw_dom->mbps_val = dm;
 	setup_default_ctrlval(r, dc, dm);
 
 	m.low = 0;
@@ -586,6 +590,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
 	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
 	struct list_head *add_pos = NULL;
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
 	d = rdt_find_domain(r, id, &add_pos);
@@ -599,10 +604,11 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	d = kzalloc_node(sizeof(*d), GFP_KERNEL, cpu_to_node(cpu));
-	if (!d)
+	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
+	if (!hw_dom)
 		return;
 
+	d = &hw_dom->resctrl;
 	d->id = id;
 	cpumask_set_cpu(cpu, &d->cpu_mask);
 
@@ -631,6 +637,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 {
 	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
 	d = rdt_find_domain(r, id, NULL);
@@ -638,6 +645,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
 		return;
 	}
+	hw_dom = resctrl_to_arch_dom(d);
 
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
@@ -670,12 +678,12 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		if (d->plr)
 			d->plr->d = NULL;
 
-		kfree(d->ctrl_val);
-		kfree(d->mbps_val);
+		kfree(hw_dom->ctrl_val);
+		kfree(hw_dom->mbps_val);
 		bitmap_free(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
-		kfree(d);
+		kfree(hw_dom);
 		return;
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index ab6e584c9d2d..2e7466659af3 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -238,6 +238,7 @@ static int parse_line(char *line, struct rdt_resource *r,
 
 int update_domains(struct rdt_resource *r, int closid)
 {
+	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
@@ -254,7 +255,8 @@ int update_domains(struct rdt_resource *r, int closid)
 
 	mba_sc = is_mba_sc(r);
 	list_for_each_entry(d, &r->domains, list) {
-		dc = !mba_sc ? d->ctrl_val : d->mbps_val;
+		hw_dom = resctrl_to_arch_dom(d);
+		dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
 		if (d->have_new_ctrl && d->new_ctrl != dc[closid]) {
 			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 			dc[closid] = d->new_ctrl;
@@ -375,17 +377,19 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 static void show_doms(struct seq_file *s, struct rdt_resource *r, int closid)
 {
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *dom;
 	bool sep = false;
 	u32 ctrl_val;
 
 	seq_printf(s, "%*s:", max_name_width, r->name);
 	list_for_each_entry(dom, &r->domains, list) {
+		hw_dom = resctrl_to_arch_dom(dom);
 		if (sep)
 			seq_puts(s, ";");
 
-		ctrl_val = (!is_mba_sc(r) ? dom->ctrl_val[closid] :
-			    dom->mbps_val[closid]);
+		ctrl_val = (!is_mba_sc(r) ? hw_dom->ctrl_val[closid] :
+			    hw_dom->mbps_val[closid]);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index bcae86138cad..f7aab9245259 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -299,44 +299,22 @@ struct mbm_state {
 };
 
 /**
- * struct rdt_domain - group of cpus sharing an RDT resource
- * @list:	all instances of this resource
- * @id:		unique id for this instance
- * @cpu_mask:	which cpus share this resource
- * @rmid_busy_llc:
- *		bitmap of which limbo RMIDs are above threshold
- * @mbm_total:	saved state for MBM total bandwidth
- * @mbm_local:	saved state for MBM local bandwidth
- * @mbm_over:	worker to periodically read MBM h/w counters
- * @cqm_limbo:	worker to periodically read CQM h/w counters
- * @mbm_work_cpu:
- *		worker cpu for MBM h/w counters
- * @cqm_work_cpu:
- *		worker cpu for CQM h/w counters
+ * struct rdt_hw_domain - group of cpus sharing an RDT resource
+ * @resctrl:    Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
  * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
- * @new_ctrl:	new ctrl value to be loaded
- * @have_new_ctrl: did user provide new_ctrl for this domain
- * @plr:	pseudo-locked region (if any) associated with domain
  */
-struct rdt_domain {
-	struct list_head		list;
-	int				id;
-	struct cpumask			cpu_mask;
-	unsigned long			*rmid_busy_llc;
-	struct mbm_state		*mbm_total;
-	struct mbm_state		*mbm_local;
-	struct delayed_work		mbm_over;
-	struct delayed_work		cqm_limbo;
-	int				mbm_work_cpu;
-	int				cqm_work_cpu;
+struct rdt_hw_domain {
+	struct rdt_domain		resctrl;
 	u32				*ctrl_val;
 	u32				*mbps_val;
-	u32				new_ctrl;
-	bool				have_new_ctrl;
-	struct pseudo_lock_region	*plr;
 };
 
+static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
+{
+	return container_of(r, struct rdt_hw_domain, resctrl);
+}
+
 /**
  * struct msr_param - set a range of MSRs from a domain
  * @res:       The resource to use
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d0afd76d3578..8b7d7ebfcd4b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -355,6 +355,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	u32 closid, rmid, cur_msr, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
 	struct rdt_hw_resource *hw_r_mba;
+	struct rdt_hw_domain *hw_dom_mba;
 	u32 cur_bw, delta_bw, user_bw;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
@@ -375,11 +376,12 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 		pr_warn_once("Failure to get domain for MBA update\n");
 		return;
 	}
+	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	user_bw = dom_mba->mbps_val[closid];
+	user_bw = hw_dom_mba->mbps_val[closid];
 	delta_bw = pmbm_data->delta_bw;
-	cur_msr_val = dom_mba->ctrl_val[closid];
+	cur_msr_val = hw_dom_mba->ctrl_val[closid];
 
 	/*
 	 * For Ctrl groups read data from child monitor groups.
@@ -416,7 +418,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 
 	cur_msr = hw_r_mba->msr_base + closid;
 	wrmsrl(cur_msr, delay_bw_map(new_msr_val, r_mba));
-	dom_mba->ctrl_val[closid] = new_msr_val;
+	hw_dom_mba->ctrl_val[closid] = new_msr_val;
 
 	/*
 	 * Delta values are updated dynamically package wise for each
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e0a35a23b945..b55861ff4e34 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -916,7 +916,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 	list_for_each_entry(dom, &r->domains, list) {
 		if (sep)
 			seq_putc(seq, ';');
-		ctrl = dom->ctrl_val;
+		ctrl = resctrl_to_arch_dom(dom)->ctrl_val;
 		sw_shareable = 0;
 		exclusive = 0;
 		seq_printf(seq, "%d=", dom->id);
@@ -1195,7 +1195,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 	}
 
 	/* Check for overlap with other resource groups */
-	ctrl = d->ctrl_val;
+	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
 	for (i = 0; i < closids_supported(); i++, ctrl++) {
 		ctrl_b = *ctrl;
 		mode = rdtgroup_mode_by_closid(i);
@@ -1264,6 +1264,7 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
  */
 static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 {
+	struct rdt_hw_domain *hw_dom;
 	int closid = rdtgrp->closid;
 	struct rdt_resource *r;
 	bool has_cache = false;
@@ -1274,7 +1275,8 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
-			if (rdtgroup_cbm_overlaps(r, d, d->ctrl_val[closid],
+			hw_dom = resctrl_to_arch_dom(d);
+			if (rdtgroup_cbm_overlaps(r, d, hw_dom->ctrl_val[closid],
 						  rdtgrp->closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
@@ -1406,6 +1408,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
 {
+	struct rdt_hw_domain *hw_dom;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	struct rdt_domain *d;
@@ -1440,14 +1443,15 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		sep = false;
 		seq_printf(s, "%*s:", max_name_width, r->name);
 		list_for_each_entry(d, &r->domains, list) {
+			hw_dom = resctrl_to_arch_dom(d);
 			if (sep)
 				seq_putc(s, ';');
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 				size = 0;
 			} else {
 				ctrl = (!is_mba_sc(r) ?
-						d->ctrl_val[rdtgrp->closid] :
-						d->mbps_val[rdtgrp->closid]);
+						hw_dom->ctrl_val[rdtgrp->closid] :
+						hw_dom->mbps_val[rdtgrp->closid]);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
@@ -1951,6 +1955,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].resctrl;
+	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
 	if (!is_mbm_enabled() || !is_mba_linear() ||
@@ -1958,8 +1963,10 @@ static int set_mba_sc(bool mba_sc)
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
-	list_for_each_entry(d, &r->domains, list)
-		setup_default_ctrlval(r, d->ctrl_val, d->mbps_val);
+	list_for_each_entry(d, &r->domains, list) {
+		hw_dom = resctrl_to_arch_dom(d);
+		setup_default_ctrlval(r, hw_dom->ctrl_val, hw_dom->mbps_val);
+	}
 
 	return 0;
 }
@@ -2279,6 +2286,7 @@ static int rdt_init_fs_context(struct fs_context *fc)
 static int reset_all_ctrls(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
@@ -2297,10 +2305,11 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	 * from each domain to update the MSRs below.
 	 */
 	list_for_each_entry(d, &r->domains, list) {
+		hw_dom = resctrl_to_arch_dom(d);
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
 		for (i = 0; i < hw_res->num_closid; i++)
-			d->ctrl_val[i] = r->default_ctrl;
+			hw_dom->ctrl_val[i] = r->default_ctrl;
 	}
 	cpu = get_cpu();
 	/* Update CBM on this cpu if it's in cpu_mask. */
@@ -2688,7 +2697,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
 	d->have_new_ctrl = false;
 	d->new_ctrl = r->cache.shareable_bits;
 	used_b = r->cache.shareable_bits;
-	ctrl = d->ctrl_val;
+	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
 	for (i = 0; i < closids_supported(); i++, ctrl++) {
 		if (closid_allocated(i) && i != closid) {
 			mode = rdtgroup_mode_by_closid(i);
@@ -2705,7 +2714,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
 			 * with an exclusive group.
 			 */
 			if (d_cdp)
-				peer_ctl = d_cdp->ctrl_val[i];
+				peer_ctl = resctrl_to_arch_dom(d_cdp)->ctrl_val[i];
 			else
 				peer_ctl = 0;
 			used_b |= *ctrl | peer_ctl;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b2c2b7386d28..f5af59b8f2a9 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -15,7 +15,40 @@ int proc_resctrl_show(struct seq_file *m,
 
 #endif
 
-struct rdt_domain;
+/**
+ * struct rdt_domain - group of cpus sharing an RDT resource
+ * @list:		all instances of this resource
+ * @id:			unique id for this instance
+ * @cpu_mask:		which cpus share this resource
+ * @new_ctrl:		new ctrl value to be loaded
+ * @have_new_ctrl:	did user provide new_ctrl for this domain
+ * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
+ * @mbm_total:		saved state for MBM total bandwidth
+ * @mbm_local:		saved state for MBM local bandwidth
+ * @mbm_over:		worker to periodically read MBM h/w counters
+ * @cqm_limbo:		worker to periodically read CQM h/w counters
+ * @mbm_work_cpu:	worker cpu for MBM h/w counters
+ * @cqm_work_cpu:	worker cpu for CQM h/w counters
+ * @plr:		pseudo-locked region (if any) associated with domain
+ */
+struct rdt_domain {
+	struct list_head		list;
+	int				id;
+	struct cpumask			cpu_mask;
+
+	u32				new_ctrl;
+	bool				have_new_ctrl;
+
+	unsigned long			*rmid_busy_llc;
+	struct mbm_state		*mbm_total;
+	struct mbm_state		*mbm_local;
+	struct delayed_work		mbm_over;
+	struct delayed_work		cqm_limbo;
+	int				mbm_work_cpu;
+	int				cqm_work_cpu;
+
+	struct pseudo_lock_region	*plr;
+};
 
 /**
  * struct resctrl_cache - Cache allocation related data
-- 
2.28.0

