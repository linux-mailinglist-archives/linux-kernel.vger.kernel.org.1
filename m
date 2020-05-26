Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C991CF7F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgELOzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 10:55:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:29539 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbgELOzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:55:11 -0400
IronPort-SDR: IS33D0Pu2tP4xaNZvgAnMog90nMLzLLNEWPRvmgx0D1govkq0QrT4uYC4C55mkRphEJxs7rwfM
 /1mGQ5myeo0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 07:55:08 -0700
IronPort-SDR: PSs6QCveZHwyPEYofmj0EmosgL3IDcDrwVJVz71D/3HKvysyQYH1zZeoFTXZPmUkcsLJPMhQQJ
 ikLtPrpCZt+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; 
   d="scan'208";a="371587804"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2020 07:55:08 -0700
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
Subject: [PATCH v4 02/10] x86/fpu/xstate: Define new macros for supervisor and user xstates
Date:   Tue, 12 May 2020 07:54:36 -0700
Message-Id: <20200512145444.15483-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200512145444.15483-1-yu-cheng.yu@intel.com>
References: <20200512145444.15483-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

XCNTXT_MASK is 'all supported xfeatures' before introducing supervisor
xstates.  Rename it to XFEATURE_MASK_USER_SUPPORTED to make clear that
these are user xstates.

XFEATURE_MASK_SUPERVISOR is replaced with the following:
- XFEATURE_MASK_SUPERVISOR_SUPPORTED: Currently nothing.  ENQCMD and
  Control-flow Enforcement Technology (CET) will be introduced in separate
  series.
- XFEATURE_MASK_SUPERVISOR_UNSUPPORTED: Currently only Processor Trace.
- XFEATURE_MASK_SUPERVISOR_ALL: the combination of above.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v3:
- Change SUPPORTED_XFEATURES_*, UNSUPPORTED_XFEATURES_*, ALL_XFEATURES_* to
  XFEATURE_MASK_*.

 arch/x86/include/asm/fpu/xstate.h | 36 ++++++++++++++++++++-----------
 arch/x86/kernel/fpu/init.c        |  3 ++-
 arch/x86/kernel/fpu/xstate.c      | 26 +++++++++++-----------
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index fc4db51f3b53..b08fa823425f 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -21,19 +21,29 @@
 #define XSAVE_YMM_SIZE	    256
 #define XSAVE_YMM_OFFSET    (XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET)
 
-/* Supervisor features */
-#define XFEATURE_MASK_SUPERVISOR (XFEATURE_MASK_PT)
-
-/* All currently supported features */
-#define XCNTXT_MASK		(XFEATURE_MASK_FP | \
-				 XFEATURE_MASK_SSE | \
-				 XFEATURE_MASK_YMM | \
-				 XFEATURE_MASK_OPMASK | \
-				 XFEATURE_MASK_ZMM_Hi256 | \
-				 XFEATURE_MASK_Hi16_ZMM	 | \
-				 XFEATURE_MASK_PKRU | \
-				 XFEATURE_MASK_BNDREGS | \
-				 XFEATURE_MASK_BNDCSR)
+/* All currently supported user features */
+#define XFEATURE_MASK_USER_SUPPORTED (XFEATURE_MASK_FP | \
+				      XFEATURE_MASK_SSE | \
+				      XFEATURE_MASK_YMM | \
+				      XFEATURE_MASK_OPMASK | \
+				      XFEATURE_MASK_ZMM_Hi256 | \
+				      XFEATURE_MASK_Hi16_ZMM	 | \
+				      XFEATURE_MASK_PKRU | \
+				      XFEATURE_MASK_BNDREGS | \
+				      XFEATURE_MASK_BNDCSR)
+
+/* All currently supported supervisor features */
+#define XFEATURE_MASK_SUPERVISOR_SUPPORTED (0)
+
+/*
+ * Unsupported supervisor features. When a supervisor feature in this mask is
+ * supported in the future, move it to the supported supervisor feature mask.
+ */
+#define XFEATURE_MASK_SUPERVISOR_UNSUPPORTED (XFEATURE_MASK_PT)
+
+/* All supervisor states including supported and unsupported states. */
+#define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
+				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
 #ifdef CONFIG_X86_64
 #define REX_PREFIX	"0x48, "
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 6ce7e0a23268..61ddc3a5e5c2 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -224,7 +224,8 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  */
 u64 __init fpu__get_supported_xfeatures_mask(void)
 {
-	return XCNTXT_MASK;
+	return XFEATURE_MASK_USER_SUPPORTED |
+	       XFEATURE_MASK_SUPERVISOR_SUPPORTED;
 }
 
 /* Legacy code to initialize eager fpu mode. */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 8ed64397c78b..9997df717339 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -208,14 +208,13 @@ void fpu__init_cpu_xstate(void)
 	if (!boot_cpu_has(X86_FEATURE_XSAVE) || !xfeatures_mask)
 		return;
 	/*
-	 * Make it clear that XSAVES supervisor states are not yet
-	 * implemented should anyone expect it to work by changing
-	 * bits in XFEATURE_MASK_* macros and XCR0.
+	 * Unsupported supervisor xstates should not be found in
+	 * the xfeatures mask.
 	 */
