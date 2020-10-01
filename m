Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCBC280899
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbgJAUnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:43:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:58716 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgJAUmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:42:54 -0400
IronPort-SDR: e5bMfDehytBWZZA9PVc/dsAUygkZpwstaOqCPzsgoSmoXDTp/pmK22Qt+ZYUxel6jyCogCz7Gp
 f4n2TY9Q07Fw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170715"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170715"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:52 -0700
IronPort-SDR: z1CsF/Ah0c4OvhcbNhlMOPUXV8Q5wHMpAZHJ8Ms66Jrhb6a+kRaeV7xCbihDK4nkDbUi5CIYdE
 cNjHGseSBAiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297046"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:51 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 07/22] x86/fpu/xstate: Introduce helpers to manage an xstate area dynamically
Date:   Thu,  1 Oct 2020 13:38:58 -0700
Message-Id: <20201001203913.9125-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task->fpu has a buffer to keep the extended register states, but it is not
expandable at runtime. Introduce runtime methods and new fpu struct fields
to support the expansion.

fpu->state_mask indicates the saved states per task and fpu->state_ptr
points the dynamically allocated area.

alloc_xstate_area() uses vmalloc() for its scalability. However, set a
threshold (64KB) to watch out a potential need for an alternative
mechanism.

Also, introduce a new helper -- get_xstate_size() to calculate the area
size.

No functional change until the kernel supports dynamic user states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/fpu/types.h  |  29 +++++--
 arch/x86/include/asm/fpu/xstate.h |   3 +
 arch/x86/kernel/fpu/core.c        |   3 +
 arch/x86/kernel/fpu/xstate.c      | 124 ++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index c87364ea6446..4b7756644824 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -327,14 +327,33 @@ struct fpu {
 	 */
 	unsigned long			avx512_timestamp;
 
+	/*
+	 * @state_mask:
+	 *
+	 * The state component bitmap. It indicates the saved xstate in
+	 * either @state or @state_ptr. The map value starts to be aligned
+	 * with @state and then with @state_ptr once it is in use.
+	 */
+	u64				state_mask;
+
+	/*
+	 * @state_ptr:
+	 *
+	 * Copy of all extended register states, in a dynamically-allocated
+	 * area, we save and restore over context switches. When a task is
+	 * using extended features, the register state is always the most
+	 * current. This state copy is more recent than @state. If the task
+	 * context-switches away, they get saved here, representing the xstate.
+	 */
+	union fpregs_state		*state_ptr;
+
 	/*
 	 * @state:
 	 *
-	 * In-memory copy of all FPU registers that we save/restore
-	 * over context switches. If the task is using the FPU then
-	 * the registers in the FPU are more recent than this state
-	 * copy. If the task context-switches away then they get
-	 * saved here and represent the FPU state.
+	 * Copy of some extended register state that we save and restore
+	 * over context switches. If a task uses a dynamically-allocated
+	 * area, @state_ptr, then it has a more recent state copy than this.
+	 * This copy follows the same attributes as described for @state_ptr.
 	 */
 	union fpregs_state		state;
 	/*
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 9aad91c0725b..37728bfcb71e 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -103,6 +103,9 @@ extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
 void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
+int alloc_xstate_area(struct fpu *fpu, u64 mask, unsigned int *alloc_size);
+void free_xstate_area(struct fpu *fpu);
+
 const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 875620fdfe61..e25f7866800e 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -235,6 +235,9 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
 	 */
 	memset(&dst_fpu->state.xsave, 0, fpu_kernel_xstate_default_size);
 
+	dst_fpu->state_mask = xfeatures_mask_all & ~xfeatures_mask_user_dynamic;
+	dst_fpu->state_ptr = NULL;
+
 	/*
 	 * If the FPU registers are not current just memcpy() the state.
 	 * Otherwise save current FPU registers directly into the child's FPU
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 6e0d8a9699ed..af60332aafef 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -10,6 +10,7 @@
 #include <linux/pkeys.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
+#include <linux/vmalloc.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/internal.h>
@@ -69,6 +70,7 @@ static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] =
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_comp_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
+static bool xstate_aligns[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = false};
 
 /*
  * The XSAVE area of kernel can be in standard or compacted format;
@@ -128,6 +130,48 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
+/*
+ * Available once those arrays for the offset, size, and alignment info are set up,
+ * by setup_xstate_features().
+ */
+static unsigned int get_xstate_size(u64 mask)
+{
+	unsigned int size;
+	u64 xmask;
+	int i, nr;
+
+	if (!mask)
+		return 0;
+	else if (mask == (xfeatures_mask_all & ~xfeatures_mask_user_dynamic))
+		return fpu_kernel_xstate_default_size;
+	else if (mask == xfeatures_mask_all)
+		return fpu_kernel_xstate_max_size;
+
+	nr = fls64(mask) - 1;
+
+	if (!using_compacted_format())
+		return xstate_offsets[nr] + xstate_sizes[nr];
+
+	xmask = BIT_ULL(nr + 1) - 1;
+
+	if (mask == (xmask & xfeatures_mask_all))
+		return xstate_comp_offsets[nr] + xstate_sizes[nr];
+
+	/*
+	 * Calculate the size by summing up each state together, since no known
+	 * size found with the xstate area format out of the given mask.
+	 */
+	for (size = FXSAVE_SIZE + XSAVE_HDR_SIZE, i = FIRST_EXTENDED_XFEATURE; i <= nr; i++) {
+		if (!(mask & BIT_ULL(i)))
+			continue;
+
+		if (xstate_aligns[i])
+			size = ALIGN(size, 64);
+		size += xstate_sizes[i];
+	}
+	return size;
+}
+
 /*
  * When executing XSAVEOPT (or other optimized XSAVE instructions), if
  * a processor implementation detects that an FPU state component is still
@@ -268,10 +312,12 @@ static void __init setup_xstate_features(void)
 	xstate_offsets[XFEATURE_FP]	= 0;
 	xstate_sizes[XFEATURE_FP]	= offsetof(struct fxregs_state,
 						   xmm_space);
+	xstate_aligns[XFEATURE_FP]	= true;
 
 	xstate_offsets[XFEATURE_SSE]	= xstate_sizes[XFEATURE_FP];
 	xstate_sizes[XFEATURE_SSE]	= sizeof_field(struct fxregs_state,
 						       xmm_space);
+	xstate_aligns[XFEATURE_SSE]	= true;
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		if (!xfeature_enabled(i))
@@ -289,6 +335,7 @@ static void __init setup_xstate_features(void)
 			continue;
 
 		xstate_offsets[i] = ebx;
+		xstate_aligns[i] = (ecx & 2) ? true : false;
 
 		/*
 		 * In our xstate size checks, we assume that the highest-numbered
@@ -753,6 +800,9 @@ static bool is_supported_xstate_size(unsigned int test_xstate_size)
 	return false;
 }
 
+/* The watched threshold size of dynamically allocated xstate area */
+#define XSTATE_AREA_MAX_BYTES		(64 * 1024)
+
 static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
@@ -777,6 +827,14 @@ static int __init init_xstate_size(void)
 	if (!is_supported_xstate_size(fpu_kernel_xstate_default_size))
 		return -EINVAL;
 
+	/*
+	 * When observing the allocation goes beyond the threshold, it is better to consider
+	 * switching a better scalable mechanism than the current.
+	 */
+	if (fpu_kernel_xstate_max_size > XSTATE_AREA_MAX_BYTES)
+		pr_warn("x86/fpu: xstate buffer too large (%u > %u)\n",
+			fpu_kernel_xstate_max_size, XSTATE_AREA_MAX_BYTES);
+
 	/*
 	 * User space is always in standard format.
 	 */
@@ -867,6 +925,12 @@ void __init fpu__init_system_xstate(void)
 	if (err)
 		goto out_disable;
 
+	/*
+	 * At this point, it passed the size sanity check. Have the init_task take
+	 * the feature mask.
+	 */
+	current->thread.fpu.state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
+
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
@@ -1086,6 +1150,66 @@ static inline bool xfeatures_mxcsr_quirk(u64 xfeatures)
 	return true;
 }
 
