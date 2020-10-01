Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660B228089E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbgJAUnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:43:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:58716 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbgJAUnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:43:17 -0400
IronPort-SDR: Y2JXpjktNGiJeFsKvnKfSqBpw3EHWsNgyr5Z9GYgLWJ6ZtL9+pcyn9jczLDGipaNmD4b1cwRJa
 L83/DfrZ5c2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170726"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:52 -0700
IronPort-SDR: pRU4Qf3ITQmAjmuFukubNJCzau0ZBcnJ5avcfUuI1SD/T3LFQmMnj/O8XZ4P7qVdDrwenn7R54
 IyRmtIiWiqUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297062"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:52 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 12/22] x86/fpu/xstate: Update xstate context copy function for supporting dynamic area
Date:   Thu,  1 Oct 2020 13:39:03 -0700
Message-Id: <20201001203913.9125-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are xstate context copy functions that used in ptrace() and signal
return paths. They serve callers to read (or write) xstate values in the
task->fpu's buffer, or to get initial values. With dynamic user states, a
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
index 556ae8593806..b9261ab4e5e2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -245,12 +245,14 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
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
@@ -259,12 +261,15 @@ void fpstate_sanitize_xstate(struct fpu *fpu)
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
@@ -1238,7 +1243,10 @@ static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
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
 
@@ -1246,7 +1254,10 @@ static void copy_part(struct membuf *to, unsigned *last, unsigned offset,
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
 
@@ -1298,12 +1309,22 @@ void copy_xstate_to_kernel(struct membuf to, struct fpu *fpu)
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
@@ -1337,6 +1358,9 @@ int copy_kernel_to_xstate(struct fpu *fpu, const void *kbuf)
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(fpu, i);
 
+			if (!dst)
+				continue;
+
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
@@ -1394,6 +1418,9 @@ int copy_user_to_xstate(struct fpu *fpu, const void __user *ubuf)
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(fpu, i);
 
+			if (!dst)
+				continue;
+
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
@@ -1476,7 +1503,7 @@ void copy_supervisor_to_kernel(struct fpu *fpu)
 			continue;
 
 		/* Move xfeature 'i' into its normal location */
-		memmove(xbuf + xstate_comp_offsets[i],
+		memmove(xbuf + get_xstate_comp_offset(fpu, i),
 			xbuf + xstate_supervisor_only_offsets[i],
 			xstate_sizes[i]);
 	}
-- 
2.17.1

