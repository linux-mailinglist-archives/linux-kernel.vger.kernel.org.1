Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C512E1F32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgLWQDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:03:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:1574 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbgLWQDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:03:44 -0500
IronPort-SDR: XAi4pC28HUR3qu/LMLCUFZ4g6IVGUrX0dJOgBSsetrL0J5Vk+bxzizgbZMZmuIe3dpdFGQl+Zj
 KMvfZDdhLR1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="194483207"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="194483207"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 08:01:42 -0800
IronPort-SDR: TCj6TKSMOsZFMf0xgVwBuMfSxrZygI4cDPZYZSO7Oyftv+O/QShZZ1IqSWw4h5k7adcXmnlon3
 1TZs6sQs6Qvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="458028073"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2020 08:01:42 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-doc@vger.kernel.org
Subject: [PATCH v3 21/21] x86/fpu/xstate: Introduce boot-parameters to control some state component support
Date:   Wed, 23 Dec 2020 07:57:17 -0800
Message-Id: <20201223155717.19556-22-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223155717.19556-1-chang.seok.bae@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"xstate.disable=0x60000" will disable AMX on a system that has AMX compiled
into XFEATURE_MASK_USER_ENABLED.

"xstate.enable=0x60000" will enable AMX on a system that does NOT have AMX
compiled into XFEATURE_MASK_USER_ENABLED (assuming the kernel is new enough
to support this feature).

Rename XFEATURE_MASK_USER_SUPPORTED to XFEATURE_MASK_USER_ENABLED to be
aligned with the new parameters.

While this cmdline is currently enabled only for AMX, it is intended to be
easily enabled to be useful for future XSAVE-enabled features.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Changed the kernel tainted when any unknown state is enabled. (Andy
  Lutomirski)
* Simplified the cmdline handling.
* Edited the changelog.

Changes from v1:
* Renamed the user state mask define (Andy Lutomirski and Dave Hansen)
* Changed the error message (Dave Hansen)
* Fixed xfeatures_mask_user()
* Rebased the upstream kernel (5.10) -- revived the param parse function
---
 .../admin-guide/kernel-parameters.txt         | 15 +++++
 arch/x86/include/asm/fpu/types.h              |  6 ++
 arch/x86/include/asm/fpu/xstate.h             | 24 +++----
 arch/x86/kernel/fpu/init.c                    | 65 +++++++++++++++++--
 4 files changed, 93 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 44fde25bb221..a67ae04d43c5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6002,6 +6002,21 @@
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
index bf9511efd546..8835d3f6acb7 100644
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
index 8f5218d420ad..c27feca8e66c 100644
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
index c77c1c5580f9..f73aaae81ed9 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -5,6 +5,7 @@
 #include <asm/fpu/internal.h>
 #include <asm/tlbflush.h>
 #include <asm/setup.h>
+#include <asm/cmdline.h>
 
 #include <linux/sched.h>
 #include <linux/sched/task.h>
@@ -229,14 +230,45 @@ static void __init fpu__init_system_xstate_size_legacy(void)
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
+			add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
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
@@ -250,12 +282,35 @@ static void __init fpu__init_system_ctx_switch(void)
 	on_boot_cpu = 0;
 }
 
+/*
+ * Longest parameter of 'xstate.enable=' is 22 octal number characters with '0' prefix and
+ * an extra '\0' for termination.
+ */
+#define MAX_XSTATE_MASK_CHARS	24
+/*
+ * We parse xstate parameters early because fpu__init_system() is executed before
+ * parse_early_param().
+ */
+static void __init fpu__init_parse_early_param(void)
+{
+	char arg[MAX_XSTATE_MASK_CHARS];
+
+	if (cmdline_find_option(boot_command_line, "xstate.enable", arg, sizeof(arg)) &&
+	    !kstrtoull(arg, 0, &xstate_enable))
+		xstate_enable &= XFEATURE_MASK_CONFIGURABLE;
+
+	if (cmdline_find_option(boot_command_line, "xstate.disable", arg, sizeof(arg)) &&
+	    !kstrtoull(arg, 0, &xstate_disable))
+		xstate_disable &= XFEATURE_MASK_CONFIGURABLE;
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

