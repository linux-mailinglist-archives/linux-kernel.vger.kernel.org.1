Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DED02E1F28
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgLWQDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:03:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:1574 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729042AbgLWQDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:03:13 -0500
IronPort-SDR: 1uOe042ujZuzo5plTXoDKxy0PnpmgrkDjUk4TrXE1MfmSVg5d9EDL6UcdzPdmrxBXjty9Wm6I3
 CKgloX1yVYGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="194483190"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="194483190"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 08:01:40 -0800
IronPort-SDR: 8KAXL5EUsdSfiA9wqfkcVXRRuau6av5sQEIQjooC97mgbij9NnsCbQ0aC8OjpJC4go0p90rnOI
 phfe4/DnHedA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="458027999"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2020 08:01:40 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v3 14/21] x86/fpu/xstate: Support ptracer-induced xstate buffer expansion
Date:   Wed, 23 Dec 2020 07:57:10 -0800
Message-Id: <20201223155717.19556-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223155717.19556-1-chang.seok.bae@intel.com>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace() may update xstate data before the target task has taken an XFD
fault and expanded the context switch buffer. Detect this case and allocate
a sufficient buffer to support the request. Also, disable the (now
unnecessary) associated first-use fault.

No functional change until the kernel supports dynamic user states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Updated the changelog with task->fpu removed. (Boris Petkov)
* Updated the code comments.
---
 arch/x86/kernel/fpu/regset.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 8d863240b9c6..16ff8ac765c1 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -125,6 +125,35 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 
 	xsave = __xsave(fpu);
 
+	/*
+	 * When a ptracer attempts to write any state in the target buffer but not
+	 * sufficiently allocated, it dynamically expands the buffer.
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
+			ret = alloc_xstate_buffer(fpu, mask);
+			if (ret)
+				return ret;
+		}
+	}
+
 	fpu__prepare_write(fpu);
 
 	if (using_compacted_format()) {
-- 
2.17.1

