Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F23F2A0ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgJ3QN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:13:28 -0400
Received: from foss.arm.com ([217.140.110.172]:39322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbgJ3QNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:13:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0A9B1684;
        Fri, 30 Oct 2020 09:13:24 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BE723F719;
        Fri, 30 Oct 2020 09:13:22 -0700 (PDT)
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
Subject: [PATCH 24/24] x86/resctrl: Merge the CDP resources
Date:   Fri, 30 Oct 2020 16:11:20 +0000
Message-Id: <20201030161120.227225-25-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that resctrl uses the schema's configuration type as the source of
CODE/DATA configuration styles, and there is only one configuration
array between the three views of the resource, remove the CODE and DATA
aliases.

This means the arch code only needs to describe the hardware to
resctrl, which will then create the separate CODE/DATA schema
for its ABI.

Add a helper to add schema with a the CDP suffix if CDP is enabled.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 193 ++-----------------------
 arch/x86/kernel/cpu/resctrl/internal.h |   4 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 113 ++++++++-------
 3 files changed, 72 insertions(+), 238 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 01d010977367..57d4131fdd80 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -78,42 +78,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.msr_base		= MSR_IA32_L3_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
-	[RDT_RESOURCE_L3DATA] =
-	{
-		.conf_type			= CDP_DATA,
-		.resctrl = {
-			.rid			= RDT_RESOURCE_L3DATA,
-			.name			= "L3DATA",
-			.cache_level		= 3,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
-			.domains		= domain_init(RDT_RESOURCE_L3DATA),
-			.parse_ctrlval		= parse_cbm,
-			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
-		},
-		.msr_base		= MSR_IA32_L3_CBM_BASE,
-		.msr_update		= cat_wrmsr,
-	},
-	[RDT_RESOURCE_L3CODE] =
-	{
-		.conf_type			= CDP_CODE,
-		.resctrl = {
-			.rid			= RDT_RESOURCE_L3CODE,
-			.name			= "L3CODE",
-			.cache_level		= 3,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
-			.domains		= domain_init(RDT_RESOURCE_L3CODE),
-			.parse_ctrlval		= parse_cbm,
-			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
-		},
-		.msr_base		= MSR_IA32_L3_CBM_BASE,
-		.msr_update		= cat_wrmsr,
-	},
 	[RDT_RESOURCE_L2] =
 	{
 		.conf_type			= CDP_BOTH,
@@ -132,42 +96,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 		.msr_base		= MSR_IA32_L2_CBM_BASE,
 		.msr_update		= cat_wrmsr,
 	},
-	[RDT_RESOURCE_L2DATA] =
-	{
-		.conf_type			= CDP_DATA,
-		.resctrl = {
-			.rid			= RDT_RESOURCE_L2DATA,
-			.name			= "L2DATA",
-			.cache_level		= 2,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
-			.domains		= domain_init(RDT_RESOURCE_L2DATA),
-			.parse_ctrlval		= parse_cbm,
-			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
-		},
-		.msr_base		= MSR_IA32_L2_CBM_BASE,
-		.msr_update		= cat_wrmsr,
-	},
-	[RDT_RESOURCE_L2CODE] =
-	{
-		.conf_type			= CDP_CODE,
-		.resctrl = {
-			.rid			= RDT_RESOURCE_L2CODE,
-			.name			= "L2CODE",
-			.cache_level		= 2,
-			.cache = {
-				.min_cbm_bits	= 1,
-			},
-			.domains		= domain_init(RDT_RESOURCE_L2CODE),
-			.parse_ctrlval		= parse_cbm,
-			.format_str		= "%d=%0*x",
-			.fflags			= RFTYPE_RES_CACHE,
-		},
-		.msr_base		= MSR_IA32_L2_CBM_BASE,
-		.msr_update		= cat_wrmsr,
-	},
 	[RDT_RESOURCE_MBA] =
 	{
 		.conf_type			= CDP_BOTH,
@@ -339,40 +267,16 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->alloc_enabled = true;
 }
 
-static void rdt_get_cdp_config(int level, int type)
-{
-	struct rdt_resource *r_l = &rdt_resources_all[level].resctrl;
-	struct rdt_hw_resource *hw_res_l = resctrl_to_arch_res(r_l);
-	struct rdt_resource *r = &rdt_resources_all[type].resctrl;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-
-	hw_res->num_closid = hw_res_l->num_closid;
-	r->cache.cbm_len = r_l->cache.cbm_len;
-	r->default_ctrl = r_l->default_ctrl;
-	r->cache.shareable_bits = r_l->cache.shareable_bits;
-	r->data_width = (r->cache.cbm_len + 3) / 4;
-	r->alloc_capable = true;
-	hw_res_l->cdp_capable = true;
-	hw_res->cdp_capable = true;
-	/*
-	 * By default, CDP is disabled. CDP can be enabled by mount parameter
-	 * "cdp" during resctrl file system mount time.
-	 */
-	r->alloc_enabled = false;
-	hw_res_l->cdp_enabled = false;
-	hw_res->cdp_enabled = false;
-}
-
 static void rdt_get_cdp_l3_config(void)
 {
-	rdt_get_cdp_config(RDT_RESOURCE_L3, RDT_RESOURCE_L3DATA);
-	rdt_get_cdp_config(RDT_RESOURCE_L3, RDT_RESOURCE_L3CODE);
+	rdt_resources_all[RDT_RESOURCE_L3].cdp_capable = true;
+	rdt_resources_all[RDT_RESOURCE_L3].cdp_enabled = false;
 }
 
 static void rdt_get_cdp_l2_config(void)
 {
-	rdt_get_cdp_config(RDT_RESOURCE_L2, RDT_RESOURCE_L2DATA);
-	rdt_get_cdp_config(RDT_RESOURCE_L2, RDT_RESOURCE_L2CODE);
+	rdt_resources_all[RDT_RESOURCE_L2].cdp_capable = true;
+	rdt_resources_all[RDT_RESOURCE_L2].cdp_enabled = false;
 }
 
 static void
@@ -509,72 +413,6 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 	}
 }
 
