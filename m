Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783772E1F26
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgLWQDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:03:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:48944 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgLWQDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:03:08 -0500
IronPort-SDR: AGkZGEQubDLweUaZO5SL2dCO+M+01+70AEU8xTR7coVh8xf1w8oTviYfu8dmTf9D2gF4Z41PZM
 nU5tWiJ3vxWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="155241878"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="155241878"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 08:01:39 -0800
IronPort-SDR: /qIqpiB9khZxJRdcqze/pyLfZnYT+sokyFdMJHG3Y+OLtOEi/TsW9RkAQK2Adllvse+nUEknqo
 ZCntzyVhS5dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="458027953"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2020 08:01:39 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v3 07/21] x86/fpu/xstate: Introduce helpers to manage dynamic xstate buffers
Date:   Wed, 23 Dec 2020 07:57:03 -0800
Message-Id: <20201223155717.19556-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223155717.19556-1-chang.seok.bae@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static per-task xstate buffer contains the extended register states --
but it is not expandable at runtime. Introduce runtime methods and new fpu
struct fields to support the expansion.

fpu->state_mask indicates the saved states per task and fpu->state_ptr
points to the dynamically allocated buffer.

alloc_xstate_buffer() uses vmalloc(). If use of this mechanism grows to
allocate buffers larger than 64KB, a more sophisticated allocation scheme
that includes purpose-built reclaim capability might be justified.

Introduce a new helper -- get_xstate_size() to calculate the buffer size.

No functional change until the kernel supports dynamic user states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Updated the changelog with task->fpu removed. (Boris Petkov)
* Replaced 'area' with 'buffer' in the comments and the changelog.
* Updated the code comments.

