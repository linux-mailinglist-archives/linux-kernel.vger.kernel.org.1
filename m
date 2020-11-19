Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC702B9E71
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgKSXhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:37:16 -0500
Received: from mga07.intel.com ([134.134.136.100]:49077 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbgKSXhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:37:08 -0500
IronPort-SDR: BlFZnxtu6/zIpcP3XEXFga0Mck3WCA6Chz0UO+8upL0nzuOcPmarVuf6TEEVxyqhdkVdL4K9YV
 e2AqC2owvSuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="235531211"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="235531211"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 15:37:04 -0800
IronPort-SDR: 2uATYGm567Y9AV2x3n0e71fAoCC+ZgZd35ZUcAp55gLkJ/6m2xFiWvS333vbIVCKN8vAKEsOBD
 BnSEj3H4wY4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="431392259"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 15:37:03 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-doc@vger.kernel.org
Subject: [PATCH v2 22/22] x86/fpu/xstate: Introduce boot-parameters for control some state component support
Date:   Thu, 19 Nov 2020 15:32:57 -0800
Message-Id: <20201119233257.2939-23-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119233257.2939-1-chang.seok.bae@intel.com>
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename XFEATURE_MASK_USER_SUPPORTED to XFEATURE_MASK_USER_ENABLED to
literally align with new boot-parameters.

"xstate.disable=0x60000" will disable AMX on a system that has AMX compiled
into XFEATURE_MASK_USER_ENABLED.

"xstate.enable=0x60000" will enable AMX on a system that does NOT have AMX
compiled into XFEATURE_MASK_USER_ENABLED (assuming the kernel is new enough
to support this feature).

While this cmdline is currently enabled only for AMX, it is intended to be
easily enabled to be useful for future XSAVE-enabled features.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v1:
* Renamed the user state mask define (Andy Lutomirski and Dave Hansen)
* Changed the error message (Dave Hansen)
* Fixed xfeatures_mask_user()
* Rebased the upstream kernel (5.10) -- revived the param parse function
---
 .../admin-guide/kernel-parameters.txt         | 15 ++++
 arch/x86/include/asm/fpu/types.h              |  6 ++
 arch/x86/include/asm/fpu/xstate.h             | 24 +++---
 arch/x86/kernel/fpu/init.c                    | 73 +++++++++++++++++--
 4 files changed, 101 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..c41528cfe39f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5995,6 +5995,21 @@
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
index 18eb50fc95e8..ababb748cc8e 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -149,6 +149,12 @@ enum xfeature {
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
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 1544a874b748..683a8503c1c6 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -25,17 +25,17 @@
 
 #define XSAVE_ALIGNMENT     64
 
-/* All currently supported user features */
-#define XFEATURE_MASK_USER_SUPPORTED (XFEATURE_MASK_FP | \
-				      XFEATURE_MASK_SSE | \
-				      XFEATURE_MASK_YMM | \
-				      XFEATURE_MASK_OPMASK | \
-				      XFEATURE_MASK_ZMM_Hi256 | \
-				      XFEATURE_MASK_Hi16_ZMM	 | \
-				      XFEATURE_MASK_PKRU | \
-				      XFEATURE_MASK_BNDREGS | \
-				      XFEATURE_MASK_BNDCSR | \
-				      XFEATURE_MASK_XTILE)
+/* All currently enabled user features */
+#define XFEATURE_MASK_USER_ENABLED (XFEATURE_MASK_FP | \
+				    XFEATURE_MASK_SSE | \
+				    XFEATURE_MASK_YMM | \
+				    XFEATURE_MASK_OPMASK | \
+				    XFEATURE_MASK_ZMM_Hi256 | \
+				    XFEATURE_MASK_Hi16_ZMM	 | \
+				    XFEATURE_MASK_PKRU | \
+				    XFEATURE_MASK_BNDREGS | \
+				    XFEATURE_MASK_BNDCSR | \
+				    XFEATURE_MASK_XTILE)
 
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
@@ -87,7 +87,7 @@ static inline u64 xfeatures_mask_supervisor(void)
 
 static inline u64 xfeatures_mask_user(void)
 {
-	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
+	return xfeatures_mask_all & ~(XFEATURE_MASK_SUPERVISOR_ALL);
 }
 
 static inline u64 xfeatures_mask_supervisor_dynamic(void)
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 954ac4f0f761..f1cdac3321c8 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -5,6 +5,7 @@
 #include <asm/fpu/internal.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
+#include <asm/cmdline.h>
 
 #include <linux/sched.h>
 #include <linux/sched/task.h>
@@ -224,14 +225,44 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 /*
  * Find supported xfeatures based on cpu features and command-line input.
  * This must be called after fpu__init_parse_early_param() is called and
- * xfeatures_mask is enumerated.
+ * xfeatures_mask_all is enumerated.
  */
+
+static u64 xstate_enable;
+static u64 xstate_disable;
+
 u64 __init fpu__get_supported_xfeatures_mask(void)
 {
-	u64 mask = XFEATURE_MASK_USER_SUPPORTED | XFEATURE_MASK_SUPERVISOR_SUPPORTED;
-
-	if (!IS_ENABLED(CONFIG_X86_64))
-		mask &= ~(XFEATURE_MASK_XTILE);
+	u64 mask = XFEATURE_MASK_USER_ENABLED | XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+
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
+			 * xstate component.
+			 */
+			pr_warn("x86/fpu: Attempt to enable unknown xstate features 0x%llx\n",
+				unknown);
+			WARN_ON_FPU(1);
+		}
+
+		if ((custom & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
+			pr_warn("x86/fpu: Error in xstate.disable. Additionally disabling 0x%x components.\n",
+				XFEATURE_MASK_XTILE);
+			custom &= ~(XFEATURE_MASK_XTILE);
+		}
+
+		mask = custom;
+	}
 
 	return mask;
 }
@@ -245,12 +276,44 @@ static void __init fpu__init_system_ctx_switch(void)
 	on_boot_cpu = 0;
 }
 
+#define HEXA_BASE	16
+/*
+ * Longest parameter of 'xstate.enable=' is 16 hexadecimal characters with '0x' prefix and
+ * an extra '\0' for termination.
+ */
+#define MAX_XSTATE_MASK_CHARS	19
+
+/*
+ * We parse xstate parameters early because fpu__init_system() is executed
+ * before parse_early_param().
+ */
+static void __init fpu__init_parse_early_param(void)
+{
+	char arg[MAX_XSTATE_MASK_CHARS];
+	u64 mask;
+
+	if (cmdline_find_option(boot_command_line, "xstate.enable", arg,
+				sizeof(arg)) &&
+	    !kstrtoull(arg, HEXA_BASE, &mask))
+		xstate_enable = mask & XFEATURE_MASK_CONFIGURABLE;
+	else
+		xstate_enable = 0;
+
+	if (cmdline_find_option(boot_command_line, "xstate.disable", arg,
+				sizeof(arg)) &&
+	    !kstrtoull(arg, HEXA_BASE, &mask))
+		xstate_disable = mask & XFEATURE_MASK_CONFIGURABLE;
+	else
+		xstate_disable = 0;
+}
+
 /*
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
  */
 void __init fpu__init_system(struct cpuinfo_x86 *c)
 {
+	fpu__init_parse_early_param();
 	fpu__init_system_early_generic(c);
 
 	/*
-- 
2.17.1

