Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950322A0AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgJ3QNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:13:11 -0400
Received: from foss.arm.com ([217.140.110.172]:39202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbgJ3QNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:13:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 529A01684;
        Fri, 30 Oct 2020 09:13:05 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7091E3F719;
        Fri, 30 Oct 2020 09:13:03 -0700 (PDT)
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
Subject: [PATCH 18/24] x86/resctrl: Pass configuration type to resctrl_arch_get_config()
Date:   Fri, 30 Oct 2020 16:11:14 +0000
Message-Id: <20201030161120.227225-19-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the configuration arrays are merged, the get_config() helper needs to
be told whether the CODE, DATA or BOTH configuration is being retrieved.

Pass this information from the schema into resctrl_arch_get_config().

Nothing uses this yet, but it will later be used to map the closid
to the index in the configuration array.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  5 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 35 +++++++++++++++--------
 include/linux/resctrl.h                   |  3 +-
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 0cf2f24e5c3b..f6b4049c67c2 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -429,7 +429,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 }
 
 void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			     u32 closid, u32 *value)
+			     u32 closid, enum resctrl_conf_type type, u32 *value)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 
@@ -451,7 +451,8 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 		if (sep)
 			seq_puts(s, ";");
 
-		resctrl_arch_get_config(r, dom, closid, &ctrl_val);
+		resctrl_arch_get_config(r, dom, closid, schema->conf_type,
+					&ctrl_val);
 		seq_printf(s, r->format_str, dom->id, max_data_width,
 			   ctrl_val);
 		sep = true;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 6a62f1323b27..ab6630b466d5 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -379,7 +379,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	hw_dom_mba = resctrl_to_arch_dom(dom_mba);
 
 	cur_bw = pmbm_data->prev_bw;
-	resctrl_arch_get_config(r_mba, dom_mba, closid, &user_bw);
+	resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_BOTH, &user_bw);
 	delta_bw = pmbm_data->delta_bw;
 	/*
 	 * resctrl_arch_get_config() chooses the mbps/ctrl value to return
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index eeedafa7d5e7..cb9ca56ce2e6 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -924,7 +924,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 		for (i = 0; i < closids_supported(); i++) {
 			if (!closid_allocated(i))
 				continue;
-			resctrl_arch_get_config(r, dom, i, &ctrl_val);
+			resctrl_arch_get_config(r, dom, i, s->conf_type,
+						&ctrl_val);
 			mode = rdtgroup_mode_by_closid(i);
 			switch (mode) {
 			case RDT_MODE_SHAREABLE:
@@ -1101,6 +1102,7 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
  *         Used to return the result.
  * @d_cdp: RDT domain that shares hardware with @d (RDT domain peer)
  *         Used to return the result.
+ * @peer_type: The CDP configuration type of the peer resource.
  *
  * RDT resources are managed independently and by extension the RDT domains
  * (RDT resource instances) are managed independently also. The Code and
@@ -1118,7 +1120,8 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
  */
 static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 			    struct rdt_resource **r_cdp,
-			    struct rdt_domain **d_cdp)
+			    struct rdt_domain **d_cdp,
+			    enum resctrl_conf_type *peer_type)
 {
 	struct rdt_resource *_r_cdp = NULL;
 	struct rdt_domain *_d_cdp = NULL;
@@ -1127,15 +1130,19 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 	switch (r->rid) {
 	case RDT_RESOURCE_L3DATA:
 		_r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE].resctrl;
+		*peer_type = CDP_CODE;
 		break;
 	case RDT_RESOURCE_L3CODE:
 		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl;
+		*peer_type = CDP_DATA;
 		break;
 	case RDT_RESOURCE_L2DATA:
 		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2CODE].resctrl;
+		*peer_type = CDP_CODE;
 		break;
 	case RDT_RESOURCE_L2CODE:
 		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl;
+		*peer_type = CDP_DATA;
 		break;
 	default:
 		ret = -ENOENT;
