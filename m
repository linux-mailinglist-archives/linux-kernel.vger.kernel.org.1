Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5FB2A0AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgJ3QM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:59 -0400
Received: from foss.arm.com ([217.140.110.172]:39142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbgJ3QM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 823A61684;
        Fri, 30 Oct 2020 09:12:56 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 770023F719;
        Fri, 30 Oct 2020 09:12:54 -0700 (PDT)
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
Subject: [PATCH 15/24] x86/resctrl: Add a helper to read a closid's configuration
Date:   Fri, 30 Oct 2020 16:11:11 +0000
Message-Id: <20201030161120.227225-16-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware configuration may look completely different to the
values resctrl gets from user-space. The staged configuration
and resctrl_arch_update_domains() allow the architecture to
convert or translate these values.
(e.g. Arm's MPAM may back MBA's percentage control using the
 'BWPBM' bitmap)

Resctrl shouldn't read or write these values directly. As a
step towards taking direct access away, add a helper to read
the current configuration.

This will allow another architecture to scale the bitmaps if
necessary, and possibly use controls that don't take the user-space
control format at all.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 16 ++++++---
 arch/x86/kernel/cpu/resctrl/monitor.c     |  6 +++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 43 ++++++++++-------------
 include/linux/resctrl.h                   |  2 ++
 4 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 91864c2e5795..0cf2f24e5c3b 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -428,22 +428,30 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+			     u32 closid, u32 *value)