Changes from v1:
* Removed unneeded interrupt masking (Andy Lutomirski)
* Added vmalloc() error tracing (Dave Hansen, PeterZ, and Andy Lutomirski)
---
 arch/x86/include/asm/fpu/types.h  |  29 ++++++--
 arch/x86/include/asm/fpu/xstate.h |   3 +
 arch/x86/include/asm/trace/fpu.h  |   5 ++
 arch/x86/kernel/fpu/core.c        |   3 +
 arch/x86/kernel/fpu/xstate.c      | 115 ++++++++++++++++++++++++++++++
 5 files changed, 150 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index f5a38a5f3ae1..3fc6dbbe3ede 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -336,14 +336,33 @@ struct fpu {
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
+	 * Copy of all extended register states, in a dynamically allocated
+	 * buffer. When a task is using extended features, the register state
+	 * is always the most current. This state copy is more recent than
+	 * @state. If the task context-switches away, they get saved here,
+	 * representing the xstate.
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
+	 * Copy of some extended register state. If a task uses a dynamically
+	 * allocated buffer, @state_ptr, then it has a more recent state copy
+	 * than this. This copy follows the same attributes as described for
+	 * @state_ptr.
 	 */
 	union fpregs_state		state;
 	/*
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 6ce8350672c2..379e8f8b8440 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -103,6 +103,9 @@ extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
 void *get_xsave_addr(struct fpu *fpu, int xfeature_nr);
+int alloc_xstate_buffer(struct fpu *fpu, u64 mask);
+void free_xstate_buffer(struct fpu *fpu);
+
 const void *get_xsave_field_ptr(int xfeature_nr);
 int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
index 879b77792f94..bf88b3333873 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -89,6 +89,11 @@ DEFINE_EVENT(x86_fpu, x86_fpu_xstate_check_failed,
 	TP_ARGS(fpu)
 );
 
+DEFINE_EVENT(x86_fpu, x86_fpu_xstate_alloc_failed,
+	TP_PROTO(struct fpu *fpu),
+	TP_ARGS(fpu)
+);
+
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH asm/trace/
 #undef TRACE_INCLUDE_FILE
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1a428803e6b2..6dafed34be4f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -235,6 +235,9 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
 	 */
 	memset(&dst_fpu->state.xsave, 0, fpu_kernel_xstate_min_size);
 
+	dst_fpu->state_mask = xfeatures_mask_all & ~xfeatures_mask_user_dynamic;
+	dst_fpu->state_ptr = NULL;
+
 	/*
 	 * If the FPU registers are not current just memcpy() the state.
 	 * Otherwise save current FPU registers directly into the child's FPU
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 2012b17b1793..af4d7d9aa977 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -10,6 +10,7 @@
 #include <linux/pkeys.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
+#include <linux/vmalloc.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/internal.h>
@@ -19,6 +20,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/cpufeature.h>
+#include <asm/trace/fpu.h>
 
 /*
  * Although we spell it out in here, the Processor Trace
@@ -71,6 +73,7 @@ static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] =
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_comp_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
+static bool xstate_aligns[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = false};
 
 /*
  * The XSAVE area of kernel can be in standard or compacted format;
@@ -130,6 +133,48 @@ static bool xfeature_is_supervisor(int xfeature_nr)
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
+		return fpu_kernel_xstate_min_size;
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
+	 * size found with the xstate buffer format out of the given mask.
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
@@ -270,10 +315,12 @@ static void __init setup_xstate_features(void)
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
@@ -291,6 +338,7 @@ static void __init setup_xstate_features(void)
 			continue;
 
 		xstate_offsets[i] = ebx;
+		xstate_aligns[i] = (ecx & 2) ? true : false;
 
 		/*
 		 * In our xstate size checks, we assume that the highest-numbered
@@ -755,6 +803,9 @@ static bool is_supported_xstate_size(unsigned int test_xstate_size)
 	return false;
 }
 
+/* The watched threshold size of dynamically allocated xstate buffer */
+#define XSTATE_BUFFER_MAX_BYTES		(64 * 1024)
+
 static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
@@ -779,6 +830,14 @@ static int __init init_xstate_size(void)
 	if (!is_supported_xstate_size(fpu_kernel_xstate_min_size))
 		return -EINVAL;
 
+	/*
+	 * When allocating buffers larger than the threshold, a more sophisticated
+	 * mechanism might be considerable.
+	 */
+	if (fpu_kernel_xstate_max_size > XSTATE_BUFFER_MAX_BYTES)
+		pr_warn("x86/fpu: xstate buffer too large (%u > %u)\n",
+			fpu_kernel_xstate_max_size, XSTATE_BUFFER_MAX_BYTES);
+
 	/*
 	 * User space is always in standard format.
 	 */
@@ -869,6 +928,9 @@ void __init fpu__init_system_xstate(void)
 	if (err)
 		goto out_disable;
 
+	/* Make sure init_task does not include the dynamic user states */
+	current->thread.fpu.state_mask = (xfeatures_mask_all & ~xfeatures_mask_user_dynamic);
+
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
@@ -1089,6 +1151,59 @@ static inline bool xfeatures_mxcsr_quirk(u64 xfeatures)
 	return true;
 }
 
+void free_xstate_buffer(struct fpu *fpu)
+{
+	vfree(fpu->state_ptr);
+}
+
+/*
+ * Allocate an xstate buffer with the size calculated based on 'mask'.
+ *
+ * The allocation mechanism does not shrink or reclaim the buffer.
+ */
+int alloc_xstate_buffer(struct fpu *fpu, u64 mask)
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
+		pr_warn_once("x86/fpu: xstate buffer too large (%u > %u bytes)\n",
+			     newsz, fpu_kernel_xstate_max_size);
+		XSTATE_WARN_ON(1);
+		return 0;
+	}
+
+	/* We need 64B aligned pointer, but vmalloc() returns a page-aligned address. */
+	state_ptr = vmalloc(newsz);
+	if (!state_ptr) {
+		trace_x86_fpu_xstate_alloc_failed(fpu);
+		return -ENOMEM;
+	}
+
+	memset(state_ptr, 0, newsz);
+	if (using_compacted_format())
+		fpstate_init_xstate(&state_ptr->xsave, state_mask);
+
+	/*
+	 * As long as the register state is intact, save the xstate in the new buffer
+	 * at the next context copy/switch or potentially ptrace-driven xstate writing.
+	 */
+
+	vfree(fpu->state_ptr);
+	fpu->state_ptr = state_ptr;
+	fpu->state_mask = state_mask;
+	return 0;
+}
+
 static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
 {
 	if (*last >= offset)
-- 
2.17.1

