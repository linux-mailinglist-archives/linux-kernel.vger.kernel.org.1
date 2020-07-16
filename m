Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4C1222A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 19:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgGPRxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 13:53:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:50547 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgGPRxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:53:44 -0400
IronPort-SDR: eM4C+pdhWoVzWvHhXtMyfD801k7HtKd6kzjsqMNVjmazkRVgqMD8u5hE2vK+g1Bva1UlogvJPn
 TdWUCm7zS4IQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167589776"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="167589776"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:53:43 -0700
IronPort-SDR: CBf9KGqiAvqBTUhBTy4HXL+g+c2Euzw42F3k25QjzLt6ckcMvy6/zoM3ds8aO68Z7BbjgUruvA
 pHt7DILKD6sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="326594904"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 16 Jul 2020 10:53:43 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Kuo-Lang Tseng" <kuo-lang.tsenng@intel.com>,
        "Babu Moger" <babu.moger@amd.com>, "H Peter Anvin" <hpa@zytor.com>
Cc:     "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 1/2] x86/resctrl: Enumerate per-thread MBA
Date:   Thu, 16 Jul 2020 10:53:13 -0700
Message-Id: <1594921994-66192-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1594921994-66192-1-git-send-email-fenghua.yu@intel.com>
References: <1594921994-66192-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems support per-thread Memory Bandwidth Allocation (MBA) which
applies a throttling delay value to each hardware thread instead of to
a core. Per-thread MBA is enumerated by CPUID.

No feature flag is shown in /proc/cpuinfo. User applications need to
check a resctrl throttling mode info file to know if the feature is
supported.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 02dabc9e77b0..ee5729da8379 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -286,6 +286,7 @@
 #define X86_FEATURE_FENCE_SWAPGS_USER	(11*32+ 4) /* "" LFENCE in user entry SWAPGS path */
 #define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
 #define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */
+#define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread Memory Bandwidth Allocation */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 3cbe24ca80ab..3e30b26c50ef 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -69,6 +69,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
+	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
 	{}
 };
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 62b137c3c97a..bccfc9ff3cc1 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -35,6 +35,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CDP_L3,		CPUID_ECX,  2, 0x00000010, 1 },
 	{ X86_FEATURE_CDP_L2,		CPUID_ECX,  2, 0x00000010, 2 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  3, 0x00000010, 0 },
+	{ X86_FEATURE_PER_THREAD_MBA,	CPUID_ECX,  0, 0x00000010, 3 },
 	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
-- 
2.19.1