-/*
- * temporary.
- * This relies on L2 or L3 being allocated before their CODE/DATA aliases
- */
-static u32 *alloc_ctrlval_array(struct rdt_resource *r, struct rdt_domain *d,
-				bool mba_sc)
-{
-	/* these are for the underlying hardware, they may not match r/d */
-	struct rdt_domain *underlying_domain;
-	struct rdt_hw_resource *hw_res;
-	struct rdt_hw_domain *hw_dom;
-	bool remapped;
-
-	switch (r->rid) {
-	case RDT_RESOURCE_L3DATA:
-	case RDT_RESOURCE_L3CODE:
-		hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
-		remapped = true;
-		break;
-	case RDT_RESOURCE_L2DATA:
-	case RDT_RESOURCE_L2CODE:
-		hw_res = &rdt_resources_all[RDT_RESOURCE_L2];
-		remapped = true;
-		break;
-	default:
-		hw_res = resctrl_to_arch_res(r);
-		remapped = false;
-	}
-
-	/*
-	 * If we changed the resource, we need to search for the underlying
-	 * domain. Doing this for all resources would make it tricky to add the
-	 * first resource, as domains aren't added to a resource list until
-	 * after the ctrlval arrays have been allocated.
-	 */
-	if (remapped)
-		underlying_domain = rdt_find_domain(&hw_res->resctrl, d->id,
-						    NULL);
-	else
-		underlying_domain = d;
-	hw_dom = resctrl_to_arch_dom(underlying_domain);
-
-	if (mba_sc) {
-		if (hw_dom->mbps_val)
-			return hw_dom->mbps_val;
-		return kmalloc_array(hw_res->num_closid,
-				     sizeof(*hw_dom->mbps_val), GFP_KERNEL);
-	} else {
-		if (hw_dom->ctrl_val)
-			return hw_dom->ctrl_val;
-		return kmalloc_array(hw_res->num_closid,
-				     sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
-	}
-}
-
-/* Only kfree() for L2/L3, not the CODE/DATA aliases */
-static void free_ctrlval_arrays(struct rdt_resource *r, struct rdt_domain *d)
-{
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-
-	if (r->rid == RDT_RESOURCE_L2 || r->rid == RDT_RESOURCE_L3) {
-		kfree(hw_dom->ctrl_val);
-		kfree(hw_dom->mbps_val);
-	}
-}
-
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
@@ -582,14 +420,16 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	struct msr_param m;
 	u32 *dc, *dm;
 
-	dc = alloc_ctrlval_array(r, d, false);
+	dc = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->ctrl_val),
+			   GFP_KERNEL);
 	if (!dc)
 		return -ENOMEM;
 	hw_dom->ctrl_val = dc;
 
