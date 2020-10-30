Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EEC2A0ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgJ3QMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:49 -0400
Received: from foss.arm.com ([217.140.110.172]:39078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbgJ3QMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 865381684;
        Fri, 30 Oct 2020 09:12:46 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2BFE3F719;
        Fri, 30 Oct 2020 09:12:44 -0700 (PDT)
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
Subject: [PATCH 12/24] x86/resctrl: Add closid to the staged config
Date:   Fri, 30 Oct 2020 16:11:08 +0000
Message-Id: <20201030161120.227225-13-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the L2/L2CODE/L2DATA resources are merged, there may be two
configurations staged for one resource when CDP is enabled. The
closid should always be passed with the type of configuration to the
arch code.

Because update_domains() will eventually apply a set of configurations,
it should take the closid from the same place, so they pair up.

Move the closid to be a staged parameter.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  6 ++++--
 include/linux/resctrl.h                   |  2 ++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 0c95ed83eb05..b107c0202cfb 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -72,6 +72,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	if (!bw_validate(data->buf, &bw_val, r))
 		return -EINVAL;
 	cfg->new_ctrl = bw_val;
+	cfg->closid = data->rdtgrp->closid;
 	cfg->have_new_ctrl = true;
 
 	return 0;
@@ -178,6 +179,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	}
 
 	cfg->new_ctrl = cbm_val;
+	cfg->closid = data->rdtgrp->closid;
 	cfg->have_new_ctrl = true;
 
 	return 0;
@@ -245,15 +247,15 @@ static int parse_line(char *line, struct resctrl_schema *s,
 }
 
 static void apply_config(struct rdt_hw_domain *hw_dom,
-			 struct resctrl_staged_config *cfg, int closid,
+			 struct resctrl_staged_config *cfg,
 			 cpumask_var_t cpu_mask, bool mba_sc)
 {
 	struct rdt_domain *dom = &hw_dom->resctrl;
 	u32 *dc = mba_sc ? hw_dom->mbps_val : hw_dom->ctrl_val;
 
-	if (cfg->new_ctrl != dc[closid]) {
+	if (cfg->new_ctrl != dc[cfg->closid]) {
 		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
-		dc[closid] = cfg->new_ctrl;
+		dc[cfg->closid] = cfg->new_ctrl;
 	}
 
 	cfg->have_new_ctrl = false;
@@ -284,7 +286,7 @@ int update_domains(struct rdt_resource *r, int closid)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
+			apply_config(hw_dom, cfg, cpu_mask, mba_sc);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c307170ee45f..1092631ac0b3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2806,6 +2806,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
 		return -ENOSPC;
 	}
+	cfg->closid = closid;
 	cfg->have_new_ctrl = true;
 
 	return 0;
@@ -2836,7 +2837,7 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
 }
 
 /* Initialize MBA resource with default values. */
-static void rdtgroup_init_mba(struct rdt_resource *r)
+static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 {
 	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d;
@@ -2844,6 +2845,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r)
 	list_for_each_entry(d, &r->domains, list) {
 		cfg = &d->staged_config[0];
 		cfg->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
+		cfg->closid = closid;
 		cfg->have_new_ctrl = true;
 	}
 }
@@ -2860,7 +2862,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 	list_for_each_entry(s, &resctrl_all_schema, list) {
 		r = s->res;
 		if (r->rid == RDT_RESOURCE_MBA) {
-			rdtgroup_init_mba(r);
+			rdtgroup_init_mba(r, rdtgrp->closid);
 		} else {
 			ret = rdtgroup_init_cat(s, rdtgrp->closid);
 			if (ret < 0)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f1164bbb66c5..695247c08ba3 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -28,10 +28,12 @@ enum resctrl_conf_type {
 
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
+ * @closid:		The closid the new configuration applies to
  * @new_ctrl:		new ctrl value to be loaded
  * @have_new_ctrl:	did user provide new_ctrl for this domain
  */
 struct resctrl_staged_config {
+	u32			closid;
 	u32			new_ctrl;
 	bool			have_new_ctrl;
 };
-- 
2.28.0

