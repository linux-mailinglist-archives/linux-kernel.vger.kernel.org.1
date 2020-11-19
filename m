Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F184E2B9E77
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgKSXhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:37:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:49073 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgKSXhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:37:07 -0500
IronPort-SDR: cYx+IGq3AkAFCcrcODmu9MUMoNADXjNp6Fct8drzA+U3AmGz10zC/hNG+2W/7p6D8ccWNeKNmG
 DQI4X2TgWfyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="235531203"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="235531203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 15:37:03 -0800
IronPort-SDR: kMOch8jpkvDf+eqM54rwxun44PJykfQzzMGGfNYzHGT/pjEN1MyL+MQaCCf9DqCAWNtlb6ykek
 C+vIPTW82Epg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="431392228"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 15:37:02 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v2 12/22] x86/fpu/xstate: Update xstate context copy function for supporting dynamic area
Date:   Thu, 19 Nov 2020 15:32:47 -0800
Message-Id: <20201119233257.2939-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119233257.2939-1-chang.seok.bae@intel.com>
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are xstate context copy functions that used in ptrace() and signal
return paths. They serve callers to read (or write) xstate values in the
task->fpu's buffer or to get initial values. With dynamic user states, a
component's position in the buffer may vary and the initial value is not
always stored in init_fpstate.

Change the helpers to find a component's offset accordingly (either lookup
table or calculation).

When copying an initial value, explicitly check the init_fpstate coverage.
If not found, reset the memory in the destination. Otherwise, copy values
from init_fpstate.

No functional change until the kernel supports dynamic user states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/xstate.c | 55 +++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0c0be0952194..bd7c4135c1d0 100644
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
@@ -1239,7 +1244,10 @@ static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
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
 
@@ -1247,7 +1255,10 @@ static void copy_part(struct membuf *to, unsigned *last, unsigned offset,
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
 
@@ -1299,12 +1310,22 @@ void copy_xstate_to_kernel(struct membuf to, struct fpu *fpu)
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
@@ -1338,6 +1359,9 @@ int copy_kernel_to_xstate(struct fpu *fpu, const void *kbuf)
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(fpu, i);
 
+			if (!dst)
+				continue;
+
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
@@ -1395,6 +1419,9 @@ int copy_user_to_xstate(struct fpu *fpu, const void __user *ubuf)
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(fpu, i);
 
+			if (!dst)
+				continue;
+
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
@@ -1477,7 +1504,7 @@ void copy_supervisor_to_kernel(struct fpu *fpu)
 			continue;
 
 		/* Move xfeature 'i' into its normal location */
-		memmove(xbuf + xstate_comp_offsets[i],
+		memmove(xbuf + get_xstate_comp_offset(fpu, i),
 			xbuf + xstate_supervisor_only_offsets[i],
 			xstate_sizes[i]);
 	}
-- 
2.17.1

