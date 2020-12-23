Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C3B2E1F27
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbgLWQDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:03:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:48955 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgLWQDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:03:09 -0500
IronPort-SDR: hcFmTT//wRXQH9rNsmFWkDXCDhnjnn8BbfVeR0ERaZdiElSOnFHlaq6PZbr0PFpwAS0aVWEI0Z
 g/ALvNa1cnuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="155241880"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="155241880"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 08:01:39 -0800
IronPort-SDR: 8N2ZPD4CAUij2dnPDa9MEGWdq/b5b9aiEu/wdnVK7AZH5Zn78bGbgqQU+nyrU4MveFWDXH29Np
 ErVHKrsqtSIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="458027959"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2020 08:01:39 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v3 08/21] x86/fpu/xstate: Define the scope of the initial xstate data
Date:   Wed, 23 Dec 2020 07:57:04 -0800
Message-Id: <20201223155717.19556-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223155717.19556-1-chang.seok.bae@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_fpstate is used to record the initial xstate value for convenience
and covers all the states. But it is wasteful to cover large states all
with trivial initial data.

Limit init_fpstate by clarifying its size and coverage, which are all but
dynamic user states. The dynamic states are assumed to be large but having
initial data with zeros.

No functional change until the kernel supports dynamic user states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Updated the changelog for clarification.
* Updated the code comments.
---
 arch/x86/include/asm/fpu/internal.h | 18 +++++++++++++++---
 arch/x86/include/asm/fpu/xstate.h   |  1 +
 arch/x86/kernel/fpu/core.c          |  4 ++--
 arch/x86/kernel/fpu/xstate.c        |  4 ++--
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 37ea5e37f21c..bbdd304719c6 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -80,6 +80,18 @@ static __always_inline __pure bool use_fxsr(void)
 
 extern union fpregs_state init_fpstate;
 
+static inline u64 get_init_fpstate_mask(void)
+{
+	/* init_fpstate covers states in fpu->state. */
+	return (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
+}
+
+static inline unsigned int get_init_fpstate_size(void)
+{
+	/* fpu->state size is aligned with the init_fpstate size. */
+	return fpu_kernel_xstate_min_size;
+}
+
 extern void fpstate_init(struct fpu *fpu);
 #ifdef CONFIG_MATH_EMULATION
 extern void fpstate_init_soft(struct swregs_state *soft);
@@ -269,12 +281,12 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 		     : "memory")
 
 /*
- * This function is called only during boot time when x86 caps are not set
- * up and alternative can not be used yet.
+ * Use this function to dump the initial state, only during boot time when x86
+ * caps not set up and alternative not available yet.
  */
 static inline void copy_xregs_to_kernel_booting(struct xregs_state *xstate)
 {
-	u64 mask = xfeatures_mask_all;
+	u64 mask = get_init_fpstate_mask();
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 379e8f8b8440..62f6583f34fa 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -103,6 +103,7 @@ extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
 void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
+unsigned int get_xstate_size(u64 mask);
 int alloc_xstate_buffer(struct fpu *fpu, u64 mask);
 void free_xstate_buffer(struct fpu *fpu);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 6dafed34be4f..aad1a7102096 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -206,10 +206,10 @@ void fpstate_init(struct fpu *fpu)
 		return;
 	}
 
-	memset(state, 0, fpu_kernel_xstate_min_size);
+	memset(state, 0, fpu ? get_xstate_size(fpu->state_mask) : get_init_fpstate_size());
 
 	if (static_cpu_has(X86_FEATURE_XSAVES))
-		fpstate_init_xstate(&state->xsave, xfeatures_mask_all);
+		fpstate_init_xstate(&state->xsave, fpu ? fpu->state_mask : get_init_fpstate_mask());
 	if (static_cpu_has(X86_FEATURE_FXSR))
 		fpstate_init_fxstate(&state->fxsave);
 	else
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index af4d7d9aa977..43877005b4e2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -137,7 +137,7 @@ static bool xfeature_is_supervisor(int xfeature_nr)
  * Available once those arrays for the offset, size, and alignment info are set up,
  * by setup_xstate_features().
  */
-static unsigned int get_xstate_size(u64 mask)
+unsigned int get_xstate_size(u64 mask)
 {
 	unsigned int size;
 	u64 xmask;
@@ -511,7 +511,7 @@ static void __init setup_init_fpu_buf(void)
 	print_xstate_features();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		fpstate_init_xstate(&init_fpstate.xsave, xfeatures_mask_all);
+		fpstate_init_xstate(&init_fpstate.xsave, get_init_fpstate_mask());
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
-- 
2.17.1

