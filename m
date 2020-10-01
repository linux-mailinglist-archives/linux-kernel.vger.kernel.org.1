Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2F2808AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbgJAUnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:43:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:58726 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733095AbgJAUnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:43:18 -0400
IronPort-SDR: sqDrBmCiU2+r0ar4nqWXy9Ac+Kn/C4OZG43GbiR+jH/EU+PPQmLMJYDo6RoBK5wzjSRGYuNkpU
 ARmDfaVEA9uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170736"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170736"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:53 -0700
IronPort-SDR: TZhfzqEtO2TcQ0mIlnd79M/WSym33lzC6HXcqhZZnlIU8OFPmgRhSG+3Z7KrSoFmWfp7GjoSdW
 ABF+bi5zQBeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297078"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:53 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 17/22] x86/fpu/xstate: Extend the table for mapping xstate components with features
Date:   Thu,  1 Oct 2020 13:39:08 -0700
Message-Id: <20201001203913.9125-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At compile-time xfeatures_mask_all includes all possible XCR0 features. At
run-time fpu__init_system_xstate() clears features in xfeatures_mask_all
that are not enabled in CPUID. It does this by looping through all possible
XCR0 features.

Update the code to handle the possibility that there will be gaps in the
XCR0 feature bit numbers.

No functional change, until hardware with bit number gaps in XCR0.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/xstate.c | 39 ++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 13e8eff7a23b..eaada4a38153 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -41,17 +41,22 @@ static const char *xfeature_names[] =
 	"unknown xstate feature"	,
 };
 
-static short xsave_cpuid_features[] __initdata = {
-	X86_FEATURE_FPU,
-	X86_FEATURE_XMM,
-	X86_FEATURE_AVX,
-	X86_FEATURE_MPX,
-	X86_FEATURE_MPX,
-	X86_FEATURE_AVX512F,
-	X86_FEATURE_AVX512F,
-	X86_FEATURE_AVX512F,
-	X86_FEATURE_INTEL_PT,
-	X86_FEATURE_PKU,
+struct xfeature_capflag_info {
+	int xfeature_idx;
+	short cpu_cap;
+};
+
+static struct xfeature_capflag_info xfeature_capflags[] __initdata = {
+	{ XFEATURE_FP,				X86_FEATURE_FPU },
+	{ XFEATURE_SSE,				X86_FEATURE_XMM },
+	{ XFEATURE_YMM,				X86_FEATURE_AVX },
+	{ XFEATURE_BNDREGS,			X86_FEATURE_MPX },
+	{ XFEATURE_BNDCSR,			X86_FEATURE_MPX },
+	{ XFEATURE_OPMASK,			X86_FEATURE_AVX512F },
+	{ XFEATURE_ZMM_Hi256,			X86_FEATURE_AVX512F },
+	{ XFEATURE_Hi16_ZMM,			X86_FEATURE_AVX512F },
+	{ XFEATURE_PT_UNIMPLEMENTED_SO_FAR,	X86_FEATURE_INTEL_PT },
+	{ XFEATURE_PKRU,			X86_FEATURE_PKU },
 };
 
 /*
@@ -950,11 +955,15 @@ void __init fpu__init_system_xstate(void)
 	}
 
 	/*
-	 * Clear XSAVE features that are disabled in the normal CPUID.
+	 * Cross-check XSAVE feature with CPU capability flag. Clear the
+	 * mask bit for disabled features.
 	 */
-	for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
-		if (!boot_cpu_has(xsave_cpuid_features[i]))
-			xfeatures_mask_all &= ~BIT_ULL(i);
+	for (i = 0; i < ARRAY_SIZE(xfeature_capflags); i++) {
+		short cpu_cap = xfeature_capflags[i].cpu_cap;
+		int idx = xfeature_capflags[i].xfeature_idx;
+
+		if (!boot_cpu_has(cpu_cap))
+			xfeatures_mask_all &= ~BIT_ULL(idx);
 	}
 
 	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();
-- 
2.17.1