-	WARN_ONCE((xfeatures_mask & XFEATURE_MASK_SUPERVISOR),
-		"x86/fpu: XSAVES supervisor states are not yet implemented.\n");
+	WARN_ONCE((xfeatures_mask & XFEATURE_MASK_SUPERVISOR_UNSUPPORTED),
+		  "x86/fpu: Found unsupported supervisor xstates.\n");
 
-	xfeatures_mask &= ~XFEATURE_MASK_SUPERVISOR;
+	xfeatures_mask &= ~XFEATURE_MASK_SUPERVISOR_UNSUPPORTED;
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
 	xsetbv(XCR_XFEATURE_ENABLED_MASK, xfeatures_mask);
@@ -438,7 +437,7 @@ static int xfeature_uncompacted_offset(int xfeature_nr)
 	 * format. Checking a supervisor state's uncompacted offset is
 	 * an error.
 	 */
-	if (XFEATURE_MASK_SUPERVISOR & BIT_ULL(xfeature_nr)) {
+	if (XFEATURE_MASK_SUPERVISOR_ALL & BIT_ULL(xfeature_nr)) {
 		WARN_ONCE(1, "No fixed offset for xstate %d\n", xfeature_nr);
 		return -1;
 	}
@@ -475,7 +474,7 @@ int using_compacted_format(void)
 int validate_user_xstate_header(const struct xstate_header *hdr)
 {
 	/* No unknown or supervisor features may be set */
-	if (hdr->xfeatures & (~xfeatures_mask | XFEATURE_MASK_SUPERVISOR))
+	if (hdr->xfeatures & ~(xfeatures_mask & XFEATURE_MASK_USER_SUPPORTED))
 		return -EINVAL;
 
 	/* Userspace must use the uncompacted format */
@@ -768,7 +767,8 @@ void __init fpu__init_system_xstate(void)
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
 	 */
-	update_regset_xstate_info(fpu_user_xstate_size,	xfeatures_mask & ~XFEATURE_MASK_SUPERVISOR);
+	update_regset_xstate_info(fpu_user_xstate_size,
+				  xfeatures_mask & XFEATURE_MASK_USER_SUPPORTED);
 
 	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
@@ -996,7 +996,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= ~XFEATURE_MASK_SUPERVISOR;
+	header.xfeatures &= XFEATURE_MASK_USER_SUPPORTED;
 
 	/*
 	 * Copy xregs_state->header:
@@ -1080,7 +1080,7 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
 	 */
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= ~XFEATURE_MASK_SUPERVISOR;
+	header.xfeatures &= XFEATURE_MASK_USER_SUPPORTED;
 
 	/*
 	 * Copy xregs_state->header:
@@ -1173,7 +1173,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 	 * The state that came in from userspace was user-state only.
 	 * Mask all the user states out of 'xfeatures':
 	 */
-	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR;
+	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR_ALL;
 
 	/*
 	 * Add back in the features that came in from userspace:
@@ -1229,7 +1229,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 	 * The state that came in from userspace was user-state only.
 	 * Mask all the user states out of 'xfeatures':
 	 */
-	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR;
+	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR_ALL;
 
 	/*
 	 * Add back in the features that came in from userspace:
-- 
2.21.0

