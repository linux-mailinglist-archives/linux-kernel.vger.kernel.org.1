Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EDA2808A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbgJAUnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:43:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:58718 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733053AbgJAUnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:43:17 -0400
IronPort-SDR: NQdLuPX9zuzoQs972HBQbsm3OM5onq67BdhCuCn32HpVx0HLkJkJ2GW2IoCKfFAaXtewkDvoT9
 +RILgxAHbhDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160170731"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160170731"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:52 -0700
IronPort-SDR: IWAyXY+qbv0tgThNF5Uz6Z3ytlzoCI7b7PijUDK3oD0wtZ2ry4tJwaQ/03cNUZN2UhmH/ZBecq
 qzLJBrdY1VZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="351297072"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2020 13:42:52 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [RFC PATCH 15/22] x86/fpu/xstate: Support ptracer-induced xstate area expansion
Date:   Thu,  1 Oct 2020 13:39:06 -0700
Message-Id: <20201001203913.9125-16-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001203913.9125-1-chang.seok.bae@intel.com>
References: <20201001203913.9125-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace() may request an update to task->fpu that has not yet been
allocated. Detect this case and allocate task->fpu to support the request.
Also, disable the (now unnecessary) associated first-use fault.

No functional change until the kernel supports dynamic user states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/regset.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 8d863240b9c6..6b9d0c0a266d 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -125,6 +125,35 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 
 	xsave = __xsave(fpu);
 
+	/*
+	 * When a ptracer attempts to write any state in task->fpu but not allocated,
+	 * it dynamically expands the xstate area of fpu->state_ptr.
+	 */
+	if (count > get_xstate_size(fpu->state_mask)) {
+		unsigned int offset, size;
+		struct xstate_header hdr;
+		u64 mask;
+
+		offset = offsetof(struct xregs_state, header);
+		size = sizeof(hdr);
+
+		/* Retrieve XSTATE_BV */
+		if (kbuf) {
+			memcpy(&hdr, kbuf + offset, size);
+		} else {
+			ret = __copy_from_user(&hdr, ubuf + offset, size);
+			if (ret)
+				return ret;
+		}
+
+		mask = hdr.xfeatures & xfeatures_mask_user_dynamic;
+		if (!mask) {
+			ret = alloc_xstate_area(fpu, mask, NULL);
+			if (ret)
+				return ret;
+		}
+	}
+
 	fpu__prepare_write(fpu);
 
 	if (using_compacted_format()) {
-- 
2.17.1

