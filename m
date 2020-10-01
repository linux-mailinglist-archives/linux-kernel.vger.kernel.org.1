Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0932808A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbgJAUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:43:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:58726 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387410AbgJAUnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:43:19 -0400
IronPort-SDR: NlxWvX8ti38395TC9J+5Q64tBduPh5iqvnxjy3QjoeGeFcVHXPiIsjFzjQMISDJxxaidS2Ocsc
 8h0fHKnX2KoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170747"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170747"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:53 -0700
IronPort-SDR: I800DeHN9sk9r4cQqta11en9u/NfITwZ7C+4drbRimfAi0JEEYm7HAixoEOq+r214wnqfTQMZ0
 R5qPeVtt6y6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297093"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:53 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-doc@vger.kernel.org
Subject: [RFC PATCH 22/22] x86/fpu/xstate: Introduce boot-parameters for control some state component support
Date:   Thu,  1 Oct 2020 13:39:13 -0700
Message-Id: <20201001203913.9125-23-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"xstate.disable=0x6000" will disable AMX on a system that has AMX compiled
into XFEATURE_MASK_USER_SUPPORTED.

"xstate.enable=0x6000" will enable AMX on a system that does NOT have AMX
compiled into XFEATURE_MASK_USER_SUPPORTED (assuming the kernel is new
enough to support this feature).

While this cmdline is currently enabled only for AMX, it is intended to be
easily enabled to be useful for future XSAVE-enabled features.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../admin-guide/kernel-parameters.txt         | 15 ++++++
 arch/x86/include/asm/fpu/types.h              |  6 +++
 arch/x86/kernel/fpu/init.c                    | 52 +++++++++++++++++--
 3 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1068742a6df..742167c6f789 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5838,6 +5838,21 @@
 			which allow the hypervisor to 'idle' the guest on lock
 			contention.
 
+	xstate.enable=	[X86-64]
+	xstate.disable=	[X86-64]
+			The kernel is compiled with a default xstate bitmask --
+			enabling it to use the XSAVE hardware to efficiently
+			save and restore thread states on context switch.
+			xstate.enable allows adding to that default mask at
+			boot-time without recompiling the kernel just to support
+			the new thread state. (Note that the kernel will ignore
+			any bits in the mask that do not correspond to features
+			that are actually available in CPUID)  xstate.disable
+			allows clearing bits in the default mask, forcing the
+			kernel to forget that it supports the specified thread
+			state. When a bit set for both, the kernel takes
+			xstate.disable in a priority.
+
 	xirc2ps_cs=	[NET,PCMCIA]
 			Format:
 			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 002248dba6dc..2a944e8903bb 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -148,6 +148,12 @@ enum xfeature {
 #define XFEATURE_MASK_XTILE		(XFEATURE_MASK_XTILE_DATA \
 					 | XFEATURE_MASK_XTILE_CFG)
 
+#define XFEATURE_REGION_MASK(max_bit, min_bit) \
+	((BIT_ULL((max_bit) - (min_bit) + 1) - 1) << (min_bit))
+
+#define XFEATURE_MASK_CONFIGURABLE \
+	XFEATURE_REGION_MASK(XFEATURE_XTILE_DATA, XFEATURE_XTILE_CFG)
+
 #define FIRST_EXTENDED_XFEATURE	XFEATURE_YMM
 
 struct reg_128_bit {
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 8e2a77bc1782..a354286e7c90 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -227,13 +227,42 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  * This must be called after fpu__init_parse_early_param() is called and
  * xfeatures_mask is enumerated.
  */
+
+static u64 xstate_enable;
+static u64 xstate_disable;
+
 u64 __init fpu__get_supported_xfeatures_mask(void)
 {
 	u64 mask = XFEATURE_MASK_USER_SUPPORTED | XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 
-	if (!IS_ENABLED(CONFIG_X86_64))
-		mask &= ~(XFEATURE_MASK_XTILE);
-
+	if (!IS_ENABLED(CONFIG_X86_64)) {
+		mask  &= ~(XFEATURE_MASK_XTILE);
+	} else if (xstate_enable || xstate_disable) {
+		u64 custom = mask;
+		u64 unknown;
+
+		custom |= xstate_enable;
+		custom &= ~xstate_disable;
+
+		unknown = custom & ~mask;
+		if (unknown) {
+			/*
+			 * User should fully understand the result of using undocumented
+			 * xstate component
+			 */
+			pr_warn("x86/fpu: Attempt to enable unknown xstate features 0x%llx\n",
+				unknown);
+			WARN_ON_FPU(1);
+		}
+
+		if ((custom & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
+			pr_warn("x86/fpu: Disable 0x%x components due to incorrect setup\n",
+				XFEATURE_MASK_XTILE);
+			custom &= ~(XFEATURE_MASK_XTILE);
+		}
+
+		mask = custom;
+	}
 	return mask;
 }
 
@@ -254,6 +283,7 @@ static void __init fpu__init_parse_early_param(void)
 {
 	char arg[32];
 	char *argptr = arg;
+	u64 mask;
 	int bit;
 
 #ifdef CONFIG_X86_32
@@ -283,6 +313,22 @@ static void __init fpu__init_parse_early_param(void)
 	    bit >= 0 &&
 	    bit < NCAPINTS * 32)
 		setup_clear_cpu_cap(bit);
+
+	if (cmdline_find_option(boot_command_line, "xstate.enable", arg,
+				sizeof(arg)) &&
+	    !kstrtoull(arg, 16, &mask) &&
+	    (mask &= XFEATURE_MASK_CONFIGURABLE))
+		xstate_enable = mask;
+	else
+		xstate_enable = 0;
+
+	if (cmdline_find_option(boot_command_line, "xstate.disable", arg,
+				sizeof(arg)) &&
+	    !kstrtoull(arg, 16, &mask) &&
+	    (mask &= XFEATURE_MASK_CONFIGURABLE))
+		xstate_disable = mask;
+	else
+		xstate_disable = 0;
 }
 
 /*
-- 
2.17.1