+{
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+
+	if (!is_mba_sc(r))
+		*value = hw_dom->ctrl_val[closid];
+	else
+		*value = hw_dom->mbps_val[closid];
+}
+
 static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
 {
 	struct rdt_resource *r = schema->res;
-	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *dom;
 	bool sep = false;
 	u32 ctrl_val;
 
 	seq_printf(s, "%*s:", RESCTRL_NAME_LEN, schema->name);
 	list_for_each_entry(dom, &r->domains, list) {
-		hw_dom = resctrl_to_arch_dom(dom);
 		if (sep)
 			seq_puts(s, ";");
 
-		ctrl_val = (!is_mba_sc(r) ? hw_dom->ctrl_val[closid] :
-			    hw_dom->mbps_val[closid]);
+		resctrl_arch_get_config(r, dom, closid, &ctrl_val);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 8b7d7ebfcd4b..6a62f1323b27 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -379,8 +379,12 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	user_bw = hw_dom_mba->mbps_val[closid];
+	resctrl_arch_get_config(r_mba, dom_mba, closid, &user_bw);
 	delta_bw = pmbm_data->delta_bw;
+	/*
+	 * resctrl_arch_get_config() chooses the mbps/ctrl value to return
+	 * based on is_mba_sc(). For now, reach into the hw_dom.
+	 */
 	cur_msr_val = hw_dom_mba->ctrl_val[closid];
 
 	/*
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c6689cad1ce7..f168f5a39242 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -911,27 +911,27 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 	int i, hwb, swb, excl, psl;
 	enum rdtgrp_mode mode;
 	bool sep = false;
-	u32 *ctrl;
+	u32 ctrl_val;
 
 	mutex_lock(&rdtgroup_mutex);
 	hw_shareable = r->cache.shareable_bits;
 	list_for_each_entry(dom, &r->domains, list) {
 		if (sep)
 			seq_putc(seq, ';');
-		ctrl = resctrl_to_arch_dom(dom)->ctrl_val;
 		sw_shareable = 0;
 		exclusive = 0;
 		seq_printf(seq, "%d=", dom->id);
-		for (i = 0; i < closids_supported(); i++, ctrl++) {
+		for (i = 0; i < closids_supported(); i++) {
 			if (!closid_allocated(i))
 				continue;
+			resctrl_arch_get_config(r, dom, i, &ctrl_val);
 			mode = rdtgroup_mode_by_closid(i);
 			switch (mode) {
 			case RDT_MODE_SHAREABLE:
-				sw_shareable |= *ctrl;
+				sw_shareable |= ctrl_val;
 				break;
 			case RDT_MODE_EXCLUSIVE:
-				exclusive |= *ctrl;
+				exclusive |= ctrl_val;
 				break;
 			case RDT_MODE_PSEUDO_LOCKSETUP:
 			/*
@@ -1190,7 +1190,6 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 {
 	enum rdtgrp_mode mode;
 	unsigned long ctrl_b;
-	u32 *ctrl;
 	int i;
 
 	/* Check for any overlap with regions used by hardware directly */
@@ -1201,9 +1200,8 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 	}
 
 	/* Check for overlap with other resource groups */
-	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
-	for (i = 0; i < closids_supported(); i++, ctrl++) {
-		ctrl_b = *ctrl;
+	for (i = 0; i < closids_supported(); i++) {
+		resctrl_arch_get_config(r, d, i, (u32 *)&ctrl_b);
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
 		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
@@ -1271,12 +1269,12 @@ bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
  */
 static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 {
-	struct rdt_hw_domain *hw_dom;
 	int closid = rdtgrp->closid;
 	struct resctrl_schema *s;
 	struct rdt_resource *r;
 	bool has_cache = false;
 	struct rdt_domain *d;
+	u32 ctrl;
 
 	list_for_each_entry(s, &resctrl_all_schema, list) {
 		r = s->res;
@@ -1284,10 +1282,8 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
-			hw_dom = resctrl_to_arch_dom(d);
-			if (rdtgroup_cbm_overlaps(s, d,
-						  hw_dom->ctrl_val[closid],
-						  rdtgrp->closid, false)) {
+			resctrl_arch_get_config(r, d, closid, &ctrl);
+			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
 			}
@@ -1419,7 +1415,6 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			      struct seq_file *s, void *v)
 {
 	struct resctrl_schema *schema;
-	struct rdt_hw_domain *hw_dom;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	struct rdt_domain *d;
@@ -1456,15 +1451,13 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 		sep = false;
 		seq_printf(s, "%*s:", RESCTRL_NAME_LEN, schema->name);
 		list_for_each_entry(d, &r->domains, list) {
-			hw_dom = resctrl_to_arch_dom(d);
 			if (sep)
 				seq_putc(s, ';');
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 				size = 0;
 			} else {
-				ctrl = (!is_mba_sc(r) ?
-						hw_dom->ctrl_val[rdtgrp->closid] :
-						hw_dom->mbps_val[rdtgrp->closid]);
+				resctrl_arch_get_config(r, d, rdtgrp->closid,
+							&ctrl);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
@@ -2753,9 +2746,9 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	struct rdt_domain *d_cdp = NULL;
 	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
+	u32 peer_ctl, ctrl_val;
 	unsigned long tmp_cbm;
 	enum rdtgrp_mode mode;
-	u32 peer_ctl, *ctrl;
 	int i;
 
 	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
@@ -2763,8 +2756,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	cfg->have_new_ctrl = false;
 	cfg->new_ctrl = r->cache.shareable_bits;
 	used_b = r->cache.shareable_bits;
-	ctrl = resctrl_to_arch_dom(d)->ctrl_val;
-	for (i = 0; i < closids_supported(); i++, ctrl++) {
+	for (i = 0; i < closids_supported(); i++) {
 		if (closid_allocated(i) && i != closid) {
 			mode = rdtgroup_mode_by_closid(i);
 			if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
@@ -2780,12 +2772,13 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 			 * with an exclusive group.
 			 */
 			if (d_cdp)
-				peer_ctl = resctrl_to_arch_dom(d_cdp)->ctrl_val[i];
+				resctrl_arch_get_config(r_cdp, d_cdp, i, &peer_ctl);
 			else
 				peer_ctl = 0;
-			used_b |= *ctrl | peer_ctl;
+			resctrl_arch_get_config(r, d, i, &ctrl_val);
+			used_b |= ctrl_val | peer_ctl;
 			if (mode == RDT_MODE_SHAREABLE)
-				cfg->new_ctrl |= *ctrl | peer_ctl;
+				cfg->new_ctrl |= ctrl_val | peer_ctl;
 		}
 	}
 	if (d->plr && d->plr->cbm > 0)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 2b3828df13cf..b870c2f3c3c9 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -204,5 +204,7 @@ struct resctrl_schema {
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r);
+void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
+			     u32 closid, u32 *value);
 
 #endif /* _RESCTRL_H */
-- 
2.28.0

