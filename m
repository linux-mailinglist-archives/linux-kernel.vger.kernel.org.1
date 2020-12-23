Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12B2E1F23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgLWQC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:02:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:1574 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgLWQCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:02:53 -0500
IronPort-SDR: BwfgESa8TRUx14kZUHSKUAu+XyrpSb4UFRonUPwNiSPww+E5Dwx9ytCVNXLjbGC3+Ok5jUnAPG
 JC9JT5aA7gAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="194483187"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="194483187"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 08:01:40 -0800
IronPort-SDR: J7Rn1MsgdJh5mnJ5S9h2WjqaarqWpXluYoYUxITZDL79xGaslaLHPQE8Z0uDbOhuEHrbPM0Br4
 i0eFIWp0MbLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="458027991"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2020 08:01:40 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v3 12/21] x86/fpu/xstate: Update xstate context copy function to support dynamic buffer
Date:   Wed, 23 Dec 2020 07:57:08 -0800
Message-Id: <20201223155717.19556-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223155717.19556-1-chang.seok.bae@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace() and signal return paths use xstate context copy functions. They
allow callers to read (or write) xstate values in the target's buffer. With
dynamic user states, a component's position in the buffer may vary and the
initial value is not always stored in init_fpstate.

Change the helpers to find a component's offset accordingly.

When copying an initial value, explicitly check the init_fpstate coverage.
If not found, reset the memory in the destination. Otherwise, copy values
from init_fpstate.

No functional change until the kernel supports dynamic user states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Updated the changelog with task->fpu removed. (Boris Petkov)
---
 arch/x86/kernel/fpu/xstate.c | 55 +++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 6b863b2ca405..1d7d0cce6cc5 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -248,12 +248,14 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	if (!(xfeatures & XFEATURE_MASK_SSE))
 		memset(&fx->xmm_space[0], 0, 256);
 
+	/* Make sure 'xfeatures' to be a subset of fpu->state_mask */
+	xfeatures = ((xfeatures_mask_user() & fpu->state_mask) & ~xfeatures);
 	/*
 	 * First two features are FPU and SSE, which above we handled
 	 * in a special way already:
 	 */
 	feature_bit = 0x2;
-	xfeatures = (xfeatures_mask_user() & ~xfeatures) >> 2;
+	xfeatures >>= 0x2;
 
 	/*
 	 * Update all the remaining memory layouts according to their
@@ -262,12 +264,15 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
 	 */
 	while (xfeatures) {
 		if (xfeatures & 0x1) {
-			int offset = xstate_comp_offsets[feature_bit];
-			int size = xstate_sizes[feature_bit];
-
-			memcpy((void *)xsave + offset,
-			       (void *)&init_fpstate.xsave + offset,
-			       size);
+			unsigned int offset = get_xstate_comp_offset(fpu, feature_bit);
+			unsigned int size = xstate_sizes[feature_bit];
+
+			if (get_init_fpstate_mask() & BIT_ULL(feature_bit))
+				memcpy((void *)xsave + offset,
+				       (void *)&init_fpstate.xsave + offset,
+				       size);
+			else
+				memset((void *)xsave + offset, 0, size);
 		}
 
 		xfeatures >>= 1;
@@ -1232,7 +1237,10 @@ static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
 {
 	if (*last >= offset)
 		return;
-	membuf_write(to, (void *)&init_fpstate.xsave + *last, offset - *last);
+	if (offset <= get_init_fpstate_size())
+		membuf_write(to, (void *)&init_fpstate.xsave + *last, offset - *last);
+	else
+		membuf_zero(to, offset - *last);
 	*last = offset;
 }
 
@@ -1240,7 +1248,10 @@ static void copy_part(struct membuf *to, unsigned *last, unsigned offset,
 		      unsigned size, void *from)
 {
 	fill_gap(to, last, offset);
-	membuf_write(to, from, size);
+	if (from)
+		membuf_write(to, from, size);
+	else
+		membuf_zero(to, size);
 	*last = offset + size;
 }
 
@@ -1292,12 +1303,22 @@ void copy_xstate_to_kernel(struct membuf to, struct fpu *fpu)
 		  sizeof(header), &header);
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+		u64 mask = BIT_ULL(i);
+		void *src;
 		/*
-		 * Copy only in-use xstates:
+		 * Copy only in-use xstate at first. If the feature is enabled,
+		 * find the init value, whether stored in init_fpstate or simply
+		 * zeros, and then copy them.
 		 */
-		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(fpu, i);
-
+		if (header.xfeatures & mask) {
+			src = __raw_xsave_addr(fpu, i);
+			copy_part(&to, &last, xstate_offsets[i],
+				  xstate_sizes[i], src);
+		} else if (xfeatures_mask_user() & mask) {
+			if (get_init_fpstate_mask() & mask)
+				src = (void *)&init_fpstate.xsave + last;
+			else
+				src = NULL;
 			copy_part(&to, &last, xstate_offsets[i],
 				  xstate_sizes[i], src);
 		}
@@ -1331,6 +1352,9 @@ int copy_kernel_to_xstate(struct fpu *fpu, const void *kbuf)
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(fpu, i);
 
+			if (!dst)
+				continue;
+
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
@@ -1388,6 +1412,9 @@ int copy_user_to_xstate(struct fpu *fpu, const void __user *ubuf)
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(fpu, i);
 
+			if (!dst)
+				continue;
+
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
@@ -1470,7 +1497,7 @@ void copy_supervisor_to_kernel(struct fpu *fpu)
 			continue;
 
 		/* Move xfeature 'i' into its normal location */
-		memmove(xbuf + xstate_comp_offsets[i],
+		memmove(xbuf + get_xstate_comp_offset(fpu, i),
 			xbuf + xstate_supervisor_only_offsets[i],
 			xstate_sizes[i]);
 	}
-- 
2.17.1

