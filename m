Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D4E2E1F29
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgLWQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:03:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:1646 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbgLWQDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:03:18 -0500
IronPort-SDR: df5kPrD2ITg/55XaoV1aziFkKSrjxCB2uz16M5RJqmSv0HQdjUPh2VKKmT+NfrRBaM+tY6e56r
 c/JGieFj3xbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="194483193"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="194483193"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 08:01:40 -0800
IronPort-SDR: L5T1O9esMiUF/491VbVF5egfajEJX2F/W3c1kYER1E2jn/8MZd0s1yHXalVPz26RsybQQb2te6
 mqhv18ApaTSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="458028007"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2020 08:01:40 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v3 16/21] x86/cpufeatures/amx: Enumerate Advanced Matrix Extension (AMX) feature bits
Date:   Wed, 23 Dec 2020 07:57:12 -0800
Message-Id: <20201223155717.19556-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223155717.19556-1-chang.seok.bae@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's Advanced Matrix Extension (AMX) is a new 64-bit extended feature
consisting of two-dimensional registers and an accelerator unit. The first
implementation of the latter is the tile matrix multiply unit (TMUL). TMUL
performs SIMD dot-products on four bytes (INT8) or two bfloat16
floating-point (BF16) elements.

Here we add AMX to the kernel/user ABI, by enumerating the capability.
E.g., /proc/cpuinfo: amx_tile, amx_bf16, amx_int8

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/cpufeatures.h | 3 +++
 arch/x86/kernel/cpu/cpuid-deps.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5b6496ee3703..a1839b6a1929 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -375,6 +375,9 @@
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX BF16 Support */
+#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX INT8 Support */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index a9e8e160ae30..1cef9264067e 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -72,6 +72,9 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_AMX_INT8,			X86_FEATURE_AMX_TILE  },
+	{ X86_FEATURE_AMX_BF16,			X86_FEATURE_AMX_TILE  },
 	{}
 };
 
-- 
2.17.1

