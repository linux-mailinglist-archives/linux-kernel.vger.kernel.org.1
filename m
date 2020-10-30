Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE21A2A0AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgJ3QMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:12:51 -0400
Received: from foss.arm.com ([217.140.110.172]:39104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbgJ3QMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:12:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4D521692;
        Fri, 30 Oct 2020 09:12:49 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80E0B3F719;
        Fri, 30 Oct 2020 09:12:47 -0700 (PDT)
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
Subject: [PATCH 13/24] x86/resctrl: Allow different CODE/DATA configurations to be staged
Date:   Fri, 30 Oct 2020 16:11:09 +0000
Message-Id: <20201030161120.227225-14-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the configuration is staged via an array, allow resctrl to
stage more than configuration at a time for a single resource and
closid.

To detect that the same schema is being specified twice when the schemata
file is written, the same slot in the staged_configuration array must be
used for each schema. Use the conf_type enum directly as an index.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 16 ++++++++++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  5 +++--
 include/linux/resctrl.h                   |  4 +++-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b107c0202cfb..f7152c7fdc1b 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -60,10 +60,11 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d)
 {
-	struct resctrl_staged_config *cfg = &d->staged_config[0];
+	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	unsigned long bw_val;
 
+	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
@@ -131,11 +132,12 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d)
 {
-	struct resctrl_staged_config *cfg = &d->staged_config[0];
 	struct rdtgroup *rdtgrp = data->rdtgrp;
+	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	u32 cbm_val;
 
+	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
@@ -194,6 +196,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
+	enum resctrl_conf_type t = s->conf_type;
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
@@ -225,7 +228,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 			if (r->parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
-				cfg = &d->staged_config[0];
+				cfg = &d->staged_config[t];
 				/*
 				 * In pseudo-locking setup mode and just
 				 * parsed a valid CBM that should be
@@ -266,10 +269,11 @@ int update_domains(struct rdt_resource *r, int closid)
 	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
+	enum resctrl_conf_type t;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	bool mba_sc;
-	int cpu, i;
+	int cpu;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
@@ -281,8 +285,8 @@ int update_domains(struct rdt_resource *r, int closid)
 	mba_sc = is_mba_sc(r);
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
-		for (i = 0; i < ARRAY_SIZE(d->staged_config); i++) {
-			cfg = &hw_dom->resctrl.staged_config[i];
+		for (t = 0; t < ARRAY_SIZE(d->staged_config); t++) {
+			cfg = &hw_dom->resctrl.staged_config[t];
 			if (!cfg->have_new_ctrl)
 				continue;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1092631ac0b3..5eb14dc9c579 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2747,6 +2747,7 @@ static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
 static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
+	enum resctrl_conf_type t = s-> conf_type;
 	struct rdt_resource *r_cdp = NULL;
 	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d_cdp = NULL;
@@ -2758,7 +2759,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	int i;
 
 	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
-	cfg = &d->staged_config[0];
+	cfg = &d->staged_config[t];
 	cfg->have_new_ctrl = false;
 	cfg->new_ctrl = r->cache.shareable_bits;
 	used_b = r->cache.shareable_bits;
@@ -2843,7 +2844,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
 	struct rdt_domain *d;
 
 	list_for_each_entry(d, &r->domains, list) {
-		cfg = &d->staged_config[0];
+		cfg = &d->staged_config[CDP_BOTH];
 		cfg->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
 		cfg->closid = closid;
 		cfg->have_new_ctrl = true;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 695247c08ba3..e33d6dfce8a1 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -25,6 +25,8 @@ enum resctrl_conf_type {
 	CDP_CODE,
 	CDP_DATA,
 };
+#define NUM_CDP_TYPES	CDP_DATA + 1
+
 
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
@@ -67,7 +69,7 @@ struct rdt_domain {
 	int				cqm_work_cpu;
 
 	struct pseudo_lock_region	*plr;
-	struct resctrl_staged_config	staged_config[1];
+	struct resctrl_staged_config	staged_config[NUM_CDP_TYPES];
 };
 
 /**
-- 
2.28.0

