Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC172808AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733154AbgJAUoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:44:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:58726 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgJAUnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:43:17 -0400
IronPort-SDR: ojZnJW8x7h7L94eFz0U/le55R1mVF2IWY/6ke+s5ny85D1CJivIht6kY8JamM1sfh9TjrQMosB
 Rem9WA3I8vEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170723"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170723"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:52 -0700
IronPort-SDR: X7Y5WjPi3sqv6Ky6yZW3O0b0WExrSqCP5Nyh4WQY3o2Rsns/4yrfyfpkQXlssK8JWMo/898cNM
 NpjATwI91XoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297059"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:52 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 11/22] x86/fpu/xstate: Update xstate area address finder for supporting dynamic user xstate
Date:   Thu,  1 Oct 2020 13:39:02 -0700
Message-Id: <20201001203913.9125-12-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__raw_xsave_addr() returns the requested component's pointer in an XSAVE
buffer, by simply looking up the offset table. The offset used to be fixed,
but, with dynamic user states, it becomes variable.

get_xstate_size() has a routine to find an offset at run-time. Refactor to
use it for the address finder.

No functional change until the kernel enables dynamic user xstates.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/xstate.c | 82 +++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d73ab3259896..556ae8593806 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -130,15 +130,50 @@ static bool xfeature_is_supervisor(int xfeature_nr)
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
@@ -152,24 +187,8 @@ unsigned int get_xstate_size(u64 mask)
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
@@ -986,17 +1005,20 @@ static void *__raw_xsave_addr(struct fpu *fpu, int xfeature_nr)
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

