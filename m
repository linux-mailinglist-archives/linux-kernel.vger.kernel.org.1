Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DA72A0AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgJ3QMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:48 -0400
Received: from foss.arm.com ([217.140.110.172]:39052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbgJ3QMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BBFD1688;
        Fri, 30 Oct 2020 09:12:44 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E586A3F719;
        Fri, 30 Oct 2020 09:12:41 -0700 (PDT)
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
Subject: [PATCH 11/24] x86/resctrl: Group staged configuration into a separate struct
Date:   Fri, 30 Oct 2020 16:11:07 +0000
Message-Id: <20201030161120.227225-12-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm's MPAM may have surprisingly large bitmaps for its cache
portions as the architecture allows up to 4K portions. The size
exposed via resctrl may not be the same, some scaling may
occur.

The values written to hardware may be unlike the values received
from resctrl, e.g. MBA percentages may be backed by a bitmap,
or a maximum value that isn't a percentage.

Today resctrl's ctrlval arrays are written to directly by the
resctrl filesystem code. e.g. apply_config(). This is a problem
if scaling or conversion is needed by the architecture.

The arch code should own the ctrlval array (to allow scaling and
conversion), and should only need a single copy of the array for the
values currently applied in hardware.

Move the new_ctrl bitmap value and flag into a struct for staged
configuration changes. This is created as an array to allow one per type
of configuration. Today there is only one element in the array, but
eventually resctrl will use the array slots for CODE/DATA/BOTH to detect
a duplicate schema being written.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 49 ++++++++++++++++-------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 22 +++++-----
 include/linux/resctrl.h                   | 17 +++++---
 3 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 28d69c78c29e..0c95ed83eb05 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -60,18 +60,19 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d)
 {
+	struct resctrl_staged_config *cfg = &d->staged_config[0];
 	struct rdt_resource *r = s->res;
 	unsigned long bw_val;
 
-	if (d->have_new_ctrl) {
+	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
 
 	if (!bw_validate(data->buf, &bw_val, r))
 		return -EINVAL;
-	d->new_ctrl = bw_val;
-	d->have_new_ctrl = true;
+	cfg->new_ctrl = bw_val;
+	cfg->have_new_ctrl = true;
 
 	return 0;
 }
@@ -129,11 +130,12 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d)
 {
+	struct resctrl_staged_config *cfg = &d->staged_config[0];
 	struct rdtgroup *rdtgrp = data->rdtgrp;
 	struct rdt_resource *r = s->res;
 	u32 cbm_val;
 
-	if (d->have_new_ctrl) {
+	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
@@ -175,8 +177,8 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 		}
 	}
 
-	d->new_ctrl = cbm_val;
-	d->have_new_ctrl = true;
+	cfg->new_ctrl = cbm_val;
+	cfg->have_new_ctrl = true;
 
 	return 0;
 }
@@ -190,6 +192,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
+	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
 	char *dom = NULL, *id;
@@ -220,6 +223,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 			if (r->parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
+				cfg = &d->staged_config[0];
 				/*
 				 * In pseudo-locking setup mode and just
 				 * parsed a valid CBM that should be
@@ -230,7 +234,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 				 */
 				rdtgrp->plr->s = s;
 				rdtgrp->plr->d = d;
-				rdtgrp->plr->cbm = d->new_ctrl;
+				rdtgrp->plr->cbm = cfg->new_ctrl;
 				d->plr = rdtgrp->plr;
 				return 0;
 			}
@@ -240,15 +244,30 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	return -EINVAL;
 }
 