+void free_xstate_area(struct fpu *fpu)
+{
+	vfree(fpu->state_ptr);
+}
+
+/*
+ * Allocate a new xstate area with a calculated size, based on the given bit value.
+ *
+ * No mechanism implemented yet to shrink or reclaim the xstate area on the fly,
+ * the need of which is subject to the real usage.
+ */
+int alloc_xstate_area(struct fpu *fpu, u64 mask, unsigned int *alloc_size)
+{
+	union fpregs_state *state_ptr;
+	unsigned int oldsz, newsz;
+	u64 state_mask;
+
+	state_mask = fpu->state_mask | mask;
+
+	oldsz = get_xstate_size(fpu->state_mask);
+	newsz = get_xstate_size(state_mask);
+
+	if (oldsz >= newsz)
+		return 0;
+
+	if (newsz > fpu_kernel_xstate_max_size) {
+		pr_warn_once("x86/fpu: state buffer too large (%u > %u bytes)\n",
+			     newsz, fpu_kernel_xstate_max_size);
+		XSTATE_WARN_ON(1);
+		return 0;
+	}
+
+	/*
+	 * The caller may be under interrupt disabled condition. Ensure interrupt
+	 * allowance before the memory allocation, which may involve with page faults.
+	 */
+	local_irq_enable();
+	/* We need 64B aligned pointer, but vmalloc() returns a page-aligned address */
+	state_ptr = vmalloc(newsz);
+	local_irq_disable();
+	if (!state_ptr)
+		return -ENOMEM;
+
+	memset(state_ptr, 0, newsz);
+	if (using_compacted_format())
+		fpstate_init_xstate(&state_ptr->xsave, state_mask);
+
+	/*
+	 * As long as the register state is intact, save the xstate in the new area at
+	 * the next context copy/switch or potentially ptrace-driven xstate writing
+	 */
+
+	vfree(fpu->state_ptr);
+	fpu->state_ptr = state_ptr;
+	fpu->state_mask = state_mask;
+	if (alloc_size)
+		*alloc_size = newsz;
+	return 0;
+}
+
 static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
 {
 	if (*last >= offset)
-- 
2.17.1

