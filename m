Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C482854BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgJFWrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:47:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:58474 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgJFWrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:47:18 -0400
IronPort-SDR: wNCz154szjNVDKiQUQ9CIT7mDF7e7evG8TbdzgaaPK51Mh91wcEMj4IiKdUZYkMYAbfp+P3Kl8
 5+tbb4M5m2Hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="226322927"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="226322927"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 15:47:17 -0700
IronPort-SDR: 3sidEY//M1dtiOu8MwKCSJwQvIYBKzUQuw5FUioIVu1prv3BENgdxh4DCixZ3tMSOPtkMxlrpZ
 pIL2Ke30rKgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="388105342"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 06 Oct 2020 15:47:17 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 39EF358087A;
        Tue,  6 Oct 2020 15:47:17 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org, gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH 3/3] platform/x86: intel_pmc_core: Fix the slp_s0 counter displayed value
Date:   Tue,  6 Oct 2020 15:47:02 -0700
Message-Id: <20201006224702.12697-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201006224702.12697-1-david.e.box@linux.intel.com>
References: <20201006224702.12697-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

slp_s0 counter value displayed via debugfs interface is calculated by
multiplying the granularity for crystal oscillator tick as 100us with
the value read from using slp_s0 offset. But the granularity of the tick
varies from platform to platform and it needs to be fixed.

Hence, specify granularity of the tick for each platform, so that the
value of the slp_s0 counter is accurate.

Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 10 +++++++---
 drivers/platform/x86/intel_pmc_core.h |  5 ++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index cf4006e08c69..122eb53eb595 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -154,6 +154,7 @@ static const struct pmc_reg_map spt_reg_map = {
 	.ltr_show_sts = spt_ltr_show_map,
 	.msr_sts = msr_map,
 	.slp_s0_offset = SPT_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slp_s0_res_counter_step = SPT_PMC_SLP_S0_RES_COUNTER_STEP,
 	.ltr_ignore_offset = SPT_PMC_LTR_IGNORE_OFFSET,
 	.regmap_length = SPT_PMC_MMIO_REG_LEN,
 	.ppfear0_offset = SPT_PMC_XRAM_PPFEAR0A,
@@ -380,6 +381,7 @@ static const struct pmc_bit_map cnp_ltr_show_map[] = {
 static const struct pmc_reg_map cnp_reg_map = {
 	.pfear_sts = ext_cnp_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slp_s0_res_counter_step = SPT_PMC_SLP_S0_RES_COUNTER_STEP,
 	.slps0_dbg_maps = cnp_slps0_dbg_maps,
 	.ltr_show_sts = cnp_ltr_show_map,
 	.msr_sts = msr_map,
@@ -396,6 +398,7 @@ static const struct pmc_reg_map cnp_reg_map = {
 static const struct pmc_reg_map icl_reg_map = {
 	.pfear_sts = ext_icl_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slp_s0_res_counter_step = ICL_PMC_SLP_S0_RES_COUNTER_STEP,
 	.slps0_dbg_maps = cnp_slps0_dbg_maps,
 	.ltr_show_sts = cnp_ltr_show_map,
 	.msr_sts = msr_map,
@@ -558,6 +561,7 @@ static const struct pmc_bit_map *tgl_lpm_maps[] = {
 static const struct pmc_reg_map tgl_reg_map = {
 	.pfear_sts = ext_tgl_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slp_s0_res_counter_step = TGL_PMC_SLP_S0_RES_COUNTER_STEP,
 	.ltr_show_sts = cnp_ltr_show_map,
 	.msr_sts = msr_map,
 	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
@@ -586,9 +590,9 @@ static inline void pmc_core_reg_write(struct pmc_dev *pmcdev, int reg_offset,
 	writel(val, pmcdev->regbase + reg_offset);
 }
 
-static inline u64 pmc_core_adjust_slp_s0_step(u32 value)
+static inline u64 pmc_core_adjust_slp_s0_step(struct pmc_dev *pmcdev, u32 value)
 {
-	return (u64)value * SPT_PMC_SLP_S0_RES_COUNTER_STEP;
+	return (u64)value * pmcdev->map->slp_s0_res_counter_step;
 }
 
 static int pmc_core_dev_state_get(void *data, u64 *val)
@@ -598,7 +602,7 @@ static int pmc_core_dev_state_get(void *data, u64 *val)
 	u32 value;
 
 	value = pmc_core_reg_read(pmcdev, map->slp_s0_offset);
-	*val = pmc_core_adjust_slp_s0_step(value);
+	*val = pmc_core_adjust_slp_s0_step(pmcdev, value);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 5eae55d80226..f33cd2c34835 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -30,7 +30,7 @@
 #define SPT_PMC_MPHY_CORE_STS_1			0x1142
 #define SPT_PMC_MPHY_COM_STS_0			0x1155
 #define SPT_PMC_MMIO_REG_LEN			0x1000
-#define SPT_PMC_SLP_S0_RES_COUNTER_STEP		0x64
+#define SPT_PMC_SLP_S0_RES_COUNTER_STEP		0x68
 #define PMC_BASE_ADDR_MASK			~(SPT_PMC_MMIO_REG_LEN - 1)
 #define MTPMC_MASK				0xffff0000
 #define PPFEAR_MAX_NUM_ENTRIES			12
@@ -185,8 +185,10 @@ enum ppfear_regs {
 #define ICL_PPFEAR_NUM_ENTRIES			9
 #define ICL_NUM_IP_IGN_ALLOWED			20
 #define ICL_PMC_LTR_WIGIG			0x1BFC
+#define ICL_PMC_SLP_S0_RES_COUNTER_STEP		0x64
 
 #define TGL_NUM_IP_IGN_ALLOWED			22
+#define TGL_PMC_SLP_S0_RES_COUNTER_STEP		0x7A
 
 /*
  * Tigerlake Power Management Controller register offsets
@@ -245,6 +247,7 @@ struct pmc_reg_map {
 	const struct pmc_bit_map *msr_sts;
 	const struct pmc_bit_map **lpm_sts;
 	const u32 slp_s0_offset;
+	const int slp_s0_res_counter_step;
 	const u32 ltr_ignore_offset;
 	const int regmap_length;
 	const u32 ppfear0_offset;
-- 
2.20.1

