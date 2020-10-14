Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7337528D7B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388253AbgJNAtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:49:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:7196 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgJNAth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:49:37 -0400
IronPort-SDR: dJf3zgjsrO5Pvz9WiJwbESqZ60Dr8pugvGG6IK/otTMMOhoTtw3606SbSQN/cfzDtPU0TH4eZo
 FaEG0RBTnUxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="183507733"
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="183507733"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 17:49:35 -0700
IronPort-SDR: SZoF7yrFBIFbw+gEL8Yi93aB8VFSSLCNd/gkab2kJfm3RpywAD8zWNMR1FsS/4EF2vEDWQ9l+E
 F70Hf5vPTOog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="390492558"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga001.jf.intel.com with ESMTP; 13 Oct 2020 17:49:34 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Stephane Eranian" <eranian@google.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 2/2] x86/resctrl: Correct MBM total and local values
Date:   Wed, 14 Oct 2020 00:49:27 +0000
Message-Id: <20201014004927.1839452-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014004927.1839452-1-fenghua.yu@intel.com>
References: <20201014004927.1839452-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Memory Bandwidth Monitoring (MBM) counters may report system
memory bandwidth incorrectly on some Intel processors. The errata
SKX99 for Skylake server, BDF102 for Broadwell server, and the
correction factor table are documented in Documentation/x86/resctrl.rst.

Intel MBM counters track metrics according to the assigned Resource
Monitor ID (RMID) for that logical core. The IA32_QM_CTR register
(MSR 0xC8E), used to report these metrics, may report incorrect system
bandwidth for certain RMID values.

Due to the errata, system memory bandwidth may not match what is reported.

To work around the errata, MBM total and local readings are corrected
using the correction factor table. If rmid > rmid threshold, MBM total
and local values should be multiplied by the correction factor.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
Change Log:
v2:
- Add "const" for mbm_cf_table[] (Boris).
- Add verbs to corrected_mbm_counter() and intel_rdt_mbm_quirk() (Boris).
- Describe the errata in the commit message (Boris).
- Fix checkpatch.pl warning on "/* FALLTHROUGH */" (Boris).

 arch/x86/kernel/cpu/resctrl/core.c     |  4 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 82 +++++++++++++++++++++++++-
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9e1712e8aef7..b3bdc477599e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -893,6 +893,10 @@ static __init void __check_quirks_intel(void)
 			set_rdt_options("!cmt,!mbmtotal,!mbmlocal,!l3cat");
 		else
 			set_rdt_options("!l3cat");
+		fallthrough;
+	case INTEL_FAM6_BROADWELL_X:
+		intel_rdt_mbm_apply_quirk();
+		break;
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 80fa997fae60..6cb068fcf501 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -616,6 +616,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
+void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
 void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
 u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 54dffe574e67..8b45085d02fb 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -64,6 +64,69 @@ unsigned int rdt_mon_features;
  */
 unsigned int resctrl_cqm_threshold;
 
+#define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
+
+/*
+ * The correction factor table is documented in Documentation/x86/resctrl.rst.
+ * If rmid > rmid threshold, MBM total and local values should be multiplied
+ * by the correction factor.
+ *
+ * The original table is modified for better code:
+ *
+ * 1. The threshold 0 is changed to rmid count - 1 so don't do correction
+ *    for the case.
+ * 2. MBM total and local correction table indexed by core counter which is
+ *    equal to (x86_cache_max_rmid + 1) / 8 - 1 and is from 0 up to 27.
+ * 3. The correction factor is normalized to 2^20 (1048576) so it's faster
+ *    to calculate corrected value by shifting:
+ *    corrected_value = (original_value * correction_factor) >> 20
+ */
+static const struct mbm_correction_factor_table {
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
+static u32 mbm_cf_rmidthreshold __read_mostly = UINT_MAX;
+static u64 mbm_cf __read_mostly;
+
+static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
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
@@ -260,7 +323,8 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	m->chunks += chunks;
 	m->prev_msr = tval;
 
-	rr->val += m->chunks;
+	rr->val += get_corrected_mbm_count(rmid, m->chunks);
+
 	return 0;
 }
 
@@ -280,7 +344,7 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 
 	chunks = mbm_overflow_count(m->prev_bw_msr, tval, rr->r->mbm_width);
 	m->chunks += chunks;
-	cur_bw = (chunks * r->mon_scale) >> 20;
+	cur_bw = (get_corrected_mbm_count(rmid, chunks) * r->mon_scale) >> 20;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
@@ -644,3 +708,17 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 
 	return 0;
 }
+
+void __init intel_rdt_mbm_apply_quirk(void)
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

