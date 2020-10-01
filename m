Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759AE280898
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbgJAUnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:43:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:58718 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgJAUmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:42:54 -0400
IronPort-SDR: 8lFCDVBZt7MvfatmaB6lM5NyHGj0MCrZ7q2s3n5QSLoBwv8cLFWCZu5hA3FmhU2uurhtzzJt5P
 ijUMBxTEAo5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170718"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170718"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:52 -0700
IronPort-SDR: aqbMCQHDQoxfpIMPWqsQaOIZ6LvocHnzWKdMyMddbF7JbmLIIJfnm5rXdUtc92UKcEMQnUZh+D
 MEbqDmY74EQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297050"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:52 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 08/22] x86/fpu/xstate: Define the scope of the initial xstate data
Date:   Thu,  1 Oct 2020 13:38:59 -0700
Message-Id: <20201001203913.9125-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_fpstate covers all the component states. But it becomes less efficient
to do this as the state size trends larger but with trivial initial data.

Limit init_fpstate by clarifying its size and coverage, which are all but
dynamic user states. The dynamic states are assumed to be large but having
initial data with zeros.

No functional change until the kernel supports dynamic user states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/fpu/internal.h | 18 +++++++++++++++---
 arch/x86/include/asm/fpu/xstate.h   |  1 +
 arch/x86/kernel/fpu/core.c          |  4 ++--
 arch/x86/kernel/fpu/xstate.c        |  4 ++--
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 6eec5209750f..d64c1083bd93 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -79,6 +79,18 @@ static __always_inline __pure bool use_fxsr(void)
 
 extern union fpregs_state init_fpstate;
 
+static inline u64 get_init_fpstate_mask(void)
+{
+	/* init_fpstate covers state components, as covered in fpu->state */
+	return (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
+}
+
+static inline unsigned int get_init_fpstate_size(void)
+{
+	/* fpu->state size matches with init_fpstate size */
+	return fpu_kernel_xstate_default_size;
+}
+
 extern void fpstate_init(struct fpu *fpu);
 #ifdef CONFIG_MATH_EMULATION
 extern void fpstate_init_soft(struct swregs_state *soft);
@@ -268,12 +280,12 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
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
index 37728bfcb71e..9de8b4c49855 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -103,6 +103,7 @@ extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
 void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
+unsigned int get_xstate_size(u64 mask);
 int alloc_xstate_area(struct fpu *fpu, u64 mask, unsigned int *alloc_size);
 void free_xstate_area(struct fpu *fpu);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index e25f7866800e..33956ae3de2b 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -206,10 +206,10 @@ void fpstate_init(struct fpu *fpu)
 		return;
 	}
 
-	memset(state, 0, fpu_kernel_xstate_default_size);
+	memset(state, 0, fpu ? get_xstate_size(fpu->state_mask) : get_init_fpstate_size());
 
 	if (static_cpu_has(X86_FEATURE_XSAVES))
-		fpstate_init_xstate(&state->xsave, xfeatures_mask_all);
+		fpstate_init_xstate(&state->xsave, fpu ? fpu->state_mask : get_init_fpstate_mask());
 	if (static_cpu_has(X86_FEATURE_FXSR))
 		fpstate_init_fxstate(&state->fxsave);
 	else
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index af60332aafef..2e190254d4aa 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -134,7 +134,7 @@ static bool xfeature_is_supervisor(int xfeature_nr)
  * Available once those arrays for the offset, size, and alignment info are set up,
  * by setup_xstate_features().
  */
-static unsigned int get_xstate_size(u64 mask)
+unsigned int get_xstate_size(u64 mask)
 {
 	unsigned int size;
 	u64 xmask;
@@ -507,7 +507,7 @@ static void __init setup_init_fpu_buf(void)
 	print_xstate_features();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		fpstate_init_xstate(&init_fpstate.xsave, xfeatures_mask_all);
+		fpstate_init_xstate(&init_fpstate.xsave, get_init_fpstate_mask());
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
-- 
2.17.1

