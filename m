Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A7E213A5A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGCMxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 08:53:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:25746 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgGCMxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:48 -0400
IronPort-SDR: uPOUoASFeXXsxz7SE0YPOXcKKTBlhmc20aT9gkt5iEDUCQA0v5YLc1r0+JSPg0DufNDptsZiQ5
 xgRqhmLqYaJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598398"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598398"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:46 -0700
IronPort-SDR: yBfQNpR6vhRowvKj6z9pbPtB1jKlec3YYQGk0wIfoxBzZayNw3W/beu3LMnFNGsLhBNpHQ0ouH
 VbmyaX/QsEKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265964035"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:45 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 17/23] perf/x86/intel/lbr: Create kmem_cache for the LBR context data
Date:   Fri,  3 Jul 2020 05:49:23 -0700
Message-Id: <1593780569-62993-18-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A new kmem_cache method is introduced to allocate the PMU specific data
task_ctx_data, which requires the PMU specific code to create a
kmem_cache.

Currently, the task_ctx_data is only used by the Intel LBR call stack
feature, which is introduced since Haswell. The kmem_cache should be
only created for Haswell and later platforms. There is no alignment
requirement for the existing platforms.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index bb42e4d..4fb1be4 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1532,9 +1532,17 @@ void __init intel_pmu_lbr_init_snb(void)
 	 */
 }
 
+static inline struct kmem_cache *
+create_lbr_kmem_cache(size_t size, size_t align)
+{
+	return kmem_cache_create("x86_lbr", size, align, 0, NULL);
+}
+
 /* haswell */
 void intel_pmu_lbr_init_hsw(void)
 {
+	size_t size = sizeof(struct x86_perf_task_context);
+
 	x86_pmu.lbr_nr	 = 16;
 	x86_pmu.lbr_tos	 = MSR_LBR_TOS;
 	x86_pmu.lbr_from = MSR_LBR_NHM_FROM;
@@ -1543,6 +1551,8 @@ void intel_pmu_lbr_init_hsw(void)
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
 
+	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
+
 	if (lbr_from_signext_quirk_needed())
 		static_branch_enable(&lbr_from_quirk_key);
 }
@@ -1550,6 +1560,8 @@ void intel_pmu_lbr_init_hsw(void)
 /* skylake */
 __init void intel_pmu_lbr_init_skl(void)
 {
+	size_t size = sizeof(struct x86_perf_task_context);
+
 	x86_pmu.lbr_nr	 = 32;
 	x86_pmu.lbr_tos	 = MSR_LBR_TOS;
 	x86_pmu.lbr_from = MSR_LBR_NHM_FROM;
@@ -1559,6 +1571,8 @@ __init void intel_pmu_lbr_init_skl(void)
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = hsw_lbr_sel_map;
 
+	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
+
 	/*
 	 * SW branch filter usage:
 	 * - support syscall, sysret capture.
@@ -1632,6 +1646,7 @@ void __init intel_pmu_arch_lbr_init(void)
 	union cpuid28_ebx ebx;
 	union cpuid28_ecx ecx;
 	unsigned int unused_edx;
+	size_t size;
 	u64 lbr_nr;
 
 	/* Arch LBR Capabilities */
@@ -1656,8 +1671,10 @@ void __init intel_pmu_arch_lbr_init(void)
 	x86_pmu.lbr_br_type = ecx.split.lbr_br_type;
 	x86_pmu.lbr_nr = lbr_nr;
 
-	x86_get_pmu()->task_ctx_size = sizeof(struct x86_perf_task_context_arch_lbr) +
-				       lbr_nr * sizeof(struct lbr_entry);
+	size = sizeof(struct x86_perf_task_context_arch_lbr) +
+	       lbr_nr * sizeof(struct lbr_entry);
+	x86_get_pmu()->task_ctx_size = size;
+	x86_get_pmu()->task_ctx_cache = create_lbr_kmem_cache(size, 0);
 
 	x86_pmu.lbr_from = MSR_ARCH_LBR_FROM_0;
 	x86_pmu.lbr_to = MSR_ARCH_LBR_TO_0;
-- 
2.7.4

