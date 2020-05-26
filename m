Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66F01CF7F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgELOzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 10:55:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:29539 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbgELOzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:55:13 -0400
IronPort-SDR: dKltmSHjA1HTkms0/kDIYid9ssxL7KrIJgDMHKwbOMB0JVypTAcaxGNwWhGLmgB+dhjzzL6vo0
 1l3xep63VjPw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 07:55:09 -0700
IronPort-SDR: 4hPCJbsarMpb6hp1lXxnTKJ82ztBPribRIQTgPT0qR+mdnmAFLVWuYpXATa4CenFVGsq6muW2V
 otCFoOTgllLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="371587829"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2020 07:55:09 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v4 08/10] x86/fpu: Introduce copy_supervisor_to_kernel()
Date:   Tue, 12 May 2020 07:54:42 -0700
Message-Id: <20200512145444.15483-9-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200512145444.15483-1-yu-cheng.yu@intel.com>
References: <20200512145444.15483-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XSAVES instruction takes a mask and saves only the features specified
in that mask.  The kernel normally specifies that all features be saved.

XSAVES also unconditionally uses the "compacted format" which means that
all specified features are saved next to each other in memory.  If a
feature is removed from the mask, all the features after it will "move
up" into earlier locations in the buffer.

Introduce copy_supervisor_to_kernel(), which saves only supervisor states
and then moves those states into the standard location where they are
normally found.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/include/asm/fpu/xstate.h |  1 +
 arch/x86/kernel/fpu/xstate.c      | 84 +++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 92104b298d77..422d8369012a 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -75,6 +75,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned int offset, unsigned int size);
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
+void copy_supervisor_to_kernel(struct xregs_state *xsave);
 
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
 int validate_user_xstate_header(const struct xstate_header *hdr);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a68213ed5be6..587e03f0094d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -62,6 +62,7 @@ u64 xfeatures_mask_all __read_mostly;
 static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_comp_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
+static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
 
 /*
  * The XSAVE area of kernel can be in standard or compacted format;
@@ -392,6 +393,33 @@ static void __init setup_xstate_comp_offsets(void)
 	}
 }
 
+/*
+ * Setup offsets of a supervisor-state-only XSAVES buffer:
+ *
+ * The offsets stored in xstate_comp_offsets[] only work for one specific
+ * value of the Requested Feature BitMap (RFBM).  In cases where a different
+ * RFBM value is used, a different set of offsets is required.  This set of
+ * offsets is for when RFBM=xfeatures_mask_supervisor().
+ */
+static void __init setup_supervisor_only_offsets(void)
+{
+	unsigned int next_offset;
+	int i;
+
+	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+
+	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+		if (!xfeature_enabled(i) || !xfeature_is_supervisor(i))
+			continue;
+
+		if (xfeature_is_aligned(i))
+			next_offset = ALIGN(next_offset, 64);
+
+		xstate_supervisor_only_offsets[i] = next_offset;
+		next_offset += xstate_sizes[i];
+	}
+}
+
 /*
  * Print out xstate component offsets and sizes
  */
@@ -790,6 +818,7 @@ void __init fpu__init_system_xstate(void)
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
 	setup_xstate_comp_offsets();
+	setup_supervisor_only_offsets();
 	print_xstate_offset_size();
 
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
@@ -1262,6 +1291,61 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	return 0;
 }
 
+/*
+ * Save only supervisor states to the kernel buffer.  This blows away all
+ * old states, and is intended to be used only in __fpu__restore_sig(), where
+ * user states are restored from the user buffer.
+ */
+void copy_supervisor_to_kernel(struct xregs_state *xstate)
+{
+	struct xstate_header *header;
+	u64 max_bit, min_bit;
+	u32 lmask, hmask;
+	int err, i;
+
+	if (WARN_ON(!boot_cpu_has(X86_FEATURE_XSAVES)))
+		return;
+
+	if (!xfeatures_mask_supervisor())
+		return;
+
+	max_bit = __fls(xfeatures_mask_supervisor());
+	min_bit = __ffs(xfeatures_mask_supervisor());
+
+	lmask = xfeatures_mask_supervisor();
+	hmask = xfeatures_mask_supervisor() >> 32;
+	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
+
+	/* We should never fault when copying to a kernel buffer: */
+	if (WARN_ON_FPU(err))
+		return;
+
+	/*
+	 * At this point, the buffer has only supervisor states and must be
+	 * converted back to normal kernel format.
+	 */
+	header = &xstate->header;
+	header->xcomp_bv |= xfeatures_mask_all;
+
+	/*
+	 * This only moves states up in the buffer.  Start with
+	 * the last state and move backwards so that states are
+	 * not overwritten until after they are moved.  Note:
+	 * memmove() allows overlapping src/dst buffers.
+	 */
+	for (i = max_bit; i >= min_bit; i--) {
+		u8 *xbuf = (u8 *)xstate;
+
+		if (!((header->xfeatures >> i) & 1))
+			continue;
+
+		/* Move xfeature 'i' into its normal location */
+		memmove(xbuf + xstate_comp_offsets[i],
+			xbuf + xstate_supervisor_only_offsets[i],
+			xstate_sizes[i]);
+	}
+}
+
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 /*
  * Report the amount of time elapsed in millisecond since last AVX512
-- 
2.21.0

