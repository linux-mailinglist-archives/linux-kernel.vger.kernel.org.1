Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296312B9E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgKSXhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:37:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:49074 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgKSXhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:37:06 -0500
IronPort-SDR: rbgVMb5qINFvuJnb1rTo7wGy6eqNJG7hRanVtK8SVzmwtwkzSuPcPxJy+HLffht1vmEB/MPZDy
 jeXC/OZekfaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="235531202"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="235531202"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 15:37:03 -0800
IronPort-SDR: nOkcSmQWFr1VW0sFzKHT09cRT64x5tErrCBOFls+JsCwm0AswL9M9rA20EjzUmn1Njxw6SIy+u
 sDgKzqDyAw7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="431392224"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 15:37:02 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v2 11/22] x86/fpu/xstate: Update xstate area address finder for supporting dynamic user xstate
Date:   Thu, 19 Nov 2020 15:32:46 -0800
Message-Id: <20201119233257.2939-12-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119233257.2939-1-chang.seok.bae@intel.com>
References: <20201119233257.2939-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__raw_xsave_addr() returns the requested component's pointer in an XSAVE
buffer, by simply looking up the offset table. The offset used to be fixed,
but, with dynamic user states, it becomes variable.

get_xstate_size() has a routine to find an offset at run-time. Refactor to
use it for the address finder.

No functional change until the kernel enables dynamic user states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/xstate.c | 82 +++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index f8884dcdcc7c..0c0be0952194 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -133,15 +133,50 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
+/*
+ * Available once those arrays for the offset, size, and alignment info are set up,
+ * by setup_xstate_features().
+ */
+static unsigned int __get_xstate_comp_offset(u64 mask, int feature_nr)
+{
+	u64 xmask = BIT_ULL(feature_nr + 1) - 1;
+	unsigned int next_offset, offset = 0;
+	int i;
+
+	if ((mask & xmask) == (xfeatures_mask_all & xmask))
+		return xstate_comp_offsets[feature_nr];
+
+	/*
+	 * Calculate the size by summing up each state together, since no known
+	 * offset found with the xstate area format out of the given mask.
+	 */
+
+	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
+
+	for (i = FIRST_EXTENDED_XFEATURE; i <= feature_nr; i++) {
+		if (!(mask & BIT_ULL(i)))
+			continue;
+
+		offset = xstate_aligns[i] ? ALIGN(next_offset, 64) : next_offset;
+		next_offset += xstate_sizes[i];
+	}
+
+	return offset;
+}
+
+static unsigned int get_xstate_comp_offset(struct fpu *fpu, int feature_nr)
+{
+	return __get_xstate_comp_offset(fpu->state_mask, feature_nr);
+}
+
 /*
  * Available once those arrays for the offset, size, and alignment info are set up,
  * by setup_xstate_features().
  */
 unsigned int get_xstate_size(u64 mask)
 {
-	unsigned int size;
-	u64 xmask;
-	int i, nr;
+	unsigned int offset;
+	int nr;
 
 	if (!mask)
 		return 0;
@@ -155,24 +190,8 @@ unsigned int get_xstate_size(u64 mask)
 	if (!using_compacted_format())
 		return xstate_offsets[nr] + xstate_sizes[nr];
 
-	xmask = BIT_ULL(nr + 1) - 1;
-
-	if (mask == (xmask & xfeatures_mask_all))
-		return xstate_comp_offsets[nr] + xstate_sizes[nr];
-
-	/*
-	 * Calculate the size by summing up each state together, since no known
-	 * size found with the xstate area format out of the given mask.
-	 */
-	for (size = FXSAVE_SIZE + XSAVE_HDR_SIZE, i = FIRST_EXTENDED_XFEATURE; i <= nr; i++) {
-		if (!(mask & BIT_ULL(i)))
-			continue;
-
-		if (xstate_aligns[i])
-			size = ALIGN(size, 64);
-		size += xstate_sizes[i];
-	}
-	return size;
+	offset = __get_xstate_comp_offset(mask, nr);
+	return offset + xstate_sizes[nr];
 }
 
 /*
@@ -991,17 +1010,20 @@ static void *__raw_xsave_addr(struct fpu *fpu, int xfeature_nr)
 {
 	void *xsave;
 
-	if (!xfeature_enabled(xfeature_nr)) {
-		WARN_ON_FPU(1);
-		return NULL;
-	}
-
-	if (fpu)
-		xsave = __xsave(fpu);
-	else
+	if (!xfeature_enabled(xfeature_nr))
+		goto not_found;
+	else if (!fpu)
 		xsave = &init_fpstate.xsave;
+	else if (!(fpu->state_mask & BIT_ULL(xfeature_nr)))
+		goto not_found;
+	else
+		xsave = __xsave(fpu);
+
+	return (xsave + get_xstate_comp_offset(fpu, xfeature_nr));
 
-	return xsave + xstate_comp_offsets[xfeature_nr];
+not_found:
+	WARN_ON_FPU(1);
+	return NULL;
 }
 
 /*
-- 
2.17.1