+static void apply_config(struct rdt_hw_domain *hw_dom,
+			 struct resctrl_staged_config *cfg, int closid,
+			 cpumask_var_t cpu_mask, bool mba_sc)
+{
+	struct rdt_domain *dom = &hw_dom->resctrl;
+	u32 *dc = mba_sc ? hw_dom->mbps_val : hw_dom->ctrl_val;
+
+	if (cfg->new_ctrl != dc[closid]) {
+		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
+		dc[closid] = cfg->new_ctrl;
+	}
+
+	cfg->have_new_ctrl = false;
+}
+
 int update_domains(struct rdt_resource *r, int closid)
 {
+	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	bool mba_sc;
-	u32 *dc;
-	int cpu;
+	int cpu, i;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
@@ -260,10 +279,12 @@ int update_domains(struct rdt_resource *r, int closid)
 	mba_sc = is_mba_sc(r);
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
-		dc = !mba_sc ? hw_dom->ctrl_val : hw_dom->mbps_val;
-		if (d->have_new_ctrl && d->new_ctrl != dc[closid]) {
-			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
-			dc[closid] = d->new_ctrl;
+		for (i = 0; i < ARRAY_SIZE(d->staged_config); i++) {
+			cfg = &hw_dom->resctrl.staged_config[i];
+			if (!cfg->have_new_ctrl)
+				continue;
+
+			apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
 		}
 	}
 
@@ -338,7 +359,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	list_for_each_entry(s, &resctrl_all_schema, list) {
 		list_for_each_entry(dom, &s->res->domains, list)
-			dom->have_new_ctrl = false;
+			memset(dom->staged_config, 0, sizeof(dom->staged_config));
 	}
 
 	while ((tok = strsep(&buf, "\n")) != NULL) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 48f4d6783647..c307170ee45f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2748,6 +2748,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
 	struct rdt_resource *r_cdp = NULL;
+	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d_cdp = NULL;
 	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
@@ -2757,8 +2758,9 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	int i;
 
 	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
-	d->have_new_ctrl = false;
-	d->new_ctrl = r->cache.shareable_bits;
+	cfg = &d->staged_config[0];
+	cfg->have_new_ctrl = false;
+	cfg->new_ctrl = r->cache.shareable_bits;
 	used_b = r->cache.shareable_bits;
 	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
 	for (i = 0; i < closids_supported(); i++, ctrl++) {
@@ -2782,29 +2784,29 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				peer_ctl = 0;
 			used_b |= *ctrl | peer_ctl;
 			if (mode == RDT_MODE_SHAREABLE)
-				d->new_ctrl |= *ctrl | peer_ctl;
+				cfg->new_ctrl |= *ctrl | peer_ctl;
 		}
 	}
 	if (d->plr && d->plr->cbm > 0)
 		used_b |= d->plr->cbm;
 	unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
 	unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
-	d->new_ctrl |= unused_b;
+	cfg->new_ctrl |= unused_b;
 	/*
 	 * Force the initial CBM to be valid, user can
 	 * modify the CBM based on system availability.
 	 */
-	d->new_ctrl = cbm_ensure_valid(d->new_ctrl, r);
+	cfg->new_ctrl = cbm_ensure_valid(cfg->new_ctrl, r);
 	/*
 	 * Assign the u32 CBM to an unsigned long to ensure that
 	 * bitmap_weight() does not access out-of-bound memory.
 	 */
-	tmp_cbm = d->new_ctrl;
+	tmp_cbm = cfg->new_ctrl;
 	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
 		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
 		return -ENOSPC;
 	}
-	d->have_new_ctrl = true;
+	cfg->have_new_ctrl = true;
 
 	return 0;
 }
@@ -2836,11 +2838,13 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 /* Initialize MBA resource with default values. */
 static void rdtgroup_init_mba(struct rdt_resource *r)
 {
+	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d;
 
 	list_for_each_entry(d, &r->domains, list) {
-		d->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
-		d->have_new_ctrl = true;
+		cfg = &d->staged_config[0];
+		cfg->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
+		cfg->have_new_ctrl = true;
 	}
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 9f71f0238239..f1164bbb66c5 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -26,13 +26,21 @@ enum resctrl_conf_type {
 	CDP_DATA,
 };
 
+/**
+ * struct resctrl_staged_config - parsed configuration to be applied
+ * @new_ctrl:		new ctrl value to be loaded
+ * @have_new_ctrl:	did user provide new_ctrl for this domain
+ */
+struct resctrl_staged_config {
+	u32			new_ctrl;
+	bool			have_new_ctrl;
+};
+
 /**
  * struct rdt_domain - group of cpus sharing an RDT resource
  * @list:		all instances of this resource
  * @id:			unique id for this instance
  * @cpu_mask:		which cpus share this resource
- * @new_ctrl:		new ctrl value to be loaded
- * @have_new_ctrl:	did user provide new_ctrl for this domain
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
  * @mbm_total:		saved state for MBM total bandwidth
  * @mbm_local:		saved state for MBM local bandwidth
@@ -41,15 +49,13 @@ enum resctrl_conf_type {
  * @mbm_work_cpu:	worker cpu for MBM h/w counters
  * @cqm_work_cpu:	worker cpu for CQM h/w counters
  * @plr:		pseudo-locked region (if any) associated with domain
+ * @staged_config:	parsed configuration to be applied
  */
 struct rdt_domain {
 	struct list_head		list;
 	int				id;
 	struct cpumask			cpu_mask;
 
-	u32				new_ctrl;
-	bool				have_new_ctrl;
-
 	unsigned long			*rmid_busy_llc;
 	struct mbm_state		*mbm_total;
 	struct mbm_state		*mbm_local;
@@ -59,6 +65,7 @@ struct rdt_domain {
 	int				cqm_work_cpu;
 
 	struct pseudo_lock_region	*plr;
+	struct resctrl_staged_config	staged_config[1];
 };
 
 /**
-- 
2.28.0

