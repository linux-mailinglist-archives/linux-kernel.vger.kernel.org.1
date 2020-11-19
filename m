Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D202B9E73
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgKSXhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:37:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:7297 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgKSXhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:37:04 -0500
IronPort-SDR: CxI1OGClS36fA1X/ChS3KoK4onhl7Irl5DrafWetLfqDUERDBpNdQ9y6EaySZ/EjCKMFI38b2R
 R8G0sV9Q/dGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171552664"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="171552664"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 15:37:03 -0800
IronPort-SDR: +Cf/JNmSH1Jpu8Ih/Tx6XaZjJqHLTGBr9Ek7Y1TDAzKZ9Fd1WHczStBwNOzscu8m1HMqmnAjfg
 IR8cEhMye9yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="431392243"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 15:37:02 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v2 17/22] x86/cpufeatures/amx: Enumerate Advanced Matrix Extension (AMX) feature bits
Date:   Thu, 19 Nov 2020 15:32:52 -0800
Message-Id: <20201119233257.2939-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119233257.2939-1-chang.seok.bae@intel.com>
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
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
index d502241995a3..aed150626ea0 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -71,6 +71,9 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_PER_THREAD_MBA,		X86_FEATURE_MBA       },
+	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_AMX_INT8,			X86_FEATURE_AMX_TILE  },
+	{ X86_FEATURE_AMX_BF16,			X86_FEATURE_AMX_TILE  },
 	{}
 };
 
-- 
2.17.1

