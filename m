Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4498B27B7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgI1XQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:16:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:56352 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgI1XQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:16:33 -0400
IronPort-SDR: nGtQfmwvIhneIg2FGjPor2hBP5eEfB2oyZaYzy+WIp7ahB8w5p5CZKBf8n05AipfbKPhvmf2DQ
 jVxBz5NTvDCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="162952336"
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="162952336"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 15:13:14 -0700
IronPort-SDR: bjz0fqMt0PI9UcjIMl30gEmndPXor7VY6jZSh6UeUPeuDJ68IN7td6g0j3DCWHRyQUR6yPLzQn
 IIsRfZl0/5WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,315,1596524400"; 
   d="scan'208";a="513613064"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2020 15:13:14 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Stephane Eranian" <eranian@google.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] x86/resctrl: Correct MBM total and local values
Date:   Mon, 28 Sep 2020 15:12:53 -0700
Message-Id: <1601331173-185230-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MBM total and local readings are corrected by the following correction
factor table on Broadwell server and Skylake server.

core		rmid		rmid			correction
count		count		threshold		factor
1		8		0			1.000000
2		16		0			1.000000
3		24		15			0.969650
4		32		0			1.000000
5		40		31			1.066667
6		48		31			0.969650
7		56		47			1.142857
8		64		0			1.000000
9		72		63			1.185115
10		80		63			1.066553
11		88		79			1.454545
12		96		0			1.000000
13		104		95			1.230769
14		112		95			1.142857
15		120		95			1.066667
16		128		0			1.000000
17		136		127			1.254863
18		144		127			1.185255
19		152		0			1.000000
20		160		127			1.066667
21		168		0			1.000000
22		176		159			1.454334
23		184		0			1.000000
24		192		127			0.969744
25		200		191			1.280246
26		208		191			1.230921
27		216		0			1.000000
28		224		191			1.143118

If rmid > rmid threshold, MBM total and local values should be multipled
by the correction factor.

The above table is modified for better code:
1. The threshold 0 is changed to rmid count - 1 so we don't do correction
   for the case.
2. Correction factor is normalized to 2^20 for better performance
   by avoiding floating point and division calculation in corrected
   MBM values.

Detailed information about the correction is described in erratum SKX99:
https://www.intel.com/content/www/us/en/processors/xeon/scalable/xeon-scalable-spec-update.html
and BDF102: https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-e5-v4-spec-update.pdf

The problem is described in details in "3.6 Intel MBM RMID Imbalance":
https://software.intel.com/content/www/us/en/develop/articles/intel-resource-director-technology-rdt-reference-manual.html

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---

Applied to tip:x86/cache.

 arch/x86/kernel/cpu/resctrl/core.c     |  4 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 75 +++++++++++++++++++++++++-
 3 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9e1712e8aef7..efe3ed61ae0c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -893,6 +893,10 @@ static __init void __check_quirks_intel(void)
 			set_rdt_options("!cmt,!mbmtotal,!mbmlocal,!l3cat");
 		else
 			set_rdt_options("!l3cat");
+		/* FALLTHROUGH */
+	case INTEL_FAM6_BROADWELL_X:
+		intel_rdt_mbm_quirk();
+		break;
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 80fa997fae60..0be0232ac03a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -616,6 +616,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
+void intel_rdt_mbm_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
 void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
 u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 54dffe574e67..05e06744e4b1 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 #include "internal.h"
 
 struct rmid_entry {
@@ -64,6 +65,61 @@ unsigned int rdt_mon_features;
  */
 unsigned int resctrl_cqm_threshold;
 
+#define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
+
+/*
+ * MBM total and local correction table indexed by CBO which is equal to
+ * (x86_cache_max_rmid + 1) / 8 - 1 and is from 0 up to 27.
+ * The correction factor is normalized to 2^20 (1048576) so it's faster
+ * to calculate corrected value by shifting:
+ * corrected_value = (original_value * correction_factor) >> 20
+ */
+static struct mbm_creation_factor_table {
+	u32 rmidthreshold;
+	u64 cf;
+} mbm_cf_table[] = {
+	{7,	CF(1.000000)},
+	{15,	CF(1.000000)},
+	{15,	CF(0.969650)},
+	{31,	CF(1.000000)},
+	{31,	CF(1.066667)},
+	{31,	CF(0.969650)},
+	{47,	CF(1.142857)},
+	{63,	CF(1.000000)},
+	{63,	CF(1.185115)},
+	{63,	CF(1.066553)},
+	{79,	CF(1.454545)},
+	{95,	CF(1.000000)},
+	{95,	CF(1.230769)},
+	{95,	CF(1.142857)},
+	{95,	CF(1.066667)},
+	{127,	CF(1.000000)},
+	{127,	CF(1.254863)},
+	{127,	CF(1.185255)},
+	{151,	CF(1.000000)},
+	{127,	CF(1.066667)},
+	{167,	CF(1.000000)},
+	{159,	CF(1.454334)},
+	{183,	CF(1.000000)},
+	{127,	CF(0.969744)},
+	{191,	CF(1.280246)},
+	{191,	CF(1.230921)},
+	{215,	CF(1.000000)},
+	{191,	CF(1.143118)},
+};
+
+static u32 mbm_cf_rmidthreshold = UINT_MAX;
+static u64 mbm_cf;
+
+static inline u64 corrected_mbm_count(u32 rmid, unsigned long val)
+{
+	/* Correct MBM value. */
+	if (rmid > mbm_cf_rmidthreshold)
+		val = (val * mbm_cf) >> 20;
+
+	return val;
+}
+
 static inline struct rmid_entry *__rmid_entry(u32 rmid)
 {
 	struct rmid_entry *entry;
@@ -260,7 +316,8 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	m->chunks += chunks;
 	m->prev_msr = tval;
 
-	rr->val += m->chunks;
+	rr->val += corrected_mbm_count(rmid, m->chunks);
+
 	return 0;
 }
 
@@ -280,7 +337,7 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 
 	chunks = mbm_overflow_count(m->prev_bw_msr, tval, rr->r->mbm_width);
 	m->chunks += chunks;
-	cur_bw = (chunks * r->mon_scale) >> 20;
+	cur_bw = (corrected_mbm_count(rmid, chunks) * r->mon_scale) >> 20;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
@@ -644,3 +701,17 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 
 	return 0;
 }
+
+void intel_rdt_mbm_quirk(void)
+{
+	int cf_index;
+
+	cf_index = (boot_cpu_data.x86_cache_max_rmid + 1) / 8 - 1;
+	if (cf_index >= ARRAY_SIZE(mbm_cf_table)) {
+		pr_info("No MBM correction factor available\n");
+		return;
+	}
+
+	mbm_cf_rmidthreshold = mbm_cf_table[cf_index].rmidthreshold;
+	mbm_cf = mbm_cf_table[cf_index].cf;
+}
-- 
2.28.0

