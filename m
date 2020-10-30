Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FE42A0ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgJ3QNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:13:19 -0400
Received: from foss.arm.com ([217.140.110.172]:39260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbgJ3QNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:13:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0E861692;
        Fri, 30 Oct 2020 09:13:15 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBE8C3F719;
        Fri, 30 Oct 2020 09:13:13 -0700 (PDT)
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
Subject: [PATCH 21/24] x86/resctrl: Calculate the index from the configuration type
Date:   Fri, 30 Oct 2020 16:11:17 +0000
Message-Id: <20201030161120.227225-22-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl uses cbm_idx() to map a closid to an index in the
configuration array. This is based on whether this is a CODE,
DATA or BOTH resource.

To merge the resources, resctrl needs to make this decision
based on something else, as there will only be one resource.
Decide based on the staged configuration type. This makes the
static mult and offset parameters set by the arch code redundant.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        | 12 ------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 17 +++++++++++------
 include/linux/resctrl.h                   |  6 ------
 3 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 79b17ece4528..e2f5ea129be2 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -69,8 +69,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 3,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 1,
-				.cbm_idx_offset	= 0,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L3),
 			.parse_ctrlval		= parse_cbm,
@@ -89,8 +87,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 3,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 2,
-				.cbm_idx_offset	= 0,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L3DATA),
 			.parse_ctrlval		= parse_cbm,
@@ -109,8 +105,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 3,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 2,
-				.cbm_idx_offset	= 1,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L3CODE),
 			.parse_ctrlval		= parse_cbm,
@@ -129,8 +123,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 2,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 1,
-				.cbm_idx_offset	= 0,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L2),
 			.parse_ctrlval		= parse_cbm,
@@ -149,8 +141,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 2,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 2,
-				.cbm_idx_offset	= 0,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L2DATA),
 			.parse_ctrlval		= parse_cbm,
@@ -169,8 +159,6 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.cache_level		= 2,
 			.cache = {
 				.min_cbm_bits	= 1,
-				.cbm_idx_mult	= 2,
-				.cbm_idx_offset	= 1,
 			},
 			.domains		= domain_init(RDT_RESOURCE_L2CODE),
 			.parse_ctrlval		= parse_cbm,
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 28a251cf3c60..cb91dcd0f329 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -249,12 +249,17 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	return -EINVAL;
 }
 
-static unsigned int cbm_idx(struct rdt_resource *r, unsigned int closid)
+static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
 {
-	if (r->rid == RDT_RESOURCE_MBA)
+	switch (type) {
+	default:
+	case CDP_BOTH:
 		return closid;
-
-	return closid * r->cache.cbm_idx_mult + r->cache.cbm_idx_offset;
+	case CDP_CODE:
+		return (closid * 2) + 1;
+	case CDP_DATA:
+		return (closid * 2);
+	}
 }
 
 /*
@@ -305,7 +310,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r)
 			if (!cfg->have_new_ctrl)
 				continue;
 
-			idx = cbm_idx(r, cfg->closid);
+			idx = get_config_index(cfg->closid, t);
 			if (!apply_config(hw_dom, cfg, cpu_mask, idx, mba_sc))
 				continue;
 
@@ -440,7 +445,7 @@ void resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 closid, enum resctrl_conf_type type, u32 *value)
 {
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	u32 idx = cbm_idx(r, closid);
+	u32 idx = get_config_index(closid, type);
 
 	if (!is_mba_sc(r))
 		*value = hw_dom->ctrl_val[idx];
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index df670f204abf..e1f390b9ece1 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -76,10 +76,6 @@ struct rdt_domain {
  * struct resctrl_cache - Cache allocation related data
  * @cbm_len:		Length of the cache bit mask
  * @min_cbm_bits:	Minimum number of consecutive bits to be set
- * @cbm_idx_mult:	Multiplier of CBM index
- * @cbm_idx_offset:	Offset of CBM index. CBM index is computed by:
- *			closid * cbm_idx_multi + cbm_idx_offset
- *			in a cache bit mask
  * @shareable_bits:	Bitmask of shareable resource with other
  *			executing entities
  * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
@@ -88,8 +84,6 @@ struct rdt_domain {
 struct resctrl_cache {
 	u32		cbm_len;
 	u32		min_cbm_bits;
-	unsigned int	cbm_idx_mult;	// TODO remove this
-	unsigned int	cbm_idx_offset; // TODO remove this
 	u32		shareable_bits;
 	bool		arch_has_sparse_bitmaps;
 	bool		arch_has_empty_bitmaps;
-- 
2.28.0