@@ -1186,7 +1193,8 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
  * Return: false if CBM does not overlap, true if it does.
  */
 static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
-				    unsigned long cbm, int closid, bool exclusive)
+				    unsigned long cbm, int closid,
+				    enum resctrl_conf_type type, bool exclusive)
 {
 	enum rdtgrp_mode mode;
 	unsigned long ctrl_b;
@@ -1201,7 +1209,7 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 
 	/* Check for overlap with other resource groups */
 	for (i = 0; i < closids_supported(); i++) {
-		resctrl_arch_get_config(r, d, i, (u32 *)&ctrl_b);
+		resctrl_arch_get_config(r, d, i, type, (u32 *)&ctrl_b);
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
 		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
@@ -1242,17 +1250,19 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d
 bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_domain *d,
 			   unsigned long cbm, int closid, bool exclusive)
 {
+	enum resctrl_conf_type peer_type;
 	struct rdt_resource *r = s->res;
 	struct rdt_resource *r_cdp;
 	struct rdt_domain *d_cdp;
 
-	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, exclusive))
+	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, s->conf_type,
+				    exclusive))
 		return true;
 
-	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) < 0)
+	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp, &peer_type) < 0)
 		return false;
 
-	return  __rdtgroup_cbm_overlaps(r_cdp, d_cdp, cbm, closid, exclusive);
+	return  __rdtgroup_cbm_overlaps(r_cdp, d_cdp, cbm, closid, peer_type, exclusive);
 }
 
 /**
@@ -1282,7 +1292,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
-			resctrl_arch_get_config(r, d, closid, &ctrl);
+			resctrl_arch_get_config(r, d, closid, s->conf_type, &ctrl);
 			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
 				rdt_last_cmd_puts("Schemata overlaps\n");
 				return false;
@@ -1457,7 +1467,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 				size = 0;
 			} else {
 				resctrl_arch_get_config(r, d, rdtgrp->closid,
-							&ctrl);
+							schema->conf_type, &ctrl);
 				if (r->rid == RDT_RESOURCE_MBA)
 					size = ctrl;
 				else
@@ -2756,6 +2766,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	enum resctrl_conf_type t = s-> conf_type;
 	struct rdt_resource *r_cdp = NULL;
 	struct resctrl_staged_config *cfg;
+	enum resctrl_conf_type peer_type;
 	struct rdt_domain *d_cdp = NULL;
 	struct rdt_resource *r = s->res;
 	u32 used_b = 0, unused_b = 0;
@@ -2764,7 +2775,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	enum rdtgrp_mode mode;
 	int i;
 
-	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
+	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp, &peer_type);
 	cfg = &d->staged_config[t];
 	cfg->have_new_ctrl = false;
 	cfg->new_ctrl = r->cache.shareable_bits;
@@ -2785,10 +2796,10 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 			 * with an exclusive group.
 			 */
 			if (d_cdp)
-				resctrl_arch_get_config(r_cdp, d_cdp, i, &peer_ctl);
+				resctrl_arch_get_config(r_cdp, d_cdp, i, peer_type, &peer_ctl);
 			else
 				peer_ctl = 0;
-			resctrl_arch_get_config(r, d, i, &ctrl_val);
+			resctrl_arch_get_config(r, d, i, s->conf_type, &ctrl_val);
 			used_b |= ctrl_val | peer_ctl;
 			if (mode == RDT_MODE_SHAREABLE)
 				cfg->new_ctrl |= ctrl_val | peer_ctl;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b870c2f3c3c9..df670f204abf 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -205,6 +205,7 @@ struct resctrl_schema {
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 int resctrl_arch_update_domains(struct rdt_resource *r);
 void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
-			     u32 closid, u32 *value);
+			     u32 closid, enum resctrl_conf_type type,
+			     u32 *value);
 
 #endif /* _RESCTRL_H */
-- 
2.28.0