-	dm = alloc_ctrlval_array(r, d, true);
+	dm = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->mbps_val),
+			   GFP_KERNEL);
 	if (!dm) {
-		free_ctrlval_arrays(r, d);
+		kfree(dc);
 		return -ENOMEM;
 	}
 	hw_dom->mbps_val = dm;
@@ -743,7 +583,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		if (d->plr)
 			d->plr->d = NULL;
 
-		free_ctrlval_arrays(r, d);
+		kfree(hw_dom->ctrl_val);
+		kfree(hw_dom->mbps_val);
 		bitmap_free(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
@@ -1014,11 +855,7 @@ static __init void rdt_init_res_defs_intel(void)
 		r = &rdt_resources_all[i].resctrl;
 
 		if (r->rid == RDT_RESOURCE_L3 ||
-		    r->rid == RDT_RESOURCE_L3DATA ||
-		    r->rid == RDT_RESOURCE_L3CODE ||
-		    r->rid == RDT_RESOURCE_L2 ||
-		    r->rid == RDT_RESOURCE_L2DATA ||
-		    r->rid == RDT_RESOURCE_L2CODE) {
+		    r->rid == RDT_RESOURCE_L2) {
 			r->cache.arch_has_sparse_bitmaps = false;
 			r->cache.arch_has_empty_bitmaps = false;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
@@ -1039,11 +876,7 @@ static __init void rdt_init_res_defs_amd(void)
 		r = &rdt_resources_all[i].resctrl;
 
 		if (r->rid == RDT_RESOURCE_L3 ||
-		    r->rid == RDT_RESOURCE_L3DATA ||
-		    r->rid == RDT_RESOURCE_L3CODE ||
-		    r->rid == RDT_RESOURCE_L2 ||
-		    r->rid == RDT_RESOURCE_L2DATA ||
-		    r->rid == RDT_RESOURCE_L2CODE) {
+		    r->rid == RDT_RESOURCE_L2) {
 			r->cache.arch_has_sparse_bitmaps = true;
 			r->cache.arch_has_empty_bitmaps = true;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f039fd9f4f4f..4f04c9cac6f5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -403,11 +403,7 @@ extern struct dentry *debugfs_resctrl;
 
 enum resctrl_res_level {
 	RDT_RESOURCE_L3,
-	RDT_RESOURCE_L3DATA,
-	RDT_RESOURCE_L3CODE,
 	RDT_RESOURCE_L2,
-	RDT_RESOURCE_L2DATA,
-	RDT_RESOURCE_L2CODE,
 	RDT_RESOURCE_MBA,
 
 	/* Must be the last */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0d561679f7e8..91ab4f4cc7cf 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1891,10 +1891,10 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 	if (!hw_res->cdp_capable)
 		return;
 
-	if (r == &rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl)
+	if (r->rid == RDT_RESOURCE_L2)
 		l2_qos_cfg_update(&hw_res->cdp_enabled);
 
-	if (r == &rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl)
+	if (r->rid == RDT_RESOURCE_L3)
 		l3_qos_cfg_update(&hw_res->cdp_enabled);
 }
 
@@ -1923,68 +1923,42 @@ static int set_mba_sc(bool mba_sc)
 	return 0;
 }
 
-static int cdp_enable(int level, int data_type, int code_type)
+static int cdp_enable(int level)
 {
-	struct rdt_resource *r_ldata = &rdt_resources_all[data_type].resctrl;
-	struct rdt_resource *r_lcode = &rdt_resources_all[code_type].resctrl;
 	struct rdt_resource *r_l = &rdt_resources_all[level].resctrl;
 	int ret;
 
-	if (!r_l->alloc_capable || !r_ldata->alloc_capable ||
-	    !r_lcode->alloc_capable)
+	if (!r_l->alloc_capable)
 		return -EINVAL;
 
 	ret = set_cache_qos_cfg(level, true);
-	if (!ret) {
-		r_l->alloc_enabled = false;
-		r_ldata->alloc_enabled = true;
-		r_lcode->alloc_enabled = true;
+	if (!ret)
 		rdt_resources_all[level].cdp_enabled = true;
-		rdt_resources_all[data_type].cdp_enabled = true;
-		rdt_resources_all[code_type].cdp_enabled = true;
-	}
+
 	return ret;
 }
 
-static void cdp_disable(int level, int data_type, int code_type)
+static void cdp_disable(int level)
 {
 	struct rdt_hw_resource *r_hw = &rdt_resources_all[level];
-	struct rdt_resource *r = &r_hw->resctrl;
-
-	r->alloc_enabled = r->alloc_capable;
 
 	if (r_hw->cdp_enabled) {
-		rdt_resources_all[data_type].resctrl.alloc_enabled = false;
-		rdt_resources_all[code_type].resctrl.alloc_enabled = false;
 		set_cache_qos_cfg(level, false);
 		r_hw->cdp_enabled = false;
-		rdt_resources_all[data_type].cdp_enabled = false;
-		rdt_resources_all[code_type].cdp_enabled = false;
 	}
 }
 
 int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 {
 	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
-	enum resctrl_res_level code_type, data_type;
 
 	if (!hw_res->cdp_capable)
 		return -EINVAL;
 
-	if (l == RDT_RESOURCE_L3) {
-		code_type = RDT_RESOURCE_L3CODE;
-		data_type = RDT_RESOURCE_L3DATA;
-	} else if (l == RDT_RESOURCE_L2) {
-		code_type = RDT_RESOURCE_L2CODE;
-		data_type = RDT_RESOURCE_L2DATA;
-	} else {
-		return -EINVAL;
-	}
-
 	if (enable)
-		return cdp_enable(l, data_type, code_type);
+		return cdp_enable(l);
 
-	cdp_disable(l, data_type, code_type);
+	cdp_disable(l);
 
 	return 0;
 }
@@ -2084,37 +2058,68 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 	return ret;
 }
 
-static int create_schemata_list(void)
+static int add_schema(struct rdt_resource *r, enum resctrl_conf_type type)
 {
 	struct resctrl_schema *s;
-	struct rdt_resource *r;
+	const char *suffix = "";
 	int ret;
 
-	for_each_alloc_enabled_rdt_resource(r) {
-		s = kzalloc(sizeof(*s), GFP_KERNEL);
-		if (!s)
-			return -ENOMEM;
-
-		s->res = r;
-		s->num_closid = resctrl_arch_get_num_closid(r);
-		if (resctrl_arch_get_cdp_enabled(r->rid))
-			s->num_closid /= 2;
+	s = kzalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
 
-		s->conf_type = resctrl_to_arch_res(r)->conf_type;
+	s->res = r;
+	s->num_closid = resctrl_arch_get_num_closid(r);
+	if (resctrl_arch_get_cdp_enabled(r->rid))
+		s->num_closid /= 2;
 
-		ret = snprintf(s->name, sizeof(s->name), r->name);
-		if (ret >= sizeof(s->name)) {
-			kfree(s);
-			return -EINVAL;
-		}
+	s->conf_type = type;
+	switch (type) {
+	case CDP_CODE:
+		suffix = "CODE";
+		break;
+	case CDP_DATA:
+		suffix = "DATA";
+		break;
+	case CDP_BOTH:
+		suffix = "";
+		break;
+	}
 
-		INIT_LIST_HEAD(&s->list);
-		list_add(&s->list, &resctrl_all_schema);
+	ret = snprintf(s->name, sizeof(s->name), "%s%s", r->name, suffix);
+	if (ret >= sizeof(s->name)) {
+		kfree(s);
+		return -EINVAL;
 	}
 
+	INIT_LIST_HEAD(&s->list);
+	list_add(&s->list, &resctrl_all_schema);
+
 	return 0;
 }
 
+static int create_schemata_list(void)
+{
+	struct rdt_resource *r;
+	int ret = 0;
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		if (resctrl_arch_get_cdp_enabled(r->rid)) {
+			ret = add_schema(r, CDP_CODE);
+			if (ret)
+				break;
+
+			ret = add_schema(r, CDP_DATA);
+		} else
+			ret = add_schema(r, CDP_BOTH);
+
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static void destroy_schemata_list(void)
 {
 	struct resctrl_schema *s, *tmp;
-- 
2.28.0

